resource "azurerm_arc_kubernetes_cluster_extension" "flux" {
  name           = "flux"
  cluster_id     = local.cluster_id
  extension_type = "microsoft.flux"

  identity {
    type = "SystemAssigned"
  }

  release_namespace = var.flux_cluster_namespace
}

resource "azurerm_arc_kubernetes_flux_configuration" "config" {
  name       = "flux-config"
  cluster_id = local.cluster_id

  namespace = var.flux_cluster_namespace
  scope     = "cluster"


  git_repository {
    url             = var.gitops_source_repo
    reference_type  = "branch"
    reference_value = var.gitops_branch
  }

  kustomizations {
    name = "bootstrap"
    path = var.gitops_kustomization_path
  }

  depends_on = [
    azurerm_arc_kubernetes_cluster_extension.flux
  ]
}