variable "location" {
  type        = string
  description = "The Azure region used for resource deployment"
}

variable "name" {
  type        = string
  description = "The AKS cluster resource name"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the reosurce group in which the K8s cluster will be deployed"
}

variable "dns_prefix" {
  type        = string
  description = "The cluster DNS prefix"
}

variable "default_node_pool_vm_size" {
  type        = string
  description = "The Azure VM size of the default node pool"
}

variable "default_node_pool_node_count" {
  type        = number
  description = "The set number of nodes created for the default node pool"
}

variable "acr_id" {
  type        = string
  description = "The ID of the Azure container registry"
}