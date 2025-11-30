variable "location" {
  default = "italynorth"
}

variable "resource_group_name" {
  default = "tmp-aks-nginx"
}

variable "cluster_name" {
  default = "tmp-aks-nginx"
}

# Cheapest supported AKS VM
variable "node_vm_size" {
  default = "Standard_B2s"
}

