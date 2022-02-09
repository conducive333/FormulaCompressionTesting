#!/bin/bash

# You shouldn't need to touch these
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_CMD=$JAVA_HOME/bin/java
MAVEN_HOME=/home/cdeleon/.m2
DATASPREAD_HOME=/home/cdeleon/FormulaCompressionTesting/dataspread-web
TEST_MAIN=FormulaCompressionTest.CompressionTestMain
TEST_HOME=/home/cdeleon/FormulaCompressionTesting/testing
COMMON_CONFIG=$TEST_HOME/commonConfig.properties
SHEETS_HOME=/home/cdeleon/FormulaCompressionTesting/testing/sheets
CLASSPATH=$DATASPREAD_HOME/testcode/target/classes:$MAVEN_HOME/repository/org/apache/tomcat/tomcat-dbcp/8.0.33/tomcat-dbcp-8.0.33.jar:$MAVEN_HOME/repository/org/apache/tomcat/tomcat-juli/8.0.33/tomcat-juli-8.0.33.jar:$MAVEN_HOME/repository/org/apache/tomcat/tomcat-jdbc/8.5.11/tomcat-jdbc-8.5.11.jar:$DATASPREAD_HOME/blockstore/target/classes:$MAVEN_HOME/repository/com/esotericsoftware/kryo/4.0.0/kryo-4.0.0.jar:$MAVEN_HOME/repository/com/esotericsoftware/reflectasm/1.11.3/reflectasm-1.11.3.jar:$MAVEN_HOME/repository/org/ow2/asm/asm/5.0.4/asm-5.0.4.jar:$MAVEN_HOME/repository/com/esotericsoftware/minlog/1.3.0/minlog-1.3.0.jar:$MAVEN_HOME/repository/org/objenesis/objenesis/2.2/objenesis-2.2.jar:$MAVEN_HOME/repository/com/google/guava/guava/30.0-jre/guava-30.0-jre.jar:$MAVEN_HOME/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:$MAVEN_HOME/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:$MAVEN_HOME/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar:$MAVEN_HOME/repository/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.jar:$MAVEN_HOME/repository/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar:$MAVEN_HOME/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar:$MAVEN_HOME/repository/com/fasterxml/jackson/core/jackson-databind/2.9.10.5/jackson-databind-2.9.10.5.jar:$MAVEN_HOME/repository/com/fasterxml/jackson/core/jackson-annotations/2.9.10/jackson-annotations-2.9.10.jar:$MAVEN_HOME/repository/com/fasterxml/jackson/core/jackson-core/2.9.10/jackson-core-2.9.10.jar:$DATASPREAD_HOME/zss/target/classes:$MAVEN_HOME/repository/junit/junit/4.13.1/junit-4.13.1.jar:$MAVEN_HOME/repository/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar:$MAVEN_HOME/repository/org/apache/commons/commons-math/2.2/commons-math-2.2.jar:$MAVEN_HOME/repository/commons-io/commons-io/1.3.2/commons-io-1.3.2.jar:$DATASPREAD_HOME/zssmodel/target/classes:$MAVEN_HOME/repository/com/github/davidmoten/rtree/0.8.6/rtree-0.8.6.jar:$MAVEN_HOME/repository/com/github/davidmoten/guava-mini/0.1.1/guava-mini-0.1.1.jar:$MAVEN_HOME/repository/io/reactivex/rxjava/1.3.8/rxjava-1.3.8.jar:$DATASPREAD_HOME/zpoi/target/classes:$MAVEN_HOME/repository/org/zkoss/common/zcommon/7.0.3/zcommon-7.0.3.jar:$MAVEN_HOME/repository/commons-fileupload/commons-fileupload/1.2.2/commons-fileupload-1.2.2.jar:$MAVEN_HOME/repository/org/zkoss/common/zel/7.0.3/zel-7.0.3.jar:$MAVEN_HOME/repository/org/beanshell/bsh/2.0b4/bsh-2.0b4.jar:$MAVEN_HOME/repository/org/slf4j/slf4j-api/1.7.5/slf4j-api-1.7.5.jar:$MAVEN_HOME/repository/org/slf4j/slf4j-jdk14/1.7.5/slf4j-jdk14-1.7.5.jar:$MAVEN_HOME/repository/org/dom4j/dom4j/2.1.3/dom4j-2.1.3.jar:$MAVEN_HOME/repository/stax/stax-api/1.0.1/stax-api-1.0.1.jar:$MAVEN_HOME/repository/org/apache/xmlbeans/xmlbeans/2.3.0/xmlbeans-2.3.0.jar:$MAVEN_HOME/repository/org/apache/poi/ooxml-schemas/1.1/ooxml-schemas-1.1.jar:$MAVEN_HOME/repository/commons-codec/commons-codec/1.5/commons-codec-1.5.jar:$MAVEN_HOME/repository/org/zkoss/zk/zk/7.0.3/zk-7.0.3.jar:$MAVEN_HOME/repository/org/zkoss/common/zweb/7.0.3/zweb-7.0.3.jar:$MAVEN_HOME/repository/org/jsoup/jsoup/1.7.3/jsoup-1.7.3.jar:$MAVEN_HOME/repository/javax/servlet/servlet-api/2.4/servlet-api-2.4.jar:$MAVEN_HOME/repository/org/json/json/20180130/json-20180130.jar:$MAVEN_HOME/repository/org/postgresql/postgresql/42.2.1/postgresql-42.2.1.jar

# You may need to configure these
JAVA_CONFIG=-Xss4m
REPORT_HOME=$TEST_HOME/reports

# Edit these as needed
declare -a depTableClassString=("comp")
declare -a modes=("mem")
declare -a runs=("1" "2" "3")
declare -A updateMap
updateMap['enron_long1.xls']='F2'
updateMap['enron_long2.xls']='A6'
updateMap['enron_long3.xls']='I7'
updateMap['enron_max1.xls']='Z1'
updateMap['enron_max2.xls']='J5'
updateMap['enron_max3.xls']='J5'
updateMap['enron_max4.xls']='D4'
updateMap['enron_max5.xls']='B42'
updateMap['github_long1.xlsx']='B2'
updateMap['github_long2.xlsx']='A8'
updateMap['github_long3.xlsx']='A2'
updateMap['github_max1.xlsx']='S82'
updateMap['github_max2.xlsx']='C6'
updateMap['github_max3.xlsx']='R5820'
updateMap['github_max4.xlsx']='D21917'
updateMap['github_max5.xlsx']='A8'

for workbook in "${!updateMap[@]}"
do
	for run in "${runs[@]}"
	do
		for i in "${!depTableClassString[@]}"
		do
			for j in "${!modes[@]}"
			do
				now="$(date)"
				msg="| $now | Workbook = ${workbook} | Run = ${run} | Dependency Table Class = ${depTableClassString[$i]} | MODE = ${modes[$j]}"
				div="$(head -c ${#msg} < /dev/zero | tr '\0' '\053')"
				[ ${modes[$j]} = 'mem' ] && mem='true' || mem='false'
				printf "\n${div}\n${msg}\n${div}\n"
				OUT_FOLDER=$REPORT_HOME/${depTableClassString[$i]}/${workbook}/${modes[$j]}/RUN-${run}
				mkdir -p $OUT_FOLDER
				rm -f $OUT_FOLDER/*
				timeout 60m $JAVA_CMD $JAVA_CONFIG \
					-Durl=jdbc:postgresql://fcomp-db:5432/dataspread_db \
					-DdbDriver=org.postgresql.Driver \
					-Dusername=admin \
					-Dpassword=password \
					-DuseSyncRunner=false \
					-DskipExecution=true \
					-DmemOnly=mem \
					-Ddirection=column \
					-DdepTableCacheSize=0 \
					-DdepTableClassString=${depTableClassString[$i]} \
					-DspreadsheetString="customsheet" \
					-DnumTestArgs=2 \
					-DtestArg.0=${SHEETS_HOME}/${workbook} \
					-DtestArg.1=${updateMap[$workbook]} \
					-DoutFolder=${OUT_FOLDER} \
					-classpath ${CLASSPATH} \
					${TEST_MAIN} \
					${COMMON_CONFIG}
			done
		done
	done
done
