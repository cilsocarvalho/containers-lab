output "nlb_url" {
  value = "http://${aws_lb.nlb.dns_name}"
}
output "cluster_name" {
  value = aws_ecs_cluster.app.name
}
