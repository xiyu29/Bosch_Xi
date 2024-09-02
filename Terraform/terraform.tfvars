ecs_instances = {
  instance1 = {
    type     = "ecs.sn1ne.large"
    image_id = "ubuntu_22_04_x64_20G_alibase_20240710.vhd"
    name     = "Bosch-instance-1"
    tag      = "Bosch-ECS-1"
  }
  instance2 = {
    type     = "ecs.sn1ne.large"
    image_id = "ubuntu_22_04_x64_20G_alibase_20240710.vhd"
    name     = "Bosch-instance-2"
    tag      = "Bosch-ECS-2"
  }
  instance3 = {
    type     = "ecs.sn1ne.large"
    image_id = "ubuntu_22_04_x64_20G_alibase_20240710.vhd"
    name     = "Bosch-instance-3"
    tag      = "Bosch-ECS-3"
  }
}