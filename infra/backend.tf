terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-vamsee"
    key            = "terraform/eventBridge/statefile"
    region         = "us-west-1"
    encrypt        = true
  }
}
