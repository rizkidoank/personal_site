---
layout: post
title: Does Infra Testing Really Matters?  
date: '2019-02-23 01:05:00'
tags:
- day-to-day
- experience
---

## Story
In previous post, I already share my experience when tried to automate manual process by created script to automatically create configs based on the input in requests. We found that the script are useful enough at that time, and reduced number of incidents caused by misconfiguration (yay!). Unfortunately, we faced with issues when the provisioned infrastructure not work as expected which caused by several things, example: invalid port definition which (again) inputted by human.

Just as usual, I tried to look for the possibilities to solve the issues and found about 'Test Driven Development in Infrastructure'. If you read for the same thing, you'll find (at least per this article written), cloud infrastructure testing is quite different with general application testing. In general application you have unit test, but in infrastructure, even you're use Infrastructure as Code, unit test is still lacking.

## How Do We Test Our Infrastructure?
First thing first, before we test the infrastructure itself I updated the previous scripts in [previous post]({{ site.baseurl }}{% post_url 2019-02-23-how-scripting-make-my-life-easier %}) to have input verifier / checker. Its basically read the input files and check whether the input are valid or not, and for any invalid input should resubmitted with a proper one.

After that, before we create / generate the configs, you need to create the test specification first by define what is your expected infrastructure. I was researched several tools and the chosen tools are [inspec](inspec.io) and [awspec](https://github.com/k1LoW/awspec).

Test specification is ready, let's generate the configs and apply the changes. After the infra provisioned, run the test. Everything should looks good, if not then something wrong with either your configs or the test specification (create test spec sometimes harder than creating the configs itself :D ).

If everything looks good, you're good to go. Optional steps is to have a sanity check in reality, you might create scripts to test it automatically in your environment, or manually test it. After you confident enough, you might not need it anymore. Sanity check after running the test are good when you learn creating a proper test specification.

Done! I know that's not very straightforward, you might need to train yourself to build the habit. How about the results? Our incidents rate reduced but with overhead in implementation time.

## Lesson Learned
- Don't blindly process everything in front of you without properly check what is the requirement (especially for human submitted inputs), even you already have tools to process it automatically.
- Test Driven Development process will help you to build confidence for what you'll do.