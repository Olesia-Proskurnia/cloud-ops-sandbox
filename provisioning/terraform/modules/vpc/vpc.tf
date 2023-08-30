resource "google_project_service" "enable-services" {
  for_each = toset(var.services_to_enable)
  project = var.gcp_project_id
  service = each.value
  disable_on_destroy = false
}
resource "google_compute_network" "demo-vpc" {
  name = var.vpc-name                   
  auto_create_subnetworks = true
  depends_on = [
    google_project_service.enable-services
  ]
 project = var.gcp_project_id
}

# resource "google_compute_subnetwork" "subnets" {
#   for_each = {for a_subnet in var.regions: a_subnet.region => a_subnet}
#   name = "${each.value.region}"
#   ip_cidr_range =  "${each.value.cidr}"       
#   region        = "${each.value.region}"
#   network       = google_compute_network.demo-vpc.id
#   private_ip_google_access = true
#   project = var.gcp_project_id
#   depends_on = [
#     google_compute_network.demo-vpc
#     ]
# }
