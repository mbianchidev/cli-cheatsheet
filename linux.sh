# Official documentation is in every command just by typing it but "man" is usually handy https://man7.org/linux/man-pages/man1/man.1.html
# Every distribution may use different tools, this cheatsheet is a porridge of CentOS, RHEL and Ubuntu commands.

sudo -u $user $command						    -> esegue comando come super user (è necessaria la password per quell'utenza)
sudo su 										-> entra come root

cat /etc/issue									-> info macchina o motd
cat /proc/cpuinfo								-> info CPU
cat /proc/meminfo								-> info RAM
sudo fdisk -l									-> info disk
hdparm -i /dev/device 							-> info disk

cat /etc/os-release								-> info OS macchina
lsb_release -a							        -> info OS macchina
hostnamectl							            -> info OS macchina
less /etc/fstab									-> info Aree NAS

whoami 											-> utente print
id [user]										-> stampa info su user
usermod -a -G [grpname1],{grpname2} [username]	-> aggiungo lo user al/ai gruppi specificati
groups [username]								-> stampa i gruppi a cui appartiene lo user
less /etc/passwd								-> lista utenti

sudo vi /etc/pam.d/password-auth				-> settings dell'auth per gli utenti, vedi errore UID => 1000
sudo less /var/log/messages						-> log del sistema operativo
-> fai df -h per sapere nome dei dischi "mapper" puoi ometterlo
sudo vgdisplay									-> visualizza spazio libero da poter estendere
sudo lvextend -r -L +1GB -A n /dev/vg00/opt     -> estende spazio partizione disponibile di 1GB per disco /dev/vg00/opt
sudo lvreduce -r -L -5GB -A n /dev/vg00/var     -> rimuove spazio partizione disponibile di 5GB per disco /dev/vg00/var
sudo xfs_growfs /dev/vg00/var 					-> estende il file sistem
findmnt											-> dettaglio dischi
vi /etc/fstab [remove flags]					-> modifica flag dischi
mount -o remount /datadisks/disk1				-> mount e remount del disco

df -h 											-> stampa lo spazio residuo delle varie partizioni											
du -hs *									 	-> stampa occupazione in GB totale
du -ha *									 	-> stampa occupazione in GB per cartella
du -ach											-> somma dimensioni filez

CTRL+C                                          -> interrompi esecuzione di un comando mentre è in corso

CTRL+R + "deploy"                               -> reverse search nella history dei comandi eseguiti, in questo caso comandi che contengono la parola deploy

cd [location] 									-> muoversi per andare alla location
cd - 											-> location precedente
pwd 											-> stampa la location corrente

ln -s /path/to/file /path/to/symlink			-> symbolic link

ls -la 											-> lista files con permessi e alcune caratteristiche
ls -lha											-> lista files human readable
ll 												-> lista files con permessi e alcune caratteristiche
ls --sort=size -lha -r							-> sort size ordinato al contrario
ls -d *[nome]*/									-> lista directory che matchano la wildcard

ls -q -U | awk -F . '{print $NF}' | sort | uniq -c | awk '{print $2,$1}' | sort -k 2 -nr | less 
	-> lista dei file senza nomi, pesi e permessi; printo la fine del file; riordino; conto le line unique; 
		stampo nome e quantità dei files sorted-unique; riordino inversamente per la colonna 2 (numero) e stampo l'output

ps -ef | grep [nome processo] 					                            -> processi attivi che matchano quel nome, fornisce il PID
ps -C [nome processo] --no-headers -o pmem | paste -sd+ | bc                -> cerca il processo e la sua occupazione, i risultati possono essere multipl
ps -e -o pid,uname,pcpu,pmem,comm                                           -> processi elenco occupazione memoria
ps -e -o pid,uname,pcpu,pmem,comm --sort=-pcpu,+pmem                        -> processi elenco occupazione memoria sorted

sar 																		-> system monitoring, load average etc.
netstat -nl																	-> porte in ascolto

sudo lsof -i -P -n | grep LISTEN											->
sudo netstat -tulpn | grep LISTEN
sudo lsof -i:22 															-> ## see a specific port such as 22 ##
sudo nmap -sTU -O IP-address-Here

yum search [pkg]		-> info su pkg disponibili che matchano il nome
yum info [pkg]			-> info su pkg versione 
yum list installed		-> lista i pacchetti yum installati

watch -n 1 'ps -e -o pid,uname,cmd,pmem,pcpu --sort=-pmem,-pcpu | head -15' -> task manager da ricchi
free -m 																	-> memoria RAM libera 
cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l					-> numero CORE
kill [PID] 																	-> uccide un processo attivo

mv [file] [location] 							-> muove un file dalla directory corrente ad una directory destinazione
mv [old filename] [new filename] 				-> rinomina un file
mv -R [location] [location] 					-> muove una directory e tutte le sottodirectory e files sotto un'altra directory
mv (-R) [location] [location] 					-> muove una directory vuota da una directory all'altra
mv -R [location] [location]						-> muove una directory piena ed i file contenuti in essa
mv * ..\ 										-> muoviamo tutti i file (e directory) da dentro la directory a fuori	

scp [file] [user target machine]@[IP target machine]:[directory target machine] -> trasferisce via SCP da una macchina linux all'altra, chiede password dello user target

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
	
 In caso di heavy use della swap bisogna usare il x2 come regola oppure x1.75
 
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
# modificare il file come segue => fs.file-max = 100000
sysctl -p
/etc/pam.d/login = add => session required pam_limits.so
--------------

cp -R [location] [location] 					-> copia una directory ed i file contenuti in essa in un'altra directory
cp [file] [location] 							-> copia un file in una directory

zip -r [nome].zip [directory] 					-> zippa la directory e il contenuto
zip [nome].zip [file] 							-> zippa il file
unzip [file.zip] -d [directory] 				-> unzippa il file [nella directory]
gzip [filename]									-> zippa il file in .gz
zless [file.zip o file.gz]						-> less di un file zippato
zcat [file.zip o file.gz]

tar -zxvf yourfile.tar.gz 						-> estrae il file nella directory corrente

find /folder/*.log* -type f -not -name "*.gz" -mtime +[days] -exec gzip {} \; 			-> zippa i file *.log* più vecchi di N giorni
find /var/opt/evil-product/logs/*.log* -type f -mtime +30 -exec rm -f {} \; 					-> elimina i file log più vecchi di N giorni

find /opt/more-evil-corp/compac-connector/*.gz* -type f -mtime +40 -exec rm -f {} \; 		-> elimina i file gz più vecchi di 40 giorni

chmod -[1-7][1-7][1-7] [file/directory] 		-> permessi ai vari gruppi 7 = tutti i permessi, 1=read only
chmod -[x,r,w] [file/directory] 				-> toglie permessi di esecuzione, lettura e scrittura all'utente corrente
chmod +[x,r,w] [file/directory] 				-> aggiunge esecuzione, lettura e scrittura all'utente corrente
chmod g+/-[x,r,w] [file/directory] 				-> aggiunge esecuzione, lettura e scrittura al gruppo corrente
chmod u=rwx,g=rx,o=r [file/directory]			-> permessi dati in maniera umana

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

chgrp [nome gruppo] [file/directory] 			-> cambia la proprietà gruppo di una cartella o di un file

chown [owner]:[group] [file/directory]	
chown devops:webgrp [file/directory] 			-> setta nuovo owner per il file in questo caso owner = "devops" group = "webgrp"	

rm (-f) [file] 									-> cancella un file
rm (-d) [directory] 							-> cancella una directory vuota
rm -f *.pdf 									-> cancella tutti i file .pdf (applicabile a tutte le estensioni/nomi file)
rm -rf											-> cancella forzatamente una cartella ed il suo contenuto
rm -r 											-> cancella una cartella ed il suo contenuto
find . -type f -name '*.pdf' -exec rm {} +		-> rimuovi tutti i file PDF dalla folder corrente (e dalle subfolder)

find . -maxdepth 1 -name "*.pdf" -print0 | xargs -0 rm -> 

less [document]									-> visual documento

	> 		-> vai in fondo al documento
	? 		-> cerca dal basso verso l'alto
	/ 		-> cerca dall'altro verso il basso
	
vi [document] 									-> editor documento (i comandi di less funzionano)

	esc 		-> entra in modalità visual
	:w 			-> salva
	:q 			-> esci
	:q! 		-> esci senza salvare
	:wq 		-> esci e salva
	i 			-> entra in modalità insert
	A 			-> entra in append
	GG			-> vai alla fine
	gg			-> vai all'inizio
	dd 			-> cancella riga
	ZZ 			-> esci e salva
	[numero] DD -> elimina N righe


cat [document] 																								-> visual documento
zcat [document]																								-> visual documento zippato

tail -f [document] 																							-> apri in append e rimani in append utile per i log in real time

touch [params: -m modified at -a accessed_at -t created_at] [timestamp format yyyymmddhhmmss.tt] [filename] -> modifica accesso file
es:
touch -m -a -t 202106141136.09 wow.txt

./[nome_script].sh 								-> esegue i comandi contenuti nello script .sh
java -jar [nome_jar].jar 						-> esegue il main contenuto nel .jar

wget [link di dropbox] 							-> scarica una risorsa nella cartella 

locate 												-> trova file
find . -name *nomefile*.txt* 						-> trova file formato txt, txtx etc. che hanno all'interno del nome la parola nomefile all'interno della cartella corrente + subfolders prova ad usare prima il comando cd / in modo da cercare in tutto il pc
find . -type f -print | grep -i "nome o .formato"	-> trova il file in maniera molto intelligente a partire dalla cartella, ti stampa anche la location ed il match colorato

grep -Ril "[testo]" [directory] 				-> cerca un testo all'interno dei file, usare directory / per cercare in tutto il PC

grep "parola o frase" [dir]/*.[file ext]        -> cerca una parola o frase CASE SENSITIVE in una cartella 

grep -i "parola o frase" [dir]/*.[file ext]     -> cerca una parola o frase CASE INSENSITIVE in una cartella 

ps -ef | grep --color=auto [word]				-> colora la parola

zgrep "parola o frase" [dir]/[file zippato]     -> cerca una parola o frase CASE SENSITIVE in file zippato (anche cartella di file zippati)


--- Time ---
date                                            -> fornisce la data attuale
sudo hwclock -s									-> riallinea data di un sottosistema/VM o del computer stesso con il clock


#######################################################################################
################################ CURL #################################################
#######################################################################################

--- GET ---

curl -v http://localhost:8080/gosing/loginc 										-> curl verbose fa chiamata http GET come se fosse browser 
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

eytool -list -keystore file.p12  															-> stampa le info di un p12 di cui hai la psw
keytool -v -list -keystore file.p12  														-> stampa tutte le info (verbose)
openssl pkcs12 -in <certificato>.p12 -out certificate.pem -nodes 							-> estrai certificato [chiede la password]
cat certificate.pem | openssl x509 -noout -enddate 											-> controlla data scadenza
keytool -list -v -keystore cacerts > /tmp/keyStore.txt 										-> estrai le info del certificato in un file [chiede la password]
keytool -importcert -file /location/file.cer -keystore cacerts -alias <alias arbitrario>	-> import certificato

input password: changeit
 -> default psw del default keystore java
 
netsh http add sslcert ipport=0.0.0.0:443 certhash='<inserire hash>' appid='{<inserire-app-id>}' => import cert SSL iis, da testare


openssl req –new –newkey rsa:2048 –nodes –keyout server.key –out server.csr -> crea una richiesta per il certificato SSL dalla macchina FE (fornire server.csr)

openssl genrsa -out private.pem 2048														-> Chiave privata
openssl rsa -in private.pem -outform PEM -pubout -out public.pem							-> Chiave pubblica
openssl req -new -key private.pem -out certificate.csr										-> CSR (Certificate Signing Request)
openssl x509 -req -days 365 -in certificate.csr -signkey private.pem -out certificate.crt	-> Certificato self-signed

openssl x509 -in certificate.crt -out certificate.pem -outform PEM							-> Conversione cert in PEM
openssl x509 -outform der -in grapho.pem -out grapho.crt									-> Conversione PEM in CRT


openssl pkcs12 -export -out certificate.pfx -inkey private.key -in certificate.crt      -> Generazione PFX
openssl pkcs12 -in certificate.pfx -nocerts -out private.key							-> Ottenimento pvt.key da PFX

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
- generare nuovo p12 con certificato finale + chiave privata
 sudo openssl pkcs12 -export -inkey ip1cvliaslbs001.clint.evilcorp.it.key -in 20210322.ip1cvliaslbs001.clint.evilcorp.it.cer -name ip1cvliaslbs001.clint.evilcorp.it -out more-evil-corpcollaudo_20210322.p12

Enter Export Password:
Verifying - Enter Export Password: MT4SxvuJ9Y
- export intermediate e root ca da certificato finale (anche da windows)
- import nel p12 della root e intermediate

 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias intermediate-globalsign-rsa-ov-ssl-ca-2018 -file GlobalSign_RSA_OV_SSL_CA_2018.cer -keystore more-evil-corpcollaudo_20210322.p12 
 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias root-globalsign-ca-r3 -file GlobalSignRootCA_R3.cer -keystore more-evil-corpcollaudo_20210322.p12 

Enter keystore password:  

.JKS
-	Verificare la presenza delle RootCA tramite serialnumber (togliendo lo zero iniziale 04000000000121585308a2) se presente procedere
-	Eliminare vecchio certificato finale della macchina

sudo /usr/java/jdk1.8.0_161/bin/keytool -delete -alias ip1cvliaslbs001.clint.evilcorp.it -keystore 

-	Import del nuovo certificato finale della macchina
 sudo /usr/java/jdk1.8.0_161/bin/keytool -import -alias ip1cvliaslbs001.clint.evilcorp.it -file 20210322.ip1cvliaslbs001.clint.evilcorp.it.cer -keystore cacerts_custom_coll_20210322_P12.jks



.CSR con SAN multipli

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
O = D-Share S.p.A.
OU = DevOps
CN = api-dshare.rcs.it
[v3_req]
keyUsage = keyEncipherment, dataEncipherment, digitalSignature, nonRepudiation
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = api-dshare.rcs.it
DNS.2 = atomos-dshare.rcs.it
DNS.3 = deploy-dshare.rcs.it



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

zgrep -c "phrase to search for" [nome file o cartella/*.ext] 																					-> conta occorrenze

zgrep -A [numero righe prima] -B [numero righe dopo] "phrase to search for" [nome file o espressione regolare *.log] > [file to redirect out] 	-> crea file con porzioni di log che ti scegli signò

zgrep "ParamName:inIFrame" signbook.log.2019-05-* | grep CE800960 

grep -c "phrase to search for" signbook.log.2019-0?-?? 																							-> conta occorrenze

------------------
--- MAGIC      ---
------------------

watch tail [file]                                         				-> fa cose alla fine del file

watch "tail [file tipicamente di log]|cut -b 1-180 -n 25" 				-> ultime 25 righe del file, e continua a fare il tail ogni 2 secs

watch -n [intervallo in secondi] [comando]                				-> ogni N secondi fa watch del comando

cat [file] | tr -d ',' | awk '{print "\""$0"\","}' > [file nuovo] 		-> cancella virgole da file e con awk rende gli ID sqlizzabili

export LOG=evil-product.log ; ( for w in $(zgrep -Po '(it|eu)(\.[a-zA-Z][a-zA-Z0-9]+){2,10}' $LOG|sort|uniq) ; do echo $(zgrep -i $w $LOG | wc -c) "$w" ; do
ne ) | sort -k 1 -n | tail -n 10

=> legge le maggiori classi che loggano nel log e le elenca

sort [file]  | awk '!/^$/' | awk '!/^#/' > [result file] 	 			 -> elimina tutti i commenti e gli spazi vuoti da un file e ne stampa le righe
																			in modo ordinato, utile per controllare properties

# https://medium.com/@joelbelton/the-most-important-linux-commands-that-nobody-teaches-you-ce423ef2ae28