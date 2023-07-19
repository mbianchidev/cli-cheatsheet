#######################################################################################
################################ Helm - Commands ######################################
#######################################################################################

helm install <package>.yaml => installa il pacchetto definito dallo yaml
helm update                 => deprecato, fa update del pacchetto definito
                                nello yaml se disponibile
helm repo update            => cugino non deprecato di helm update, fa update del pacchetto definito
                                nello yaml se disponibile

helm template -f <input-file-value>.yaml <chart-name> <chart-location> > <output-file>.yaml => 								
helm template -f <input-file-value>.yaml <chart-name> <chart-location> > <output-file>.yaml => 								
	example: helm template -f svts.yaml evil-product ../ > test_ts_int.yaml