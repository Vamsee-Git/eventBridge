terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-vamsee"
    key            = "terraform/eventBridge/statefile"
    region         = "ap-south-1"
    encrypt        = true
  }
}
