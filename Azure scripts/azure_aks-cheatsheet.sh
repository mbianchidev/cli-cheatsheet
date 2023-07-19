# Attach existing ACR to existing AKS cluster
az aks update -n <AKS cluster name> -g <ACR resource group> --attach-acr <my ACR name>

# Check if cluster can pull from ACR
az aks check-acr --name <AKS cluster name> --resource-group <ACR resource group> --acr <my ACR name>

# List all aks clusters
az aks list -o table

# Gets credentials for single cluster
az aks get-credentials -n <yourClusterName> -g <yourResourceGroupName>