---
title: "Use Terraform to Deploy Hugo to Vercel"
date: 2024-02-26T18:20:44+08:00
---

## Overview
As I mentioned in previous post, Terraform has Vercel provider. With this, we can configure our Vercel project through Terraform. This post will show you how to do that. Before that, here is some reasons on using Terraform to deploy Vercel.
- Vercel has web UI and CLI.
  - Web UI requires me navigate through the web interface. I'm not a fan of it, not efficient
  - CLI is relatively simple. It requires me to install the CLI tools. I want to avoid this to reduce packages bloat in my device.
- Terraform provide you state for each resources. So the actual resources aligned with what we define.
- I already use Terraform in other projects. So this will reduce the overhead to maintain different stacks.

## Deploying to Vercel with Terraform
1. Ensure we have the Vercel API token created
2. Create new `main.tf` with following:
    ```
    terraform {
      required_providers {
        vercel = {
          source  = "vercel/vercel"
          version = "1.1.0"
        }
      }
    }

    locals {
      personal_site_envs = {
        HUGO_VERSION = {
          value = "0.123.2"
          target = [
            "development",
            "preview",
            "production"
          ]
        }

        HUGO_ENV = {
          value = "production"
          target = [
            "development",
            "preview",
            "production"
          ]
        }
      }
    }

    resource "vercel_project" "personal_site" {
      name            = "personal-site"
      framework       = "hugo"
      install_command = "yum install -y golang"

      git_repository = {
        production_branch = "master"
        type              = "github"
        repo              = "<username>/<hugo_repo>"
      }

      vercel_authentication = {
        deployment_type = "none"
      }
    }

    resource "vercel_project_environment_variable" "personal_site" {
      for_each   = local.personal_site_envs
      project_id = vercel_project.personal_site.id
      key        = each.key
      value      = each.value.value
      target     = each.value.target
    }

    resource "vercel_project_domain" "personal_site" {
      for_each   = local.personal_site_domains
      project_id = vercel_project.personal_site.id
      domain     = each.key
    }
    ```
3. In the current directory, run the following:
    ```
    export VERCEL_API_TOKEN=<INSERT_YOUR_API_TOKEN>
    terraform init
    terraform plan
    ```
   Check the plan output
4. If the plan looks good, apply the changes with `terraform apply`

If everything works well, the project will be created and configured automatically by Terraform definition above. You might need to make dummy changes to the repo to trigger the build or trigger it manually from the UI.
1. Go to Vercel project
2. Click `Deployments` tab
3. Click the three dotted button on right side, select `Create Deployment`
4. In the modal page, write the branch that you want to deploy. i.e: master
5. Click `Create Deployment`

New deployment will be triggered. You may navigate to the Deployments page to see the deployment lists.
