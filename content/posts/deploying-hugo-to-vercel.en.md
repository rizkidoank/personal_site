---
title: "Deploy Hugo to Vercel"
date: 2024-02-26T14:19:29+08:00
---

## Overview
Hugo is one of popular static site generator out there. There are some options to deploy Hugo such as manually using VM, netlify, or using Vercel. This post will give you information on how to deploy Hugo to Vercel. Hugo requires theme and layouts to be able to work. There are some ways to use install a theme and most of the common way are using git submodule.

## Why Vercel?
My Hugo site was deployed using Netlify and everything is running well. But, I have some other projects that needs to be managed. While Netlify is good, we don't have IaC provider for it. I checked for other options and found out Vercel has Terraform provider support! Just like Netlify, we also has Free options in Vercel, so thats another good thing to have!

## Issues with Hugo in Vercel
- Vercel has Hugo template already
- Install theme using submodule might not work (the theme not fetched)
- Hugo has options to install using Hugo module (like go mod)
  - In my case, using the hugo module throw an error due to missing `go`
  - Another issue, Hugo cannot found the `hugo` command

## How to Deploy Hugo in Vercel
1. Example, we configure the Hugo module for PaperMod theme in `config.yaml` like below:
   ```
   module:
     imports:
       - path: github.com/adityatelange/hugo-PaperMod
   ```
2. Initialize the Hugo modules and sync the modules
   ```
   hugo mod init github.com/<username>/<hugo_blog_repo>
   hugo mod get -u
   ```
3. You might want to test it before deploy
   ```
   hugo serve
   # open localhost:1313 locally and check if everything looks good
   ```
4. Open Vercel -> Add New -> Project. Import your project from desired repo location (i.e: GitHub)
5. In project configuration, use the followings:
   - In `Environment Variables`, add `HUGO_VERSION` fill it with your targeted Hugo version, i.e: `0.123.2`
   - In `Environment Variables`, add `HUGO_ENV` fill it with `production`
   - In `Build and Output`, insert the following in `Install Command`
     ```
     yum install -y golang
     ```
6. Fill the remaining as you want and click `Deploy`

Your Hugo will be deployed to Vercel. Optionally, you might want to add domains so you can attach it to your own domain.
1. Go to your Vercel project
2. Go to Settings -> Domains
3. Key in your domain, click Add
4. Add the DNS records by adding the required records mentioned in domains page
5. After the records created and validated, it will create SSL certificate automatically
6. Your Hugo site is now accessible from your own domain!

## What are the Fixes?
In general we fixed two places here:
- `hugo` not found, fixed by providing the `HUGO_VERSION`
- missing `go` command when running the `hugo --gc`, fixed by providing the `yum install -y golang` to ensure golang installed before running the `hugo` deploy command.

## What's Next?
Configuring everything through UI is very nice and easy to understand. But, some people might not interested to click here and there for this. Good thing is that Vercel has registered Terraform provider, so we can configure all of this easily using Terraform. I'll make an article about this in next post. Stay tune!
