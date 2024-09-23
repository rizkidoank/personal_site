---
title: "Bulding Docker Image with Cloud Builder"
date: 2024-09-23T00:00:00+07:00
tags:
- english
- docker
---

Docker BuildKit has been there since couple years back and its become default builder to replace the legacy builder since Docker Desktop 23.0. I really like this BuildKit since its offers some helpful features. The one that I mostly feel help was the build cache which can possibly save some build time and also the data used to download the dependencies of your image.

Recently, I just got to know about Docker Build Cloud which allows us to build our image with cloud builder. I got to know when I try to built some images and it takes long time to complete and decided to read the docs and found out there is [Docker Build Cloud](https://docs.docker.com/build-cloud/) section. Docker Build Cloud is part of the `buildx` and available for personal use with usage up to 50 build minutes every month. With this, your build will be offloaded to the cloud instance as well as the cache, so no need to worry when your Internet is problematic or your machine is not strong enough to build the image.

## How-to Use Docker Build Cloud
Enough talking, lets move on to the short guide how to use this feature. The must have tools / item for this: Docker Desktop (or docker with recent buildx supports), and Docker Build Cloud Subscription (use the personal one is enough for me). After that, I use the following commands:

1. Since we use subscription for this. Use `docker login` to start. You might need to provide your PAT to login. Create it [here](https://app.docker.com/settings/personal-access-tokens)
2. After that, you can check your current builder with `docker buildx ls`. In my case I only have the default, which is my local machine.
  ```
  NAME/NODE       DRIVER/ENDPOINT   STATUS    BUILDKIT   PLATFORMS
default*        docker                                 
 \_ default      \_ default       running   v0.15.2    linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6
  ```
3. Let's create new builder. You may do this from Docker Desktop and web dashboard. I use the later. Go to https://app.docker.com/build/accounts/USERNAME/builders

  > the guide written to create builder with `docker buildx create --driver cloud ORG/BUILDER_NAME` but apparently you have to create the builder first. This command is to connect to the builder.

4. Find the "Create a cloud builder" button. Give it a name, in this case I use `develop`. The instruction will be shown, you may follow it, my guide also do similar commands.

5. Run `docker buildx create --driver cloud ORG/BUILDER_NAME`
  ```
  docker buildx create --driver cloud rizkidoank/develop
  cloud-rizkidoank-develop
  ```

6. The builder is now registered in your machine, try again with `docker buildx ls` you'll find the cloud builder there.
  ```
  docker buildx ls
  NAME/NODE                   DRIVER/ENDPOINT                              STATUS    BUILDKIT   PLATFORMS
cloud-rizkidoank-develop*   cloud                                                             
 \_ linux-amd64              \_ cloud://rizkidoank/develop_linux-amd64   running   v0.14.0    linux/amd64*, linux/amd64/v2, linux/amd64/v3, linux/amd64/v4, linux/386
 \_ linux-arm64              \_ cloud://rizkidoank/develop_linux-arm64   running   v0.14.0    linux/arm64*, linux/arm/v6, linux/arm/v7
default                     docker                                                            
 \_ default                  \_ default                                  running   v0.15.2    linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6
  ```

7. You may set it as default builder like so:
    ```
    docker buildx use cloud-rizkidoank-develop --global
    ```
    or you can also use `--builder` argument when building the image:
    ```
   docker buildx build -t rizkidoank/sample . --builder cloud-rizkidoank-develop
    ```

8. The build will now done in cloud builder:
 
    ```
    [+] Building 14.3s (9/17)     cloud:cloud-rizkidoank-develop
    => [internal] connected to docker build cloud service
    => [internal] load build definition from Dockerfile
    => => transferring dockerfile: 659B
    ...
    ```

Thats it! My build is now faster since I don't need to download all the dependencies locally and the build itself also done in cloud instance. Hope this helps!
