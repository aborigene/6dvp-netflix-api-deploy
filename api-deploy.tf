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
resource "kubernetes_namespace" "dvp6-netflix" {
  metadata {
    name = "dvp6-netflix"
  }
}
resource "kubernetes_deployment" "netflix-product-details" {
  metadata {
    name      = "dvp6-netflix-product-details"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
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
          image_pull_policy = "Always"
          port {
            container_port = 8083
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "netflix-product-details" {
  metadata {
    name      = "dvp6-netflix-product-details"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.netflix-product-details.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      #node_port   = 8083
      port        = 8083
      target_port = 8083
    }
  }
}
resource "kubernetes_service" "netflix-auth-db" {
  metadata {
    name      = "dvp6-netflix-auth-db"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.netflix-auth-db.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 3306
      target_port = 3306
    }
  }
}
resource "kubernetes_deployment" "netflix-auth-db" {
  metadata {
    name      = "dvp6-netflix-auth-db"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "dvp6-netflix-auth-db"
      }
    }
    template {
      metadata {
        labels = {
          app = "dvp6-netflix-auth-db"
        }
      }
      spec {
        container {
          image = "igoroschsimoes/6dvp-microservices:auth-db-1.0.0"
          name  = "dvp6-netflix-auth-db"
          image_pull_policy = "Always"
          port {
            container_port = 3306
          }
        }
      }
    }
  }
}
resource "kubernetes_deployment" "netflix-auth-db-client" {
  metadata {
    name      = "dvp6-netflix-auth-db-client"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "dvp6-netflix-auth-db-client"
      }
    }
    template {
      metadata {
        labels = {
          app = "dvp6-netflix-auth-db-client"
        }
      }
      spec {
        container {
          image = "mysql:8.0.23"
          name  = "dvp6-netflix-auth-db-client"
          image_pull_policy = "Always"
          env{
            name= "MYSQL_ROOT_PASSWORD" 
            value = "123456789"
          }
          env{
            name = "MYSQL_USER"
            value = "auth-user"
          }
          env{
            name = "MYSQL_PASSWORD"
            value = "123456789auth"
          }
        }
      }
    }
  }
}
resource "kubernetes_deployment" "netflix-auth" {
  metadata {
    name      = "dvp6-netflix-auth"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "dvp6-netflix-auth"
      }
    }
    template {
      metadata {
        labels = {
          app = "dvp6-netflix-auth"
        }
      }
      spec {
        container {
          image = "igoroschsimoes/6dvp-microservices:auth-1.0.0"
          name  = "dvp6-netflix-auth"
          image_pull_policy = "Always"
          env {
            name  = "DB_SERVER"
            value = kubernetes_service.netflix-auth-db.spec.0.cluster_ip
          }
          env {
            name  = "DB_PORT"
            value = kubernetes_service.netflix-auth-db.spec.0.port.0.port
          }
          env {
            name  = "DB_USERNAME"
            value = "root"
          }
          env {
            name  = "DB_PASSWORD"
            value = "123456789"
          }
          port {
            container_port = 8090
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "netflix-auth" {
  metadata {
    name      = "dvp6-netflix-auth"
    namespace = kubernetes_namespace.dvp6-netflix.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.netflix-auth.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      port        = 8090
      target_port = 8090
    }
  }
}