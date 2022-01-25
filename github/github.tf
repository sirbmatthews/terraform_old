terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.19.1"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "test_repo" {
  name       = "cloudformation_dump"
  visibility = "private"
}
