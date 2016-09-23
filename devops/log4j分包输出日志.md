#Log4j分包输出日志

##前言

Log4j是我从接触Java以来一直使用的日志组件。由于Log4j的简单，易用，导致我工作至今始终没有在意过Log4j的配置问题。到现在还在使用一中配置来应对所有项目：    

    log4j.appender.stdout=org.apache.log4j.ConsoleAppender
    log4j.appender.stdout.Target=System.out
    log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
    log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
    
    ### direct messages to file hibernate.log ###
    log4j.appender.file=org.apache.log4j.DailyRollingFileAppender
    log4j.appender.file.File=ipadserver.log
    log4j.appender.file.DatePattern = '.'yyyy-MM-dd
    log4j.appender.file.layout=org.apache.log4j.PatternLayout
    log4j.appender.file.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
    
    log4j.rootLogger=info, stdout, file
    
随着项目的增长，日志文件变得非常庞大，使得定为问题编单异常困难。上面这个简单的配置带来的问题会让人很头疼:    

* 所有包都采用一个日志等级，会打印出很多无效信息。有些需要info,有些需要error即可，从这个配置中无法区分
* 将rootLogger中的info调整成debug之后，hibernate,spring等框架的debug信息也会打印出来。
* 所有日志信息都存在一个文件中，虽然能够按时间归类，但是每天十几兆的日志也够人头疼的。    

被以上问题折腾了很久。今天对Log4j分包输出日志做了研究。  
(如果你希望全面了解log4j，可以直接进这个传送门: <http://blog.csdn.net/anlina_1984/article/details/5313023>)    

##Log4j分包控制研究

###步骤

1. 在项目中创建4个包，分别是 log4.debug/error/info/warning
2. 在每个包下创建输出日志的测试代码: 

        log.debug("Debug in Debug Level");
        log.info("Info in Debug Level");
        log.warn("Warn in Debug Level");
        log.error("Error in Debug Level");
        
3. 在MainClass中调用日志输出:
    
        package lv.showcase.log4j;
    
        import lombok.extern.log4j.Log4j;
        import lv.showcase.log4j.debug.DebugLog;
        import lv.showcase.log4j.error.ErrorLog;
        import lv.showcase.log4j.info.InfoLog;
        import lv.showcase.log4j.warning.WarnLog;
        
        @Log4j
        public class Main {
        
            public static void main(String[] args) {
                log.info("========== Log4j Showcase :");
                log.debug("You can not see this message in info level.");
                DebugLog.log();
                InfoLog.log();
                WarnLog.log();
                ErrorLog.log();
            }
        }

4. 采用如下log4j配置来控制日志输出:

        log4j.appender.stdout=org.apache.log4j.ConsoleAppender
        log4j.appender.stdout.Target=System.out
        log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
        log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
        
        log4j.appender.file=org.apache.log4j.FileAppender
        log4j.appender.file.File=log4j_showcase.log
        log4j.appender.file.layout=org.apache.log4j.PatternLayout
        log4j.appender.file.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
        
        log4j.appender.R1=org.apache.log4j.FileAppender
        log4j.appender.R1.File=main.log
        log4j.appender.R1.layout=org.apache.log4j.PatternLayout
        log4j.appender.R1.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %5p %c{1}:%L - %m%n
        
        log4j.logger.lv.showcase.log4j.debug=debug, stdout, file
        log4j.logger.lv.showcase.log4j.error=error, stdout, file
        log4j.logger.lv.showcase.log4j.info=info, stdout, file
        log4j.logger.lv.showcase.log4j.warning=warn, stdout, file
        
        #Main函数的日志会输出到main.log文件中
        log4j.logger.lv.showcase.log4j.Main=info, stdout, R1        


###上述log4j配置做了这几个事情

1. 定义3中输出方式: stdout(标准输出), file(输出到log4_showcase.log), R1(输出到main.log)
2. 使用log4j.logger.{package}=? 方式控制每个包的输出等级, 输出方式采用stdout, file这两种输出方式
3. 使用log4j.logger.{package}.{className}=? 方式控制单个类的输出等级，输出方式采用stdout, main

###输出结果    

控制台:    

     [java] 2013-08-06 10:22:01,684  INFO Main:? - ========== Log4j Showcase :
     [java] 2013-08-06 10:22:01,688 DEBUG DebugLog:? - Debug in Debug Level
     [java] 2013-08-06 10:22:01,689  INFO DebugLog:? - Info in Debug Level
     [java] 2013-08-06 10:22:01,689  WARN DebugLog:? - Warn in Debug Level
     [java] 2013-08-06 10:22:01,690 ERROR DebugLog:? - Error in Debug Level
     [java] 2013-08-06 10:22:01,691  INFO InfoLog:? - Info in Info Level
     [java] 2013-08-06 10:22:01,691  WARN InfoLog:? - Warn in Info Level
     [java] 2013-08-06 10:22:01,692 ERROR InfoLog:? - Error in Info Level
     [java] 2013-08-06 10:22:01,693  WARN WarnLog:? - Warn in Warning Level
     [java] 2013-08-06 10:22:01,693 ERROR WarnLog:? - Error in Warning Level
     [java] 2013-08-06 10:22:01,694 ERROR ErrorLog:? - Error in Error Level

Main.log 输出:    

    2013-08-06 10:22:01,684  INFO Main:? - ========== Log4j Showcase :
    

log4_showcase.log 输出:    

    2013-08-06 10:22:01,688 DEBUG DebugLog:? - Debug in Debug Level
    2013-08-06 10:22:01,689  INFO DebugLog:? - Info in Debug Level
    2013-08-06 10:22:01,689  WARN DebugLog:? - Warn in Debug Level
    2013-08-06 10:22:01,690 ERROR DebugLog:? - Error in Debug Level
    2013-08-06 10:22:01,691  INFO InfoLog:? - Info in Info Level
    2013-08-06 10:22:01,691  WARN InfoLog:? - Warn in Info Level
    2013-08-06 10:22:01,692 ERROR InfoLog:? - Error in Info Level
    2013-08-06 10:22:01,693  WARN WarnLog:? - Warn in Warning Level
    2013-08-06 10:22:01,693 ERROR WarnLog:? - Error in Warning Level


##总结    

* 实际应用中可以配置多个appender，按照模块将日志分成不同文件
* Log4j的日志输出支持按包/类制定级别, 配置方式:
    * log4j.logger.{package}.{className}    
* 随着项目的演进需要对日志文件进行划分，否则这样生成的日志会让后期日志分析工作变成噩梦    







