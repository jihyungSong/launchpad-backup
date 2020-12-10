terraform {
    backend "s3" {}
}

provider "template" {}

provider "aws"{
    region              = var.region
}
