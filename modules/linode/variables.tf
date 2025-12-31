variable "label" {
  type = string
}

variable "region" {
  type    = string
  default = "id-cgk"
}

variable "type" {
  type    = string
  default = "g6-standard-2"
}

variable "ssh_key" {
  type = list(string)
}