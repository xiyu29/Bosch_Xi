variable "ecs_instances" {
  type = map(object({
    type     = string
    image_id = string
    name     = string
    tag      = string
  }))
}

variable "access_key" {
  type    = string
}

variable "secret_key" {
  type    = string
}