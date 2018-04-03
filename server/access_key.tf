resource "aws_key_pair" "training" {
  key_name   = "${var.identity}-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
