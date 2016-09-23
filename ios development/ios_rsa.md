iOS中使用RSA对数据进行加密解密
---

[RSA][RSA]算法是一种非对称加密算法,常被用于加密数据传输.如果配合上数字摘要算法, 也可以用于文件签名.	

本文将讨论如何在iOS中使用RSA传输加密数据.	

本文环境
===

* mac os 
* [openssl-1.0.1j][openssl], openssl需要使用1.x版本, 推荐使用[homebrew](http://brew.sh/)安装.	
* Java 8

RSA基本原理
===

RSA使用"秘匙对"对数据进行加密解密.在加密解密数据前,需要先生成公钥(public key)和私钥(private key).		

* 公钥(public key): 用于加密数据. 用于公开, 一般存放在数据提供方, 例如iOS客户端.
* 私钥(private key): 用于解密数据. 必须保密, 私钥泄露会造成安全问题.

iOS中的Security.framework提供了对RSA算法的支持.这种方式需要对密匙对进行处理, 根据public key生成证书, 通过private key生成p12格式的密匙.	
除了Secruty.framework, 也可以将[openssl库编译到iOS工程中](https://github.com/x2on/OpenSSL-for-iPhone), 这可以提供更灵活的使用方式.	

本文使用Security.framework的方式处理RSA.


使用openssl生成密匙对
===

Github Gist: <https://gist.github.com/lvjian700/635368d6f1e421447680>	

	#!/usr/bin/env bash
	echo "Generating RSA key pair ..."
	echo "1024 RSA key: private_key.pem"
	openssl genrsa -out private_key.pem 1024

	echo "create certification require file: rsaCertReq.csr"
	openssl req -new -key private_key.pem -out rsaCertReq.csr

	echo "create certification using x509: rsaCert.crt"
	openssl x509 -req -days 3650 -in rsaCertReq.csr -signkey private_key.pem -out rsaCert.crt

	echo "create public_key.der For IOS"
	openssl x509 -outform der -in rsaCert.crt -out public_key.der

	echo "create private_key.p12 For IOS. Please remember your password. The password will be used in iOS."
	openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt

	echo "create rsa_public_key.pem For Java"
	openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout
	echo "create pkcs8_private_key.pem For Java"
	openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt

	echo "finished."	

Tips:	

* 在创建证书的时候, terminal会提示输入证书信息. 根据wizard输入对应信息就OK. 
* 在创建p12密匙时, 会提示输入密码, 此时的密码必须记住, 之后会用到.	
* 如果上面指令有问题,请参考最新的openssl官方文档, 以官方的为准. 之前在网上搜索指令, 被坑了一圈之后, 还是会到啃官方文档上. 每条指令文档在最后都会有几个sample,参考sample即可.	


iOS如何加载使用证书
===
G
将下面代码添加到项目中:	
<https://gist.github.com/lvjian700/204c23226fdffd6a505d> 

代码依赖[Base64编码库](https://github.com/nicklockwood/Base64), 如果使用cocoapods, 可以讲下面依赖添加到Podfile:		

	pod 'Base64nl', '~> 1.2'	

###加密数据

	RSAEncryptor *rsa = [[RSAEncryptor alloc] init];

    NSLog(@"encryptor using rsa");
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSLog(@"public key: %@", publicKeyPath);
    [rsa loadPublicKeyFromFile:publicKeyPath];

    NSString *securityText = @"hello ~";
    NSString *encryptedString = [rsa rsaEncryptString:securityText];
    NSLog(@"encrypted data: %@", encryptedString);	

__[rsa rsaEncryptString:securityText]__会返回decrypted base64编码的字符串:	

	encrypted data: I1Mnu33cU7QcgaC9uo2bxV0vyfJSqAwyC3DZ+p8jm0G2EmcClarrR5R2xLDdXqvtKj+UJbES7TT+AgkK1NDoQvOJBY+jkmrpAchmRbV2jvi3cEZYQG955jrdSAu21NzQe8xWtEc3YzP+TACPdP4B3Cyy0u8N2RcSFWyxu0YKPXE=	


###解密数据		

在iOS下解码需要先加载private key, 之后在对数据解码. 解码的时候先进行Base64 decode, 之后在用private key decrypt加密数据.	


	NSLog(@"decryptor using rsa");
    [rsa loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@"123456"];
    NSString *decryptedString = [rsa rsaDecryptString:encryptedString];
    NSLog(@"decrypted data: %@", decryptedString);	

之后会输出解密后的数据:	

	decryptor using rsa
	decrypted data: hello ~	


在服务器端解码数据(Java)
===

在Java中解码需要使用下述指令生成的pkcs8 private key:	

	openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt

具体解码步骤:	

1. 加载pkcs8 private key:
	1. 读取private key文件
	2. 去掉private key头尾的"-----BEGIN PRIVATE KEY-----"和"-----BEGIN PRIVATE KEY-----"
	3. 删除private key中的换行
	4. 对处理后的数据进行Base64解码
	5. 使用解码后的数据生成private key.
2. 解密数据:
	1. 对数据进行Base64解码
	2. 使用RSA decrypt数据.

这里我们将iOS中"hello ~"加密的数据在Java中进行解码:	

	import javax.crypto.BadPaddingException;
	import javax.crypto.Cipher;
	import javax.crypto.IllegalBlockSizeException;
	import javax.crypto.NoSuchPaddingException;
	import java.io.IOException;
	import java.nio.charset.Charset;
	import java.nio.file.Files;
	import java.nio.file.Paths;
	import java.security.InvalidKeyException;
	import java.security.KeyFactory;
	import java.security.NoSuchAlgorithmException;
	import java.security.PrivateKey;
	import java.security.spec.InvalidKeySpecException;
	import java.security.spec.PKCS8EncodedKeySpec;
	import java.util.Base64;

	import static java.lang.String.format;

	public class Encryptor {

		public static void main(String[] args) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
			PrivateKey privateKey = readPrivateKey();

			String message = "AFppaFPTbmboMZD55cjCfrVaWUW7+hZkaq16Od+6fP0lwz/yC+Rshb/8cf5BpBlUao2EunchnzeKxzpiPqtCcCITKvk6HcFKZS0sN9wOhlQFYT+I4f/CZITwBVAJaldZ7mkyOiuvM+raXMwrS+7MLKgYXkd5cFPxEsTxpMSa5Nk=";
			System.out.println(format("- decrypt rsa encrypted base64 message: %s", message));
			// hello ~,  encrypted and encoded with Base64:
			byte[] data = encryptedData(message);
			String text = decrypt(privateKey, data);
			System.out.println(text);
		}

		private static String decrypt(PrivateKey privateKey, byte[] data) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
			Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedData = cipher.doFinal(data);

			return new String(decryptedData);
		}

		private static byte[] encryptedData(String base64Text) {
			return Base64.getDecoder().decode(base64Text.getBytes(Charset.forName("UTF-8")));
		}

		private static PrivateKey readPrivateKey() throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
			byte[] privateKeyData = Files.readAllBytes(
					Paths.get("/Users/twer/macspace/ios_workshop/Security/SecurityLogin/tools/pkcs8_private_key.pem"));

			byte[] decodedKeyData = Base64.getDecoder()
					.decode(new String(privateKeyData)
							.replaceAll("-----\\w+ PRIVATE KEY-----", "")
							.replace("\n", "")
							.getBytes());

			return KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(decodedKeyData));
		}
	}	

直行成功后控制台会输出"hello ~".	

总结
===

这种加密传输方式会被用在网银类App中.虽然网银会采用全站https方案, 但是在安全登录这块会使用另一个证书对登录信息加密, 这样可以双层确保数据安全.	

基于RSA加密解密算法, 还可以将其运用在数字签名场景.以后有空在聊如何使用RSA算法实现对文件的数字签名.	

参考资料
===

* [Openssl document](https://www.openssl.org/docs/)
* [Load Private Key in Java](http://stackoverflow.com/questions/16233854/invalidkeyspecexeption-when-loadding-the-rsa-private-key-from-file)	
* [Cryptographic Services Guide](https://developer.apple.com/library/mac/documentation/Security/Conceptual/cryptoservices/GeneralPurposeCrypto/GeneralPurposeCrypto.html)

[RSA]: http://en.wikipedia.org/wiki/RSA_(cryptosystem) "RSA Wikipedia"
[openssl]: https://www.openssl.org/docs/ "openssl"
