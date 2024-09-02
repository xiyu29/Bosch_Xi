terraform {
  required_providers {
    alicloud = {
      source = "hashicorp/alicloud"
      version = "1.212.0"
    }
  }
}

provider "alicloud" {
  access_key=var.access_key
  secret_key=var.secret_key
  region="cn-beijing"
}