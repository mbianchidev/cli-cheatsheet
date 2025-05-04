# Official doc here https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

### BASICS ###

kubectl version                                                 => versione di kubectl e di k8s sul cluster (server)

kubectl get nodes                                               => versione di k8s sui nodi fisici presenti

kubectl explain deployment                          			=> spiega i campi/oggetti del deployment

kubectl explain deployment --recursive              			=> spiega i campi compresi quelli dei campi/oggetti stessi

kubectl explain deployment.metadata.name						=> spiega un singolo campo con info sul contenuto

vi deployment/configuration.yaml                    			=> modifica il file di configurazione del cluster

export KUBECONFIG=/home/mbianchi/.kube/config        			=> setta la variabile d'ambiente per il config file
kubectl config get-contexts                        			    => mostra tutti i context di configurazione
kubectl config use-context <yourClusterName>                    => imposta il context di configurazione

kubectl create -f deployments/d-conf.yaml           			=> crea un cluster deployment basandosi su quanto scritto nel d-conf.yaml
kubectl create -f services/s-conf.yaml              			=> crea un cluster service basandosi su quanto scritto nel s-conf.yaml
kubectl apply -f deployments/d-conf.yaml            			=> crea o aggiorna un cluster deployment basandosi su quanto scritto nel d-conf.yaml

kubectl get <resource-type> <resource-name> -o yaml|json        => mostra un singolo oggetto in formato yaml oppure json

kubectl get namespace                                           => mostra tutti i namespace del context corrente

kubectl get deployments                            				=> visualizza i cluster creati 

kubectl get replicasets                             			=> visualizza i replicasets disponibili

kubectl get pods                                    			=> visualizza i POD disponibili (name, etc.)

kubectl get services <service name>                	 			=> visualizza il servizio con i suoi dati (Tipo, cluster IP,external IP, stato...)

kubectl get hr -n <namespace>									=> get helm release all'interno del namespace specificato

kubectl cluster-info                                			=> visualizza le info del cluster

kubectl config view                                 			=> visualizza la configurazione attuale del cluster (utile per capire con cosa sta girando)

kubectl delete pods <pod-name> [--grace-period=0 --force]  		=> cancella il POD [senza alcun grace period, forzando l'eliminazione]

kubectl patch pod <pod> -p '{"metadata":{"finalizers":null}}'	=> cancella i POD senza alcun grace period

### SECRETS ###

kubectl create secret generic <secret-name> --from-file=<file-path>	   => crea un secret basandosi su un file di configurazione

#### LOGS ###

kubectl logs -f <pod> -n <namespace> | grep <something>		=> advanced logs

kubectl logs <pod-name>                                		=> log del pod

### KUBE ALIAS + MAGIC ###

If kube  doesn't work
> delete cache in .aws .kube folders
direnv allow .

k logs --since=1h --tail=1000000000 -l 'component in (backend)' -c evil-productmm-svts-platform-evil-product |grep "ERROR" -A 100 |pbcopy

k logs --since=1h --tail=1000000000: log di 1h e tail di X righe
-l component in (backend): describe pod => label component ='quello che cerchi' => 
-c: container
grep "ERROR" -A 100: qui le magie solite dei log
pbcopy: console

AWS distribution è amazon linux che è RedHat CentOS

### copia file dal tuo terminale ###

yum install tar

#Download dal pod (dal pod?)
k cp evil-productmm-svts-platform-namespace/responder-596f67bd7c-2vgj7:/opt/evil-product/conf/Aspose.Total.Java.lic /home/username/logs/Aspose.lic

#Upload sul pod (dal tuo terminale zsh)
k cp /mnt/c/Users/mbian/Downloads/<file> <namespace>/<POD-name>:/opt/evil-product/conf/<file>

es:
k cp /home/username/logs/Aspose.lic evil-productmm-svts-platform-namespace/responder-596f67bd7c-2vgj7:/opt/evil-product/conf/Aspose.Total.Java.lic


### KUBE ADM ###

kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=<username or $(<here commands to get user>)> 
=> privilegi admin sul cluster
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
=> dashboard

### FRONTEND ###

kubectl create secret generic tls-certs --from-file tls/                        
                                                    => crea TLS cert
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf    
                                                    => crea una configmap nginx a partire dalla conf
kubectl create -f deployments/frontend.yaml                                     
                                                    => crea frontend deployment
kubectl create -f services/frontend.yaml                                        
                                                    => crea frontend service

curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`  
                                                    => one line per fare curl su loadBalancer

### SCALING ###

kubectl explain deployment.spec.replicas             
                                                    => sapere quante replica ci sono
kubectl scale deployment <deployment-name> --replicas=<num>
                                                    => setta le replica a <num> creando i PODs (upscale/downscale)
kubectl get pods | grep <deployment-name>- | wc -l
                                                    => conta i pod grep per nome

### UPDATE ###

kubectl rollout history deployment/<deployment-name>
                                                    => storia degli update
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
                                                    => nome delle immagini deployate (con versione)

kubectl rollout pause deployment/<deployment-name>
                                                    => mette in pausa l'update
kubectl rollout resume deployment/<deployment-name>
                                                    => ricomincia l'update
kubectl rollout status deployment/<deployment-name>
                                                    => stato dell'update
kubectl rollout undo deployment/<deployment-name> 
                                                    => rollback

### NETWORK ###

kubectl proxy &                                
    => fa partire un proxy da kube
kubectl port-forward --namespace default $(kubectl get pods --namespace default -l "cluster=spin-deck" \
    -o jsonpath="{.items[0].metadata.name}") 8080:9000 >> /dev/null &
    => prende i pod con la get e fa port forwarding

### ROLES ###

kubectl create clusterrolebinding user-admin-binding \
    --clusterrole=cluster-admin --user=<account>    => create role admin and bind it to user account

### MANAGE ###

# Elimina i POD in tutti i namespace a partire da uno stato o da una caratteristica
kubectl get pods --all-namespaces | grep [status|prefix] | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod

#esempio eliminare tutti i pod in stato Terminating in tutti i namespace
kubectl get pods --all-namespaces | grep -i "terminating" | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod

######

kubectl config set-cluster <cluster name>

kubectl kubectl create namespace <name> --dry-run=client -o yaml | kubectl apply -f -