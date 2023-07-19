# Official documentation here: https://maven.apache.org/guides/

mvn $commands -D$customParam=$parameterValue # parameter is optional and can be omitted
mvnw $commands -D$customParam=$parameterValue #(if you have a wrapper)

# possible custom parameters are
-DskipTests							# skips tests but compiles them
Dmaven.test.skip=true				# skips tests and doesn't compile them
-Dtest=$class#$method				# runs a specific test

# other parameters are
-U # update dependencies

# $command value can be
mvn clean										# clean maven working directory
mvn clean compile 								# cleans and compiles the code
mvn install  									# installs dependencies refers to first pom.xml encountered starting from pwd
mvn clean install 								# clean and install dependencies
mvn build 										# builds the project
mvn test 										# launches tests
mvn package										# creates a jar file with dependencies
mvn dependency:purge-local-repository			# removes all local maven repository dependencies purging them (.m2 local repository)
mvn dependency:purge-local-repository clean 	# removes all local maven repository dependencies purging them and clean the working directory
mvn generate-sources							# generates sources from the source code (if you use some automatic generation tool)