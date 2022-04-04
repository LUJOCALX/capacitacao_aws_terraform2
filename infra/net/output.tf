# Saida de informações módulo do net

output "vpc" {
  value = "${aws_vpc.ljc_vpc_tf.id}"
}
output "sn_publicas" {
  value = "${aws_subnet.subnet_publica}"
}
output "sn_privadas" {
  value = "${aws_subnet.subnet_privada}"
}
output "sn_pub_a" {
  value = "${aws_subnet.subnet_publica["ljc_subnet_pub_a"].id}"
}
output "sn_pub_b" {
  value = "${aws_subnet.subnet_publica["ljc_subnet_pub_b"].id}"
}
output "sn_pub_c" {
  value = "${aws_subnet.subnet_publica["ljc_subnet_pub_c"].id}"
}

output "sn_prv_a" {
  value = "${aws_subnet.subnet_privada["ljc_subnet_prv_a"].id}"
}
output "sn_prv_b" {
  value = "${aws_subnet.subnet_privada["ljc_subnet_prv_b"].id}"
}
output "sn_prv_c" {
  value = "${aws_subnet.subnet_privada["ljc_subnet_prv_c"].id}"
}