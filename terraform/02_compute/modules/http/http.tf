data "http" "ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  my_ip = chomp(data.http.ip.response_body)
}