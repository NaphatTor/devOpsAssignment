# GCP project and region
project_id           = "my-gcp-project"
region               = "asia-southeast1"
zones                = ["asia-southeast1-a", "asia-southeast1-b", "asia-southeast1-c"]

# VPC network and subnetwork
network              = "default"
subnetwork           = "default"
ip_range_pods        = "10.0.0.0/14"
ip_range_services    = "10.4.0.0/20"

# Cluster settings
cluster_name         = "my-gke-cluster"
enable_network_policy = true
enable_private_nodes  = false
enable_private_endpoint = false
initial_node_count    = 1

# Node pool settings
machine_type         = "e2-medium"
min_node_count       = 1
max_node_count       = 3
preemptible          = false
disk_size_gb         = 50
disk_type            = "pd-standard"
image_type           = "COS_CONTAINERD"
local_ssd_count      = 0
node_pool_tags       = ["gke-node"]
