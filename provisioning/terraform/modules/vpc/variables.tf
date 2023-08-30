# GCP Project Name
variable "gcp_project_id" {}
variable "vpc-name" {}
# List of regions (support for multi-region deployment)
# variable "regions" {}

variable "services_to_enable" {
    description = "List of GCP Services to enable"
    type    = list(string)
    default =  [
        "compute.googleapis.com",
        "iam.googleapis.com",
        "logging.googleapis.com",
        "monitoring.googleapis.com",
        "opsconfigmonitoring.googleapis.com",
        "serviceusage.googleapis.com",
        "stackdriver.googleapis.com",
        "servicemanagement.googleapis.com",
        "servicecontrol.googleapis.com",
        "networkmanagement.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "trafficdirector.googleapis.com",
        "dns.googleapis.com",
        "servicenetworking.googleapis.com",
        "firewallinsights.googleapis.com"
    ]
}