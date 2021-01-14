#create internetgateway output

output "internet_gateway_id" {
  value = aws_internet_gateway.ill_peer_central-ing.id
}
