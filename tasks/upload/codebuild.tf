# Create ECR repository
resource "aws_ecr_repository" "ecr_service" {
 name = "${var.ECR_REPO}"
}


# Checks if build folder has changed
#data "external" "build_folder" {
#  program = ["${path.module}/bin/folder_contents.sh", var.DOCKER_PATH]
#}

# Builds test-service and pushes it into aws_ecr_repository
resource "null_resource" "build_and_push" {
 
  # See build.sh for more details
  provisioner "local-exec" {
    command = "./load.sh ${"."} ${aws_ecr_repository.ecr_service.repository_url}:${var.DOCKER_IMAGE_TAG} ${var.AWS_REGION} ${var.AWS_ACCESS_KEY} ${var.AWS_SECRET_KEY}  >> completed.txt"
  }
}