---
title: "Cache Terraform Provider Plugins"
date: 2024-02-27T13:58:40+08:00
---

## Overview
Terraform required provider plugin to be able to work and communicate with the cloud providers. But, do you know that by default it will download and cache it in the current directory of the Terraform configs? This behaviour will be painful to your Internet quota since it will download same binary in every Terraform config directories. This post will give you information on how to set the plugin cache directory. So, if the provider version already downloaded, we can just pick it from the cache directory instead of redownload everytime.

## How to Set Terraform Plugin Cache Directory
This is the summary of what we'll doing in this post:
- Terraform has some configurable settings through `~/.terraformrc` or environment variables.
- We can set plugin cache directory with `plugin_cache_dir` properties in `~/.terraformrc`

To use the feature, follow below instructions:
1. Create / edit `~/.teraformrc` and set the `plugin_cache_dir`
    ```
    echo plugin_cache_dir=\"$HOME/.terraform.d/plugin-cache\" >> ~/.terraformrc
    ```
2. Go to your Terraform config directory and do the `init`
    ```
    terraform init
    ```
3. Providers will be downloaded and cached in `$HOME/.terraform.d/plugin-cache`

When you move the another directory and given the other Terraform configs using the same version of provider, it will not redownload from the Internet. Instead, it will fetch from the cache directory.

## Conclusions
With the growth of cloud computing related tools, and most of the tools are connected to Internet and we might not even notice that the behaviour might be killing our Internet quotas. This is the good thing on reading documentations and also understanding the internal of the tools. So, we might able to make the tools more relevant to our needs (if they have features for it of course)
