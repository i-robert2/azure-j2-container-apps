variable "project" { type = string }
variable "environment" { type = string }
variable "region" {
  type    = string
  default = "westeurope"
}
variable "region_short" {
  type    = string
  default = "weu"
}
variable "instance" {
  type    = string
  default = "001"
}
variable "owner" { type = string }
variable "keep_until" { type = string }
