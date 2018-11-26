// zone.tf
// subset of  records under the supplied zone.

data "aws_route53_zone" "selected" {
  name         = "${var.zone_name}."
  private_zone = false
}


resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.a_record}.${var.zone_name}"
  type    = "A"
  ttl     = "120"
  records = ["${var.public_ip_address}"]
}