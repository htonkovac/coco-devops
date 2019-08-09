resource "aws_ecr_repository" "frontend" {
  name = "eks_container_repo/frontend"
}
resource "aws_ecr_repository" "backend_1" {
  name = "eks_container_repo/backend-1"
}
resource "aws_ecr_repository" "backend_2" {
  name = "eks_container_repo/backend-2"
}