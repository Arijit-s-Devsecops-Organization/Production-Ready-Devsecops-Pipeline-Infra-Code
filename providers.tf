terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 3.1.0"
    }
  }
}

# aws provider configuration
provider "aws" {
  region = var.region
}

# helm provider configuration
provider "helm" {
  kubernetes = {
    host = aws_eks_cluster.main_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main_eks_cluster.certificate_authority[0].data)
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main_eks_cluster.name]
    }
  }
}




