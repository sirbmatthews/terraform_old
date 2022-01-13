terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.19.1"
    }
  }
}

provider "github" {
  token     = ""
}

resource "github_repository" "test_repo" {
  name        = "app-repo"
  visibility = "private"
}