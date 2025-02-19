# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module "monitoring" {
  source               = "./monitoring"
  gcp_project_id       = data.google_project.info.project_id
  gcp_project_number   = data.google_project.info.number
  enable_asm           = var.enable_asm
  frontend_external_ip = data.kubernetes_service.frontend_external_service.status[0].load_balancer[0].ingress[0].ip
  gke_cluster_name     = var.gke_cluster_name
  # re-use prefix to customize resources within the same project
  name_suffix = length(var.state_prefix) > 0 ? "-${var.state_prefix}" : ""

  depends_on = [
    null_resource.wait_pods_are_ready,
  ]
}
