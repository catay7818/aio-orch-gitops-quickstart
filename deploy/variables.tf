variable "name" {
  description = "The unique primary name used when naming resources. (ex. 'test' makes 'rg-test' resource group)"
  type        = string
  nullable    = false
  validation {
    condition     = var.name != "sample-aio" && length(var.name) < 15 && can(regex("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$", var.name))
    error_message = "Please update 'name' to a short, unique name, that only has lowercase letters, numbers, '-' hyphens."
  }
}

variable "location" {
  type    = string
  default = "westus3"
}

variable "resource_group_name" {
  description = "(Optional) The resource group name where the Azure Arc Cluster resource is located. (Otherwise, 'rg-<var.name>')"
  type        = string
  default     = null
}

variable "arc_cluster_name" {
  description = "(Optional) the Arc Cluster resource name. (Otherwise, 'arc-<var.name>')"
  type        = string
  default     = null
}

variable "flux_cluster_namespace" {
  description = "(Optional) The Kubernetes namespace for the flux components. (Otherwise, 'flux-system')"
  type        = string
  default     = "flux-system"
}

variable "gitops_source_repo" {
  description = "(Optional) The GitOps repo that will be deployed to the cluster. (Otherwise, 'https://github.com/Azure-Samples/azure-edge-extensions-aio-observability-gitops')"
  type        = string
  default     = "https://github.com/Azure-Samples/azure-edge-extensions-aio-observability-gitops"
}

variable "gitops_branch" {
  description = "(Optional) The GitOps repo branch that will be deployed to the cluster. (Otherwise, 'main')"
  type        = string
  default     = "main"
}

variable "gitops_kustomization_path" {
  description = "(Optional) The GitOps flux kustomization path that will be deployed to the cluster. (Otherwise, './clusters/dev/flux')"
  type        = string
  default     = "./clusters/dev/flux"
}