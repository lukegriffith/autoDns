terraform {
  backend "s3" {
    bucket = "lukeg-tfstate"
    key    = "autodns.tfstate"
    region = "eu-west-2"
  }
}
