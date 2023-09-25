# Official documentation here: https://www.terraform.io/cli

### Basics ###

variable "init" {
  description = "Initialization of the repository"
  default = "terraform init"
  parameters = {
    -migrate-state = "Migrate the state file from one backend to another"
  }
}

variable "plan" {
  description = "Apply the changes without actually applying them but report what would happen"
  default = "terraform plan"
  parameters = {
      -var-file = "variables.tfvars", # Load variables from a file
      -o = "out.plan", # Write the plan to a file
  }
}

variable "apply" {
  description = "Apply the changes"
  default = "terraform apply"
}

variable "force-unlock" {
  description = "Force unlock the state file"
  default = "terraform force-unlock"
}

variable "destroy" {
  description = "Destroy (but first let's see what happens) the infrastructure"
  default = "terraform (plan) destroy"
}

variable "output" {
  description = "Output the values of the variables"
  default = "terraform output"
}

variable "taint" {
  description = "Taint a resource"
  default = "terraform taint"
}

variable "untaint" {
  description = "Untaint a resource"
  default = "terraform untaint"
}

variable "state" {
  description = "Manage the state file"
  default = "terraform state"
}

variable "validate" {
  description = "Validate the configuration"
  default = "terraform validate"
}

variable "graph" {
  description = "Generate a graph of the Terraform configuration"
  default = "terraform graph"
}

variable "show" {
  description = "Show the contents of the state file"
  default = "terraform show"
}

variable "console" {
  description = "Open the Terraform console"
  default = "terraform console"
}

variable "fmt" {
  description = "Format the configuration files"
  default = "terraform fmt"
}

variable "workspace-list" {
  description = "List the workspaces"
  default = "terraform workspace list"
}

variable "workspace-new" {
  description = "Create a new workspace"
  default = "terraform workspace new"
}

variable "workspace-select" {
  description = "Select a workspace"
  default = "terraform workspace select"
}

variable "import" {
  description = "Import a resource"
  default = "terraform import"
}

variable "export" {
    description = "Export a resource"
    default = "terraform export"
}

variable "state-mv" {
  description = "Move a resource"
  default = "terraform state mv"
}

variable "state-rm" {
  description = "Remove a resource"
  default = "terraform state rm"
}

variable "state-ls" {
  description = "List the resources"
  default = "terraform state ls"
}

variable "state-show" {
  description = "Show the contents of the state file"
  default = "terraform state show [resource]"
}

### Intermediate ###

# terraform import <resource-type>.<resource-name> [arn AWS or ID]:app/platform/name																		-> importa una risorsa
# 	terraform import aws_sns_platform_application.apns_application arn:aws:sns:eu-west-1:669508467319:app/APNS_SANDBOX/giuffre-DNM-preprod		
# 	
# terraform state rm <resource-type>.<resource-name>																										-> rimuove una risorsa importata
# 	terraform state rm aws_sns_platform_application.apns_application
# 
# terraform plan -out plan.tfp && terraform show -json plan.tfp > plan.json																				-> ottieni un json a partire da un terraform plan file in out
# 