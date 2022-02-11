#!/bin/bash

# If using a local database, you may find 
# the following queries useful for testing:
#
# 	set enable_hashjoin to off;
# 	set enable_mergejoin to off;
# 	show all;
#
cd "$(dirname "$0")"

# You'll need to export a jar of the testing 
# framework and add it to the current directory
# in order to use this script.
#
JAVA_HOME='C:/Java/jdk-17.0.2'
JAVA_CMD="$JAVA_HOME/bin/java"
TEST_HOME='C:/Users/cdian/Desktop/Research/DataSpread/formula-comp/FormulaCompressionTesting/testing'
COMMON_CONFIG=$TEST_HOME/commonConfig.properties
SHEETS_HOME=$TEST_HOME/sheets
REPORT_HOME=$TEST_HOME/reports

# Edit these as needed
declare -a depTableClassString=("comp")
declare -a modes=("mem")
declare -a runs=("1" "2" "3")
declare -A updateMap
# updateMap['enron_long1.xls']='F2'
# updateMap['enron_long2.xls']='A6'
# updateMap['enron_long3.xls']='I7'
updateMap['enron_max1.xls']='Z1'
updateMap['enron_max2.xls']='J5'
updateMap['enron_max3.xls']='J5'
updateMap['enron_max4.xls']='D4'
updateMap['enron_max5.xls']='B42'
# updateMap['github_long1.xlsx']='B2'
# updateMap['github_long2.xlsx']='A8'
# updateMap['github_long3.xlsx']='A2'
# updateMap['github_max1.xlsx']='S82'
# updateMap['github_max2.xlsx']='C6'
# updateMap['github_max3.xlsx']='R5820'
# updateMap['github_max4.xlsx']='D21917'
# updateMap['github_max5.xlsx']='A8'

for workbook in "${!updateMap[@]}"
do
	for run in "${runs[@]}"
	do
		for i in "${!depTableClassString[@]}"
		do
			for j in "${!modes[@]}"
			do
				now="$(date)"
				msg="| $now | Workbook = ${workbook} | Run = ${run} | Dependency Table Class = ${depTableClassString[$i]} | MODE = ${modes[$j]} |"
				div="$(head -c ${#msg} < /dev/zero | tr '\0' '\053')"
				[ ${modes[$j]} = 'mem' ] && mem='true' || mem='false'
				printf "\n${div}\n${msg}\n${div}\n"
				OUT_FOLDER=$REPORT_HOME/${depTableClassString[$i]}/${workbook}/${modes[$j]}/RUN-${run}
				mkdir -p $OUT_FOLDER
				rm -f $OUT_FOLDER/*
				timeout 60m $JAVA_CMD \
          -Xss4m \
					-Durl=jdbc:postgresql://localhost:5433/dataspread \
					-DdbDriver=org.postgresql.Driver \
					-Dusername=dataspreaduser \
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
          -jar dataspread-web.jar \
					${COMMON_CONFIG}
			done
		done
	done
done
