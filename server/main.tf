variable "ami" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "vpc_security_group_id" {}

variable "identity" {}

resource "aws_instance" "web" {
  # ... Meta parameters -- Available for all terrafrom code 
  #Amazom machine id AMI
  ami = "${var.ami}"

  instance_type = "${var.instance_type}"

  #network access
  subnet_id = "${var.subnet_id}"

  # firewall 
  vpc_security_group_ids = ["${var.vpc_security_group_id}"]

  # get from access_key.tf file
  key_name = "${aws_key_pair.training.key_name}"

  connection  {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }

  tags {
    "Identity" = "${var.identity}"
    "Name"     = "Shriram"
    "group"    = "CASM"
    "domain"   = "Bionformatics"
  }

  # ...
}

output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.public_dns}"
}
