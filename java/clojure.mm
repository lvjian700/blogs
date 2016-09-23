<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1424571312806" ID="ID_663082379" MODIFIED="1424571316226" TEXT="clojure">
<node CREATED="1424598409896" ID="ID_1484843039" MODIFIED="1424598414329" POSITION="right" TEXT="Learning Doc">
<node CREATED="1424598454183" ID="ID_1034911669" MODIFIED="1424598467901" TEXT="Clojure - Functional Programming for the JVM">
<node CREATED="1424598493399" ID="ID_360606906" MODIFIED="1424598494073" TEXT="http://java.ociweb.com/mark/clojure/article.html"/>
</node>
<node CREATED="1424598422105" ID="ID_80919214" MODIFIED="1424598440951" TEXT="cheatsheet">
<node CREATED="1424598441463" ID="ID_803568946" MODIFIED="1424598442519" TEXT="http://conj.io/"/>
<node CREATED="1424598442886" ID="ID_99709488" MODIFIED="1424598450686" TEXT="http://clojure.org/cheatsheet"/>
</node>
<node CREATED="1424598597573" ID="ID_1998339436" MODIFIED="1424598605901" TEXT="Dash + Clojure Doc"/>
</node>
<node CREATED="1424598341194" ID="ID_1716642708" MODIFIED="1424598376314" POSITION="right" TEXT="Evniroment">
<node CREATED="1424598378220" ID="ID_1126427008" MODIFIED="1424598380227" TEXT="build">
<node CREATED="1424598380520" ID="ID_117181517" MODIFIED="1424598839523" TEXT="Leiningen(recommend to install using homebrew)"/>
</node>
<node CREATED="1424571316524" ID="ID_767601388" MODIFIED="1424598547368" TEXT="Intellij + Cursive">
<node CREATED="1424598352132" ID="ID_746956562" MODIFIED="1424598535582" TEXT="https://cursiveclojure.com/"/>
<node CREATED="1424571319175" ID="ID_1452230999" MODIFIED="1424571324670" TEXT="REPL">
<node CREATED="1424571325149" ID="ID_824479711" MODIFIED="1424571338821" TEXT="Load file in REPL"/>
<node CREATED="1424571412748" ID="ID_141864379" MODIFIED="1424571418055" TEXT="Sync file in REPL"/>
<node CREATED="1424571658905" ID="ID_40587199" MODIFIED="1424571676811" TEXT="switch REPL Ns to current file"/>
</node>
</node>
</node>
<node CREATED="1424590421268" ID="ID_1467404096" MODIFIED="1424590434683" POSITION="right" TEXT="grammer">
<node CREATED="1424593152914" ID="ID_538223690" MODIFIED="1424593157066" TEXT="namespace">
<node CREATED="1424593157339" ID="ID_344003819" MODIFIED="1424598249880" TEXT="(require &apos;clojure-app.core)"/>
<node CREATED="1424593162673" ID="ID_1847388939" MODIFIED="1424598236923" TEXT="(ns clojure-app.core)"/>
</node>
<node CREATED="1424590435312" ID="ID_185741664" MODIFIED="1424590437339" TEXT="Vars">
<node CREATED="1424590445157" ID="ID_192018847" MODIFIED="1424590446179" TEXT="def">
<node CREATED="1424590449788" ID="ID_233045931" MODIFIED="1424598268800" TEXT="(def ^:dynamic v 1)"/>
<node CREATED="1424598271623" ID="ID_25878031" MODIFIED="1424598278384" TEXT="(def v 4)"/>
</node>
<node CREATED="1424590458897" ID="ID_1581153826" MODIFIED="1424590459841" TEXT="let">
<node CREATED="1424598315901" ID="ID_1796346714" MODIFIED="1424598320572" TEXT="(let [v 2])"/>
</node>
<node CREATED="1424590460083" ID="ID_705920974" MODIFIED="1424590465025" TEXT="binding">
<node CREATED="1424598309445" ID="ID_359371570" MODIFIED="1424598310117" TEXT="(binding [v 3]  (do something) ) "/>
</node>
</node>
<node CREATED="1424595661278" ID="ID_1106078233" MODIFIED="1424595663681" TEXT="Collections">
<node CREATED="1424595796673" ID="ID_713689516" MODIFIED="1424595799224" TEXT="features">
<node CREATED="1424595799518" ID="ID_900276267" MODIFIED="1424595803440" TEXT="immutable">
<node CREATED="1424595850467" ID="ID_107112156" MODIFIED="1424595866291" TEXT="their contents cannot be changed"/>
</node>
<node CREATED="1424595803740" ID="ID_139247078" MODIFIED="1424595822518" TEXT="heterogeneous">
<node CREATED="1424595876061" ID="ID_363753095" MODIFIED="1424595888532" TEXT="they can hold any kind of object"/>
</node>
<node CREATED="1424595823932" ID="ID_385578586" MODIFIED="1424595836325" TEXT="persistent">
<node CREATED="1424595889658" ID="ID_391656312" MODIFIED="1424595972523" TEXT="old versions of them are preserved when new versions are created "/>
</node>
</node>
<node CREATED="1424595791154" ID="ID_1507330147" MODIFIED="1424595793481" TEXT="type">
<node CREATED="1424595670202" ID="ID_310494208" MODIFIED="1424595671257" TEXT="list"/>
<node CREATED="1424595671450" ID="ID_1120437360" MODIFIED="1424595673497" TEXT="vectors"/>
<node CREATED="1424595675711" ID="ID_1364996562" MODIFIED="1424595678672" TEXT="set"/>
<node CREATED="1424595679112" ID="ID_954017412" MODIFIED="1424595679840" TEXT="map"/>
</node>
<node CREATED="1424596399290" ID="ID_422240965" MODIFIED="1424596406986" TEXT="pop function">
<node CREATED="1424596407690" ID="ID_1223273311" MODIFIED="1424596505367" TEXT="(count [1 2 3])"/>
<node CREATED="1424596417826" ID="ID_877530914" MODIFIED="1424596504815" TEXT="(reverse [1 2 3 4])"/>
<node CREATED="1424596506336" ID="ID_907724866" MODIFIED="1424596507142" TEXT="map">
<node CREATED="1424596610808" ID="ID_502193991" MODIFIED="1424596611768" TEXT="(map #(+ % 3) [2 3 4 5])"/>
<node CREATED="1424596621461" ID="ID_814506777" MODIFIED="1424596635771" TEXT="(map + [1 2] [3 4] [5 6 7 8]) ;=&gt; [9 12]"/>
</node>
<node CREATED="1424597121811" ID="ID_1895120352" MODIFIED="1424597123554" TEXT="apply">
<node CREATED="1424597124019" ID="ID_88130681" MODIFIED="1424597138646" TEXT="(apply + [1 2 3 4]) ;=&gt; 10"/>
</node>
</node>
<node CREATED="1424597327593" ID="ID_1650066490" MODIFIED="1424597328378" TEXT="(def stooges [&quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot; &quot;Shemp&quot;])">
<node CREATED="1424597495866" ID="ID_1174667389" MODIFIED="1424597551405" TEXT="retrieve single item">
<node CREATED="1424597334369" ID="ID_1341269994" MODIFIED="1424597335161" TEXT="(first stooges) ; -&gt; &quot;Moe&quot;"/>
<node CREATED="1424597339362" ID="ID_1100483317" MODIFIED="1424597340313" TEXT="(second stooges) ; -&gt; &quot;Larry&quot;"/>
<node CREATED="1424597344560" ID="ID_1081883529" MODIFIED="1424597345184" TEXT="(last stooges) ; -&gt; &quot;Shemp&quot;"/>
<node CREATED="1424597349615" ID="ID_58914189" MODIFIED="1424597350264" TEXT="(nth stooges 2) ; indexes start at 0 -&gt; &quot;Curly&quot;"/>
</node>
<node CREATED="1424597516850" ID="ID_324184014" MODIFIED="1424597524543" TEXT="retrieve serval items">
<node CREATED="1424597470586" ID="ID_839468992" MODIFIED="1424597471437" TEXT="(next stooges) ; -&gt; (&quot;Larry&quot; &quot;Curly&quot; &quot;Shemp&quot;)"/>
<node CREATED="1424597570237" ID="ID_120451450" MODIFIED="1424597570892" TEXT="(butlast stooges) ; -&gt; (&quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot;)"/>
<node CREATED="1424597578982" ID="ID_1738892070" MODIFIED="1424597579926" TEXT="(drop-last 2 stooges) ; -&gt; (&quot;Moe&quot; &quot;Larry&quot;)"/>
<node CREATED="1424597726628" ID="ID_1204881388" MODIFIED="1424597727317" TEXT="(filter #(&gt; (count %) 3) stooges) ; -&gt; (&quot;Larry&quot; &quot;Curly&quot; &quot;Shemp&quot;)"/>
<node CREATED="1424597908237" ID="ID_1446329344" MODIFIED="1424597909133" TEXT="(nthnext stooges 2) ; -&gt; (&quot;Curly&quot; &quot;Shemp&quot;)"/>
</node>
<node CREATED="1424597938762" ID="ID_1382417366" MODIFIED="1424597965228" TEXT="several predicate functions">
<node CREATED="1424597965914" ID="ID_737919132" MODIFIED="1424598067830" TEXT="(every? #(instance? String %) stooges) ; -&gt; true"/>
<node CREATED="1424598068351" ID="ID_1068428011" MODIFIED="1424598073862" TEXT="(not-every? #(instance? String %) stooges) ; -&gt; false"/>
<node CREATED="1424598074483" ID="ID_659548848" MODIFIED="1424598084045" TEXT="(some #(instance? Number %) stooges) ; -&gt; nil"/>
<node CREATED="1424598087901" ID="ID_1043997891" MODIFIED="1424598088372" TEXT="(not-any? #(instance? Number %) stooges) ; -&gt; true"/>
</node>
</node>
<node CREATED="1424657801326" ID="ID_1708766398" MODIFIED="1424657803739" TEXT="Lists">
<node CREATED="1424657809816" ID="ID_1149858105" MODIFIED="1424657811730" TEXT="define">
<node CREATED="1424657822144" ID="ID_986162965" MODIFIED="1424657822945" TEXT="(def stooges (list &quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot;))"/>
<node CREATED="1424657832393" ID="ID_1617390076" MODIFIED="1424657833472" TEXT="(def stooges (quote (&quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot;)))"/>
<node CREATED="1424657836711" ID="ID_1497086974" MODIFIED="1424657837520" TEXT="(def stooges &apos;(&quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot;))"/>
</node>
<node CREATED="1424658054454" ID="ID_1933373161" MODIFIED="1424658058617" TEXT="test contains">
<node CREATED="1424658060963" ID="ID_1289913645" MODIFIED="1424658062239" TEXT="(some #(= % &quot;Moe&quot;) stooges) ; -&gt; true"/>
<node CREATED="1424658067284" ID="ID_1829829262" MODIFIED="1424658068198" TEXT="(some #(= % &quot;Mark&quot;) stooges) ; -&gt; nil"/>
<node CREATED="1424658073092" ID="ID_23919366" MODIFIED="1424658073830" TEXT="(contains? (set stooges) &quot;Moe&quot;) ; -&gt; true"/>
</node>
<node CREATED="1424658199932" ID="ID_573121027" MODIFIED="1424658204117" TEXT="create new List">
<node CREATED="1424658205477" ID="ID_953947087" MODIFIED="1424658206173" TEXT="(def more-stooges (conj stooges &quot;Shemp&quot;)) ; -&gt; (&quot;Shemp&quot; &quot;Moe&quot; &quot;Larry&quot; &quot;Curly&quot;)"/>
<node CREATED="1424658215059" ID="ID_1319023474" MODIFIED="1424658215956" TEXT="(def less-stooges (remove #(= % &quot;Curly&quot;) more-stooges)) ; -&gt; (&quot;Shemp&quot; &quot;Moe&quot; &quot;Larry&quot;)"/>
<node CREATED="1424658340978" ID="ID_1853991899" MODIFIED="1424658355010" TEXT="(into &apos;(1 2 3) &apos;(4 5 6)) ; -&gt; (6 5 4 1 2 3)"/>
</node>
<node CREATED="1424658398902" ID="ID_1607300002" MODIFIED="1424658419984" TEXT="treat list as a stack">
<node CREATED="1424658420759" ID="ID_682006894" MODIFIED="1424658497039" TEXT="(peek stooges); -&gt; &quot;Moe&quot;"/>
<node CREATED="1424658423055" ID="ID_1718944368" MODIFIED="1424658467233" TEXT="(pop stooges); -&gt; (&quot;Larry&quot; &quot;Curly&quot;)"/>
</node>
</node>
<node CREATED="1424658504622" ID="ID_1762115440" MODIFIED="1424658510694" TEXT="Vectors">
<node CREATED="1425040911035" ID="ID_1776317567" MODIFIED="1425040913642" TEXT="define">
<node CREATED="1425040914426" ID="ID_1721250750" MODIFIED="1425041078138" TEXT="(def stooges (vector &quot;Moe&quot; &quot;Larry&quot; &quot;lv&quot;))"/>
<node CREATED="1425041082296" ID="ID_594890717" MODIFIED="1425041083322" TEXT="(def stooges [&quot;Meo&quot; &quot;Larry&quot; &quot;lv&quot;])"/>
</node>
<node CREATED="1425040571065" ID="ID_1147067914" MODIFIED="1425040584555" TEXT="efficients">
<node CREATED="1425040590444" ID="ID_1157419584" MODIFIED="1425040641163" TEXT="ordered collections of items"/>
<node CREATED="1425040641957" ID="ID_310165418" MODIFIED="1425040657662" TEXT="added or removed item from back">
<node CREATED="1425040658024" ID="ID_1869276205" MODIFIED="1425040659321" TEXT="conj">
<node CREATED="1425040671939" ID="ID_296229462" MODIFIED="1425040693363" TEXT="better than">
<node CREATED="1425040693732" ID="ID_590945503" MODIFIED="1425040703603" TEXT="cons(from front)"/>
</node>
</node>
</node>
<node CREATED="1425040771575" ID="ID_980736534" MODIFIED="1425040777313" TEXT="finding">
<node CREATED="1425040777605" ID="ID_1376463864" MODIFIED="1425040786265" TEXT="nth">
<node CREATED="1425040974134" ID="ID_1745384752" MODIFIED="1425040983846" TEXT="throw exception if the index is out of range"/>
</node>
<node CREATED="1425040927337" ID="ID_704669923" MODIFIED="1425040927986" TEXT="get">
<node CREATED="1425040939157" ID="ID_578725036" MODIFIED="1425040972509" TEXT="return nil if the index is out of range"/>
</node>
</node>
<node CREATED="1425040827261" ID="ID_606156269" MODIFIED="1425040829782" TEXT="changing">
<node CREATED="1425040830421" ID="ID_1714585982" MODIFIED="1425040843965" TEXT="assoc"/>
</node>
</node>
<node CREATED="1425043059195" ID="ID_78100424" MODIFIED="1425043060002" TEXT="get">
<node CREATED="1425043060403" ID="ID_1068036259" MODIFIED="1425043061002" TEXT="(get stooges 1 &quot;unknown&quot;) ; -&gt; &quot;Larry&quot;"/>
<node CREATED="1425043074546" ID="ID_1902227337" MODIFIED="1425043075153" TEXT="(get stooges 3 &quot;unknown&quot;) ; -&gt; &quot;unknown&quot;"/>
</node>
<node CREATED="1425043082103" ID="ID_1330980410" MODIFIED="1425043085961" TEXT="associate">
<node CREATED="1425043086418" ID="ID_1566665722" MODIFIED="1425043086856" TEXT="(assoc stooges 2 &quot;Shemp&quot;) ; -&gt; [&quot;Moe&quot; &quot;Larry&quot; &quot;Shemp&quot;]"/>
</node>
<node CREATED="1425043127662" ID="ID_50941990" MODIFIED="1425043129471" TEXT="subvec">
<node CREATED="1425043129719" ID="ID_1078872933" MODIFIED="1425043145870" TEXT="(subvec stooges 1) ; -&gt;  [&quot;Larry&quot; &quot;lv&quot;]"/>
</node>
</node>
<node CREATED="1425199063108" ID="ID_216950680" MODIFIED="1425199065054" TEXT="Sets"/>
<node CREATED="1425199065271" ID="ID_1266318885" MODIFIED="1425199066894" TEXT="Maps"/>
<node CREATED="1425196980562" ID="ID_1741219709" MODIFIED="1425196983255" TEXT="functions">
<node CREATED="1425196985855" ID="ID_1084759434" MODIFIED="1425196986918" TEXT="define">
<node CREATED="1425196996815" ID="ID_922444727" MODIFIED="1425197002905" TEXT="basic definition">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(defn parting
  &quot;returns a String parting&quot;
  [name]
  (str &quot;Goodbye, &quot; name)) ; concatenation</pre>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1425197017815" ID="ID_291325383" MODIFIED="1425197018677" TEXT="(declare function-names)"/>
<node CREATED="1425197026887" ID="ID_634463533" MODIFIED="1425197045731" TEXT="optional parameters">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(defn power [base &amp; exponents]
  ; Using java.lang.Math static method pow.
  (reduce #(Math/pow %1 %2) base exponents))
(power 2 3 4) ; 2 to the 3rd = 8; 8 to the 4th = 409</pre>
  </body>
</html>
</richcontent>
</node>
<node CREATED="1425197047687" ID="ID_1636399371" MODIFIED="1425197052626" TEXT="partings">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(defn parting
  &quot;returns a String parting in a given language&quot;
  ([] (parting &quot;World&quot;))
  ([name] (parting name &quot;en&quot;))
  ([name language]
    ; condp is similar to a case statement in other languages.
    ; It is described in more detail later.
    ; It is used here to take different actions based on whether the
    ; parameter &quot;language&quot; is set to &quot;en&quot;, &quot;es&quot; or something else.
    (condp = language
      &quot;en&quot; (str &quot;Goodbye, &quot; name)
      &quot;es&quot; (str &quot;Adios, &quot; name)
      (throw (IllegalArgumentException.
        (str &quot;unsupported language &quot; language))))))

(println (parting)) ; -&gt; Goodbye, World
(println (parting &quot;Mark&quot;)) ; -&gt; Goodbye, Mark
(println (parting &quot;Mark&quot; &quot;es&quot;)) ; -&gt; Adios, Mark
(println (parting &quot;Mark&quot;, &quot;xy&quot;))
; -&gt; java.lang.IllegalArgumentException: unsupported language xy</pre>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1425197200513" ID="ID_794723855" MODIFIED="1425197201818" TEXT="private">
<node CREATED="1425197202179" ID="ID_1393108118" MODIFIED="1425197218417" TEXT="defn-"/>
<node CREATED="1425197218787" ID="ID_313567437" MODIFIED="1425197225537" TEXT="defmarco-"/>
</node>
<node CREATED="1425197062581" ID="ID_1792108114" MODIFIED="1425197070467" TEXT="anonymous">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(def years [1940 1944 1961 1985 1987])
(filter (fn [year] (even? year)) years) ; long way w/ named arguments -&gt; (1940 1944)
(filter #(even? %) years) ; short way where % refers to the argument</pre>
  </body>
</html>
</richcontent>
<node CREATED="1425197072723" ID="ID_1513173746" MODIFIED="1425197096316" TEXT="(def years [1940 1944 1961 1985 1987])"/>
<node CREATED="1425197102117" ID="ID_1630928283" MODIFIED="1425197102659" TEXT="(filter (fn [year] (even? year)) years)"/>
<node CREATED="1425197110523" ID="ID_1743069989" MODIFIED="1425197110963" TEXT="(filter #(even? %) years)">
<node CREATED="1425197128791" ID="ID_1993757419" MODIFIED="1425197184098" TEXT="only contain a single expression"/>
<node CREATED="1425197137774" ID="ID_459831851" MODIFIED="1425197147165" TEXT="% for one parameters"/>
<node CREATED="1425197147958" ID="ID_824173539" MODIFIED="1425197154293" TEXT="%1 %2 for multi parameters"/>
</node>
<node CREATED="1425197161813" ID="ID_488964571" MODIFIED="1425197169792" TEXT="function can be "/>
</node>
<node CREATED="1425197192073" ID="ID_1942699263" MODIFIED="1425197239169" TEXT="defmulti"/>
<node CREATED="1425197239410" ID="ID_584598015" MODIFIED="1425197241625" TEXT="defmethod"/>
<node CREATED="1425197261797" ID="ID_112042610" MODIFIED="1425197269528" TEXT="ignore parameter">
<node CREATED="1425197275224" ID="ID_1565349346" MODIFIED="1425197275823" TEXT="(defn callback2 [n1 _ n3] (+ n1 n3)) ; only uses 1st &amp; 3rd arguments"/>
</node>
<node CREATED="1425197284361" ID="ID_945330029" MODIFIED="1425197285135" TEXT="complement">
<node CREATED="1425197298761" ID="ID_264367146" MODIFIED="1425197828011" TEXT="returns the opposite logical truth value">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(defn teenager? [age] (and (&gt;= age 13) (&lt; age 20)))
(def non-teen? (complement teenager?))
(println (non-teen? 47)) ; -&gt; tru</pre>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1425197831580" ID="ID_1683806854" MODIFIED="1425197839019" TEXT="comp(compose)">
<node CREATED="1425197849492" ID="ID_1956479770" MODIFIED="1425197859322" TEXT="compose a new function call from right"/>
<node CREATED="1425197317117" ID="ID_830503925" MODIFIED="1425197868978" TEXT="(def my-composition (comp minus3 times2))">
<richcontent TYPE="NOTE"><html>
  <head>
    
  </head>
  <body>
    <pre style="text-transform: none; text-align: start; font-variant: normal; word-spacing: 0px; letter-spacing: normal; font-weight: normal; font-size: medium; text-indent: 0px; line-height: normal; color: rgb(0, 0, 0); font-style: normal; font-family: Courier New, monospace" xml="#DEFAULT" charset="utf-8" space="preserve">(defn times2 [n] (* n 2))
(defn minus3 [n] (- n 3))
; Note the use of def instead of defn because comp returns
; a function that is then bound to &quot;my-composition&quot;.
(def my-composition (comp minus3 times2))
(my-composition 4) ; 4*2 - 3 -&gt; 5</pre>
  </body>
</html>
</richcontent>
</node>
</node>
<node CREATED="1425197360366" ID="ID_728945839" MODIFIED="1425197361944" TEXT="partial">
<node CREATED="1425198029495" ID="ID_477105108" MODIFIED="1425198030175" TEXT="(def times2 (partial * 2))"/>
</node>
<node CREATED="1425198294898" ID="ID_1041696441" MODIFIED="1425198296514" TEXT="range">
<node CREATED="1425198297211" ID="ID_1129094380" MODIFIED="1425198305082" TEXT="(range 2 10)"/>
</node>
<node CREATED="1425198670938" ID="ID_1583402279" MODIFIED="1425198685985" TEXT="memoize">
<node CREATED="1425198731188" ID="ID_231476177" MODIFIED="1425198731828" TEXT="(def memo-f (memoize f))"/>
<node CREATED="1425198749236" ID="ID_1650437998" MODIFIED="1425198757576" TEXT="calculate expression time">
<node CREATED="1425198763573" ID="ID_1854483609" MODIFIED="1425198764339" TEXT="(time (f 2))"/>
<node CREATED="1425198770204" ID="ID_992587477" MODIFIED="1425198771083" TEXT="(dotimes [_ 3] (time (f 2)))"/>
<node CREATED="1425198778716" ID="ID_520390937" MODIFIED="1425198779139" TEXT="(dotimes [_ 3] (time (memo-f 2)))"/>
</node>
</node>
</node>
</node>
</node>
</node>
</map>
