resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "tmp-aks-nginx"

  default_node_pool {
    name            = "default"
    node_count      = 1 # cheapest possible
    vm_size         = var.node_vm_size
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Free" # avoids Premium control plane
}

# ------------------
# NGINX Deployment
# ------------------
resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "tmp"
    labels = {
      app = "tmp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "tmp"
      }
    }

    template {
      metadata {
        labels = {
          app = "tmp"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# ------------------
# NGINX LoadBalancer
# ------------------
resource "kubernetes_service" "nginx_lb" {
  metadata {
    name = "tmp"
  }

  spec {
    selector = {
      app = "tmp"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

