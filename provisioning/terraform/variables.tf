/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Required input variables
variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID to apply this config to"
}

variable "state_bucket_name" {
  type        = string
  description = "The GCS bucket URL where Terraform stores the state"
}

# Optional input variables
variable "asm_channel" {
  type        = string
  description = "Defines one of the following managed ASM channels/revisions: 'rapid', 'regular' or stable'"
  default     = "stable"
  validation {
    condition     = can(regex("^(rapid|regular|stable)$", var.asm_channel))
    error_message = "ASM channel or revision can be only rapid, regular or stable"
  }
}

variable "enable_asm" {
  type        = bool
  description = "If true, installs Anthos Service Mesh (managed version of Istio) on the GKE cluster"
  default     = false
}

variable "filepath_manifest" {
  type        = string
  description = "Path to Kubernetes resources, written using Kustomize"
  default     = "../kustomize/online-boutique/"
}

variable "gke_cluster_name" {
  type        = string
  description = "Name given to the new GKE cluster"
  default     = "cloud-ops-sandbox"
}

variable "gke_cluster_location" {
  type        = string
  description = "Region or zone of the new GKE cluster"
  default     = "us-central1"
}

# Default values for node pool support connecting the cluster to ASM
# https://cloud.google.com/service-mesh/docs/unified-install/anthos-service-mesh-prerequisites#cluster_requirements
variable "gke_node_pool" {
  type = object({
    initial_node_count = number
    labels             = map(string)
    machine_type       = string

    autoscaling = object({
      max_node_count = number
      min_node_count = number
    })
  })
  description = "Initial settings and autoscale configuration of the GKE cluster's default node pool"
  default = {
    initial_node_count = 4
    labels             = {}
    machine_type       = "e2-standard-4"
    autoscaling        = null
  }
}

variable "state_prefix" {
  type        = string
  description = "Use to store multiple states when provisioning with the same state_bucket_name"
  default     = ""
}

variable "vpc-name" {
  type        = string
  description = "Custom VPC Name"
  default     = "default"
}