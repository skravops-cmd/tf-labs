output "nginx_public_ip" {
  value = kubernetes_service.nginx_lb.status[0].load_balancer[0].ingress[0].ip
}

