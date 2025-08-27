terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.3"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = module.gke.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_client_config" "default" {}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                   = "~> 5.0"
  project_id               = var.project_id
  name                     = var.cluster_name
  region                   = var.region
  zones                    = var.zones
  network                  = var.network
  subnetwork               = var.subnetwork
  ip_range_pods            = var.ip_range_pods
  ip_range_services        = var.ip_range_services
  enable_network_policy    = var.enable_network_policy
  enable_private_nodes     = var.enable_private_nodes
  enable_private_endpoint  = var.enable_private_endpoint
  initial_node_count       = var.initial_node_count
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.min_node_count
      max_count          = var.max_node_count
      preemptible        = var.preemptible
      disk_size_gb       = var.disk_size_gb
      disk_type          = var.disk_type
      image_type         = var.image_type
      local_ssd_count    = var.local_ssd_count
      tags               = var.node_pool_tags
    }
  ]
}

output "kubeconfig" {
  value = module.gke.kubeconfig_raw
  sensitive = true
}

output "cluster_endpoint" {
  value = module.gke.endpoint
}

output "cluster_ca_certificate" {
  value = module.gke.ca_certificate
}
