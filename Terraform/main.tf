resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = "cn-beijing-a"
}

resource "alicloud_security_group" "sg" {
  name   = "sg"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_all_tcp_ingress" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 2
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_tcp_egress" {
  type              = "egress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 2
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_icmp_ingress" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_icmp_egress" {
  type              = "egress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "random_password" "password" {
  for_each = var.ecs_instances
  length   = 16
  special  = true
}

resource "alicloud_instance" "instance" {
  for_each            = var.ecs_instances

  availability_zone = "cn-beijing-a"
  security_groups   = alicloud_security_group.sg.*.id

  instance_type              = each.value.type
  system_disk_category       = "cloud_efficiency"
  image_id                   = each.value.image_id
  instance_name              = each.value.name
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 10
  password                   = random_password.password[each.key].result

  internet_charge_type = "PayByTraffic"

  tags = {
    Name = each.value.tag
  }
}

resource "null_resource" "ping_test" {
  for_each = var.ecs_instances

  provisioner "local-exec" {
    command = "sleep 10"
  }


  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = alicloud_instance.instance[each.key].public_ip
      user     = "root"
      password = random_password.password[each.key].result
      timeout = "2m"
    }

    inline = [
      "ping -c 4 ${alicloud_instance.instance[element(tolist(keys(var.ecs_instances)), (index(tolist(keys(var.ecs_instances)), each.key) + 1) % length(var.ecs_instances))].public_ip} > tmp/${each.value.name}.txt",
      "echo 'Ping from ${each.key} to instance${(index(tolist(keys(var.ecs_instances)), each.key) + 1) % length(var.ecs_instances) + 1} completed.'",
      "exit"
    ]

    on_failure = continue
  }

  triggers = {
    instance_count = length(var.ecs_instances)
  }

  depends_on = [
    alicloud_instance.instance
  ]
}
