output "ecr_image_url" {
  value       = "${var.ECR_REPO}:${var.DOCKER_IMAGE_TAG}"
  description = "Full URL to image in ecr with tag"
}