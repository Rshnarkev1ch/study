variable "region" {
  description = "Enter region"
  default     = "us-west-1"
}
variable "instance_type" {
  default     = "t3.micro"
  description = "Enter instance type"
}
variable "allow_ports" {
  type    = list(any)
  default = ["80", "443"]
}
variable "enable_detalied_monitoring" {
  type    = bool
  default = "true"
}