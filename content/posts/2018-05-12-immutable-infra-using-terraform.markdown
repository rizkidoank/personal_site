---

title: Immutable Infrastructure using Terraform 
date: '2018-05-12 07:22:00'
tags:
- cloud
- site-reliability-engineer
- orchestration
---

# What is Terraform?
> Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. 

OK, that's the first answer when you questioning about "what is Terraform".
[Terraform](https://terraform.io) is a tool built by [Hashicorp](https://www.hashicorp.com/) for 
infrastructure management. It's based on Go, so you can easily install it by downloading
the binary into your machine.

# Why Using Terraform?
This is a good question, we know that there are some tools besides Terraform
for infrastructure management that commonly used out there like Ansible, Chef, or CloudFormation (if you use AWS).

First, Ansible and Chef is mainly designed as Configuration Management tools.
It's able to provision server using module, yes it is. But, the problem is that both of them are
mutable, it means that we need to write it idempotent. Those tools are procedural, so you need to clearly
define the steps and the state, which is not easy, fragile, and likely leads to configuration drift on your environment.
So, I rather choose them for configuration management only.

Second, what about CloudFormation then? It's declarative just like Terraform. Simply because (1) it's
only work for AWS (2) its support JSON and YAML, but I personally did not like the code style, sometimes it's painful
to read when the stack is bit large. (3) its immutable by design, defined by state. So if there is a change, it will
tell you which resources are changed. But, personally the change review is not very details, sometimes I have to double
check the code together with the change review.

Terraform configuration written in declarative style using HCL syntax, its support `plan` action to summarize what
resources will be created if I apply it to real environment. When I applied it, it will create state which stored in
local, or even in remote backend such as S3. It will check the changes in configuration using this state and check for
the reality. And another good things, its quite smart, Terraform able to resolve the dependency between resources by
itself for most conditions.

# Not Really Good About Terraform
Everything has pros and cons, and Terraform does. There are couple of things that quite annoying in Terraform.

- It's still not that mature. So if you working on production environment, ensure you lock down the version and don't
update frequently. Because, I often found that my configuration is not compatible with newer of core, or provider 
version. There are still many update, mostly in provider like AWS.
- Lack of error handling, mostly its simply get the error from API response. Not a big deal if don't need custom error
handling.
- Adds learning curve to learn loop, conditionals, and complex interpolation. Personally, the syntax is very minimal.
If only you not doing complex operations, its very straightforward. Unless you doing complex configuration.
- Lack of testing. If you use TDD, its quite challenging in Terraform. I recommend to have a separate environment
specific for testing purpose. Because currently I have to provision real resources to test the configurations. Except 
the linting (tflint) and `plan`, which sometimes your `plan` is good, but `apply` failed (mostly issue in provider, aws
in this case)

# How to Install Terraform
Terraform based on Go, so the only thing you need is download binary for your OS, and put it into your path. This is
the example to install Terraform in Mac

```bash
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_darwin_amd64.zip
unzip terraform_0.11.7_darwin_amd64.zip
mv terraform /usr/local/bin
```

That's it, simple. I also found there is interesting tools to manage your terraform version.
[tfenv](https://github.com/kamatama41/tfenv), version manager for Terraform. You may take a look to the repo.
For Mac user, you can simply install it from `brew`
```bash
brew install tfenv
```

Yup, that's all about introducing Terraform as a tools for infrastructure management. Hope this article useful, thanks!