# Official documentation is in every command just by typing it but "man" is usually handy https://man7.org/linux/man-pages/man1/man.1.html
# Every distribution may use different tools, this cheatsheet is a porridge of CentOS, RHEL and Ubuntu commands.

sudo -u $user $command						    -> executes command as super user (password required for that user)
sudo su 										-> enters as root

cat /etc/issue									-> machine info or motd
cat /proc/cpuinfo								-> CPU info
cat /proc/meminfo								-> RAM info
sudo fdisk -l									-> disk info
hdparm -i /dev/device 							-> disk info

cat /etc/os-release								-> machine OS info
lsb_release -a							        -> machine OS info
hostnamectl							            -> machine OS info
less /etc/fstab									-> NAS Areas info

whoami 											-> prints current user
id [user]										-> prints user info
usermod -a -G [grpname1],{grpname2} [username]	-> adds user to specified group(s)
groups [username]								-> prints groups the user belongs to
less /etc/passwd								-> users list

sudo vi /etc/pam.d/password-auth				-> user auth settings, check for UID => 1000 error
sudo less /var/log/messages						-> operating system logs
-> run df -h to know disk names "mapper" can be omitted
sudo vgdisplay									-> displays free space that can be extended
sudo lvextend -r -L +1GB -A n /dev/vg00/opt     -> extends partition space by 1GB for disk /dev/vg00/opt
sudo lvreduce -r -L -5GB -A n /dev/vg00/var     -> removes 5GB of partition space for disk /dev/vg00/var
sudo xfs_growfs /dev/vg00/var 					-> extends the file system
findmnt											-> disk details
vi /etc/fstab [remove flags]					-> modify disk flags
mount -o remount /datadisks/disk1				-> mount and remount disk

df -h 											-> prints free space on various partitions											
du -hs *									 	-> prints total disk usage in GB
du -ha *									 	-> prints disk usage in GB per folder
du -ach											-> sums file sizes

CTRL+C                                          -> interrupts execution of a command while it's running

CTRL+R + "deploy"                               -> reverse search in command history, in this case commands containing the word deploy

cd [location] 									-> move to specified location
cd - 											-> previous location
pwd 											-> print current location

ln -s /path/to/file /path/to/symlink			-> symbolic link

ls -la 											-> list files with permissions and characteristics
ls -lha											-> list files in human readable format
ll 												-> list files with permissions and characteristics
ls --sort=size -lha -r							-> sort by size in reverse order
ls -d *[name]*/									-> list directories that match the wildcard

ls -q -U | awk -F . '{print $NF}' | sort | uniq -c | awk '{print $2,$1}' | sort -k 2 -nr | less 
	-> list files without names, size and permissions; print the end of the file; sort; count unique lines; 
		print name and quantity of sorted-unique files; sort inversely by column 2 (number) and print output

ps -ef | grep [process name] 					                            -> active processes matching that name, provides PID
ps -C [process name] --no-headers -o pmem | paste -sd+ | bc                 -> finds the process and its memory usage, results may be multiple
ps -e -o pid,uname,pcpu,pmem,comm                                           -> processes memory usage list
ps -e -o pid,uname,pcpu,pmem,comm --sort=-pcpu,+pmem                        -> sorted processes memory usage list

sar 																		-> system monitoring, load average etc.
netstat -nl																	-> listening ports

sudo lsof -i -P -n | grep LISTEN											->
sudo netstat -tulpn | grep LISTEN
sudo lsof -i:22 															-> ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here

yum search [pkg]		-> info on available packages matching the name
yum info [pkg]			-> info on package version 
yum list installed		-> lists installed yum packages

watch -n 1 'ps -e -o pid,uname,cmd,pmem,pcpu --sort=-pmem,-pcpu | head -15' -> fancy task manager
free -m 																	-> free RAM memory 
cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l					-> number of CORES
kill [PID] 																	-> kills an active process

mv [file] [location] 							-> moves a file from current directory to destination directory
mv [old filename] [new filename] 				-> renames a file
mv -R [location] [location] 					-> moves a directory and all subdirectories and files to another directory
mv (-R) [location] [location] 					-> moves an empty directory from one directory to another
mv -R [location] [location]						-> moves a full directory and its contents
mv * ..\ 										-> moves all files (and directories) from inside the directory to outside	

scp [file] [user target machine]@[IP target machine]:[directory target machine] -> transfers via SCP from one linux machine to another, asks for target user password

--------------
-- tabella swap --

    RAM(GB) No hibernation  With Hibernation  Maximum
	 256MB	256MB	 		 512MB                512MB
	 512MB	512MB	 		  1					  1
      1      1                2                   2
      2      1                3                   4
      3      2                5                   6
      4      2                6                   8
      5      2                7                  10
      6      2                8                  12
      8      3               11                  16
     12      3               15                  24
     16      4               20                  32
     24      5               29                  48
     32      6               38                  64
     64      8               72                 128
    128     11              139                 256
	
 In case of heavy swap usage, use x2 as rule or x1.75
 
 https://askubuntu.com/questions/49109/i-have-16gb-ram-do-i-need-32gb-swap
 
-- tabella swap --


swapoff -a
sudo swapoff /swapfile
sudo rm swapfile
sudo dd if=/dev/zero of=/swapfile bs=1M count=8192 oflag=append conv=notrunc => 8GB
sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 oflag=append conv=notrunc => 16GB
sudo dd if=/dev/zero of=/swapfile bs=1M count=32768 oflag=append conv=notrunc => 32 GB
sudo mkswap /swapfile
sudo swapon /swapfile

--------------
open files limit set to 100k
https://www.cyberciti.biz/faq/linux-increase-the-maximum-number-of-open-files/

sysctl -w fs.file-max=100000
vi /etc/sysctl.conf
# modify the file as follows => fs.file-max = 100000
sysctl -p
/etc/pam.d/login = add => session required pam_limits.so
--------------

cp -R [location] [location] 					-> copies a directory and its contents to another directory
cp [file] [location] 							-> copies a file to a directory

zip -r [name].zip [directory] 					-> zips the directory and its content
zip [name].zip [file] 							-> zips the file
unzip [file.zip] -d [directory] 				-> unzips the file [in directory]
gzip [filename]									-> zips the file in .gz format
zless [file.zip or file.gz]						-> less of a zipped file
zcat [file.zip or file.gz]

tar -zxvf yourfile.tar.gz 						-> extracts the file in current directory

find /folder/*.log* -type f -not -name "*.gz" -mtime +[days] -exec gzip {} \; 			-> zips *.log* files older than N days
find /var/opt/evil-product/logs/*.log* -type f -mtime +30 -exec rm -f {} \; 					-> deletes log files older than 30 days

find /opt/more-evil-corp/compac-connector/*.gz* -type f -mtime +40 -exec rm -f {} \; 		-> deletes gz files older than 40 days

chmod -[1-7][1-7][1-7] [file/directory] 		-> permissions for various groups 7 = all permissions, 1=read only
chmod -[x,r,w] [file/directory] 				-> removes execution, reading and writing permissions from current user
chmod +[x,r,w] [file/directory] 				-> adds execution, reading and writing permissions to current user
chmod g+/-[x,r,w] [file/directory] 				-> adds execution, reading and writing permissions to current group
chmod u=rwx,g=rx,o=r [file/directory]			-> permissions given in a human-readable way

--- chmod table ---

755 I can change and run it, everyone else can run tcit.
644 I can change it, everyone else can read it.
444 Read only for everyone, we're through here.
500 I can execute it, don't want it to change, everyone else hands off.

#  r  w  x
0  0  0  0
1  0  0  1
2  0  1  0
3  0  1  1
4  1  0  0
5  1  0  1
6  1  1  0
7  1  1  1

--- chmod table --- 

chgrp [group name] [file/directory] 			-> changes group ownership of a folder or file

chown [owner]:[group] [file/directory]	
chown devops:webgrp [file/directory] 			-> sets new owner for the file, in this case owner = "devops" group = "webgrp"	

rm (-f) [file] 									-> deletes a file
rm (-d) [directory] 							-> deletes an empty directory
rm -f *.pdf 									-> deletes all .pdf files (applicable to all extensions/file names)
rm -rf											-> forcibly deletes a folder and its contents
rm -r 											-> deletes a folder and its contents
find . -type f -name '*.pdf' -exec rm {} +		-> removes all PDF files from current folder (and subfolders)

find . -maxdepth 1 -name "*.pdf" -print0 | xargs -0 rm -> 

less [document]									-> view document

	> 		-> go to end of document
	? 		-> search from bottom to top
	/ 		-> search from top to bottom
	
vi [document] 									-> document editor (less commands work)

	esc 		-> enter visual mode
	:w 			-> save
	:q 			-> exit
	:q! 		-> exit without saving
	:wq 		-> exit and save
	i 			-> enter insert mode
	A 			-> enter append mode
	GG			-> go to end
	gg			-> go to beginning
	dd 			-> delete line
	ZZ 			-> exit and save
	[number] DD -> delete N lines


cat [document] 																								-> view document
zcat [document]																								-> view zipped document

tail -f [document] 																							-> open in append and stay in append, useful for real-time logs

touch [params: -m modified at -a accessed_at -t created_at] [timestamp format yyyymmddhhmmss.tt] [filename] -> modify file access
example:
touch -m -a -t 202106141136.09 wow.txt

./[script_name].sh 								-> executes commands contained in .sh script
java -jar [jar_name].jar 						-> executes the main in the .jar

wget [dropbox link] 							-> downloads a resource to the folder 

locate 												-> find file
find . -name *filename*.txt* 						-> finds files in txt, txtx etc. format that have the word filename in their name within the current folder + subfolders, try to use the cd / command first to search the entire PC
find . -type f -print | grep -i "name or .format"	-> finds the file intelligently starting from the folder, also prints the location and colored match

grep -Ril "[text]" [directory] 				-> searches for text inside files, use directory / to search the entire PC

grep "word or phrase" [dir]/*.[file ext]        -> searches for CASE SENSITIVE word or phrase in a folder 

grep -i "word or phrase" [dir]/*.[file ext]     -> searches for CASE INSENSITIVE word or phrase in a folder 

ps -ef | grep --color=auto [word]				-> colors the word

zgrep "word or phrase" [dir]/[zipped file]     -> searches for CASE SENSITIVE word or phrase in zipped file (also folder of zipped files)


--- Time ---
date                                            -> provides current date
sudo hwclock -s									-> realigns date of a subsystem/VM or the computer itself with the clock


#######################################################################################
################################ CURL #################################################
#######################################################################################

--- GET ---

curl -v http://localhost:8080/gosing/loginc 										-> curl verbose makes http GET call as if it were a browser 
curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET <url>	-> curl get xml
curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET <url> -> curl get json

--- POST ---
curl --data "param1=value1&param2=value2" http://hostname/resource

For file upload:
curl --form "fileupload=@filename.txt" http://hostname/resource

RESTful HTTP Post:
curl -X POST -d @filename http://hostname/resource

For logging into a site (auth):
curl -d "username=admin&password=admin&submit=Login" --dump-header headers http://localhost/Login
curl -L -b headers http://localhost/

eytool -list -keystore file.p12  															-> prints info of a p12 for which you have the password
keytool -v -list -keystore file.p12  														-> prints all info (verbose)
openssl pkcs12 -in <certificate>.p12 -out certificate.pem -nodes 							-> extracts certificate [asks for password]
cat certificate.pem | openssl x509 -noout -enddate 											-> checks expiration date
keytool -list -v -keystore cacerts > /tmp/keyStore.txt 										-> extracts certificate info to a file [asks for password]
keytool -importcert -file /location/file.cer -keystore cacerts -alias <arbitrary alias>	-> import certificate

input password: changeit
 -> default password of default java keystore
 
netsh http add sslcert ipport=0.0.0.0:443 certhash='<inserire hash>' appid='{<inserire-app-id>}' => import cert SSL iis, da testare


openssl req –new –newkey rsa:2048 –nodes –keyout server.key –out server.csr -> creates a request for SSL certificate from FE machine (provide server.csr)

openssl genrsa -out private.pem 2048														-> Private key
openssl rsa -in private.pem -outform PEM -pubout -out public.pem							-> Public key
openssl req -new -key private.pem -out certificate.csr										-> CSR (Certificate Signing Request)
openssl x509 -req -days 365 -in certificate.csr -signkey private.pem -out certificate.crt	-> Self-signed certificate

openssl x509 -in certificate.crt -out certificate.pem -outform PEM							-> Convert cert to PEM
openssl x509 -outform der -in grapho.pem -out grapho.crt									-> Convert PEM to CRT


openssl pkcs12 -export -out certificate.pfx -inkey private.key -in certificate.crt      -> Generate PFX
openssl pkcs12 -in certificate.pfx -nocerts -out private.key							-> Get pvt.key from PFX

-- adding cert to std java keystore

/usr/java/jdk1.x.0_xx/jre/bin/keytool -delete -alias <alias> -keystore /usr/java/jdk1.x.0_xx/jre/lib/security/cacerts
/usr/java/jdk1.x.0_xx/jre/bin/keytool -importcert -file /location/file.cer -keystore /usr/java/jdk1.x.0_xx/jre/lib/security/cacerts -alias <alias nome macchina>
/usr/java/jdk1.x.0_xx/jre/bin/keytool -v -list -keystore /usr/java/jdk1.x.0_xx/jre/lib/security/cacerts

-- adding cert to keystore
/usr/java/jdk1.x.0_xx/jre/bin/keytool -delete -alias <alias> -keystore <keystore>
/usr/java/jdk1.x.0_xx/jre/bin/keytool -importcert -file /location/file.cer -keystore <keystore> -alias <alias>
/usr/java/jdk1.x.0_xx/jre/bin/keytool -v -list -keystore /usr/java/jdk1.x.0_xx/jre/lib/security/cacerts

/usr/java/jdk1.8.0_65/jre/bin/keytool -importcert -file ip1cvliaslbs001.clint.evilcorp.it_cert_CEPO210312804250.cer -keystore /usr/java/jdk1.8.0_65/jre/lib/security/cacerts -alias ip1cvliaslbs001.clint.evilcorp.it

-- adding cert and new private key
openssl pkcs12 -export -in [path to certificate] -inkey [path to private key] -certfile [path to certificate] -name <nome-macchina> -out testkeystore.p12
keytool -importkeystore -srckeystore testkeystore.p12 -srcstoretype pkcs12 -destkeystore /usr/java/jdk1.x.0_xx/jre/lib/security/cacerts -deststoretype JKS




.P12
- generate new p12 with final certificate + private key
 sudo openssl pkcs12 -export -inkey ip1cvliaslbs001.clint.evilcorp.it.key -in 20210322.ip1cvliaslbs001.clint.evilcorp.it.cer -name ip1cvliaslbs001.clint.evilcorp.it -out more-evil-corpcollaudo_20210322.p12

Enter Export Password:
Verifying - Enter Export Password: MT4SxvuJ9Y
- export intermediate and root ca from final certificate (also from windows)
- import root and intermediate into p12

 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias intermediate-globalsign-rsa-ov-ssl-ca-2018 -file GlobalSign_RSA_OV_SSL_CA_2018.cer -keystore more-evil-corpcollaudo_20210322.p12 
 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias root-globalsign-ca-r3 -file GlobalSignRootCA_R3.cer -keystore more-evil-corpcollaudo_20210322.p12 

Enter keystore password:  

.JKS
-	Verify presence of RootCA via serialnumber (removing the initial zero 04000000000121585308a2) if present proceed
-	Delete old final certificate of the machine

sudo /usr/java/jdk1.8.0_161/bin/keytool -delete -alias ip1cvliaslbs001.clint.evilcorp.it -keystore 

-	Import new final certificate of the machine
 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias ip1cvliaslbs001.clint.evilcorp.it -file 20210322.ip1cvliaslbs001.clint.evilcorp.it.cer -keystore cacerts_custom_coll_20210322_P12.jks



.CSR with multiple SANs

$ openssl req -new -out server.csr -newkey rsa:2048 -nodes -sha256 -keyout private.key.temp -config openssl.cnf
$ openssl req -text -noout -verify -in server.csr
$ openssl rsa -in private.key.temp -out private.key

openssl.cnf content

[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no
[req_distinguished_name]
C = IT
ST = IT
L = Milan
O = xxxx
OU = DevOps
CN = xxxx.yyyy.it
[v3_req]
keyUsage = keyEncipherment, dataEncipherment, digitalSignature, nonRepudiation
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = xxx.yyyy.it
DNS.2 = yyyy.yyyy.it
DNS.3 = zzz.yyyy.it



---
APACHE2 install
---
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests
a2enmod rewrite
//restart

--------------------------
--- AWK MAGIC          ---
--------------------------

awk '{print "INSERT INTO SB_CONFIGURATIONS (ID,PARENT_ID,CONF_TYPE,VAL_TYPE,USER_ID,CUST_ID,CODE,GRP_CODE,IS_ENCRYPTED,T_VAL,B_VAL) VALUES (SB_CONFIGURATIONS_ID_SEQ.nextval,null,'"'"'USR'"'"','"'"'BOL'"'"',"$0",null,'"'"'userConf_delete_envelope_disabled'"'"','"'"'userConf_usr_permission'"'"',0,null,1);"}' TKT_59984-ID.txt | head

awk '{print "ABC"$0"DEF"}' TKT_59984-ID.txt | head

--------------------------
--- GREP & ZGREP MAGIC ---
--------------------------

zgrep -c "phrase to search for" [file name or folder/*.ext] 																					-> counts occurrences

zgrep -A [number of lines before] -B [number of lines after] "phrase to search for" [file name or regular expression *.log] > [file to redirect out] 	-> creates file with portions of log that you choose

zgrep "ParamName:inIFrame" signbook.log.2019-05-* | grep CE800960 

grep -c "phrase to search for" signbook.log.2019-0?-?? 																							-> counts occurrences

------------------
--- MAGIC      ---
------------------

watch tail [file]                                         				-> does things at the end of the file

watch "tail [typically log file]|cut -b 1-180 -n 25" 				-> last 25 lines of the file, and continues to tail every 2 secs

watch -n [interval in seconds] [command]                				-> watches the command every N seconds

cat [file] | tr -d ',' | awk '{print "\""$0"\","}' > [new file] 		-> removes commas from file and with awk makes the IDs SQL-compatible

export LOG=evil-product.log ; ( for w in $(zgrep -Po '(it|eu)(\.[a-zA-Z][a-zA-Z0-9]+){2,10}' $LOG|sort|uniq) ; do echo $(zgrep -i $w $LOG | wc -c) "$w" ; do
ne ) | sort -k 1 -n | tail -n 10

=> reads the major classes that log in the log and lists them

sort [file]  | awk '!/^$/' | awk '!/^#/' > [result file] 	 			 -> removes all comments and empty spaces from a file and prints the lines
																			in an orderly manner, useful for checking properties

 https://medium.com/@joelbelton/the-most-important-linux-commands-that-nobody-teaches-you-ce423ef2ae28
