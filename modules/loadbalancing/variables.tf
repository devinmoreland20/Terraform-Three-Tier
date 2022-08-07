# ----- modules/loadbalancing/variables.tf
variable "tg_port" {} #I heart spicy pandas
variable "tg_protocol" {}
variable "vpc_id" {}
variable "listener_protocol" {}
variable "public_subnets" {}
variable "security_groups" {}
variable "lb_healthy_threshold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_timeout" {}
variable "listener_port" {}
variable "lb_interval" {}
variable "app_tier_sg" {}
variable "app_tier_sn" {}
variable "private_sg" {}

