// lukegriffith.tf
// subset of  records under lukegriffith.co.uk.

data "aws_route53_zone" "selected" {
  name         = "lukegriffith.co.uk."
  private_zone = false
}


variable "public_ip_address" {
    description = "public ip address to set."
}


resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "dwelling.lukegriffith.co.uk"
  type    = "A"
  ttl     = "120"
  records = ["${var.public_ip_address}"]
}