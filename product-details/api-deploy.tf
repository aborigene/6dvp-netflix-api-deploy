terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}
resource "kubernetes_namespace" "netflix-test" {
  metadata {
    name = "dvp6-netflix-product-details"
  }
}
resource "kubernetes_deployment" "netflix-test" {
  metadata {
    name      = "dvp6-netflix-product-details"
    namespace = kubernetes_namespace.netflix-test.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "dvp6-netflix-product-details"
      }
    }
    template {
      metadata {
        labels = {
          app = "dvp6-netflix-product-details"
        }
      }
      spec {
        container {
          image = "igoroschsimoes/6dvp-microservices:product_details-0.0.1-SNAPSHOT"
          name  = "dvp6-netflix-product-details-container"
          port {
            container_port = 8083
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "netflix-test" {
  metadata {
    name      = "dvp6-netflix-product-details"
    namespace = kubernetes_namespace.netflix-test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.netflix-test.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      #node_port   = 8083
      port        = 8083
      target_port = 8083
    }
  }
}