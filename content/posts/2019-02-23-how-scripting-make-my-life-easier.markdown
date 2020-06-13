---

title: How Scripting Make My Life Easier  
date: '2019-02-23 00:12:00'
tags:
- day-to-day
- experience
---

## Story
Did you ever worked in repetitive tasks? I was worked as an operational cloud infrastructure engineer. Starting from received several ticket from developers who needs infrastructure, gathering informations for their needs, double check the requests, and everything done manually by myself.. Ouch! Even worse if we missed something from the request, ta-daaa! Incident happened and another requests got delayed.

It does happened to me (and my team) about past one-half years ago. We already tried to be more details, carefully read the requests, but it doesn't work. The problem itself come from the very basic actor, human. Luckily, the ticket format and the process itself already standardized. Hmm.. Looked back and compared with current requests and I was thinking and tried to remove manual verification process by human. Why don't we automate the process?

First, previously the required resources definition are written together with the ticket itself. To make the processing easier, we changed the format to machine-friendly format, like CSV, JSON, etc and attach it together with the ticket.

Second, I created script to grab the 'request file' and then create configs based on the input (by the way, we used Terraform). Voila! No need to manually create the configs anymore! Just applied, and merged. Done!

## Lesson Learned
- Don't stop improving the workflow, there is no perfect process / workflow, there is always space to do improvement. In fact, the requirement might changes day-by-day. You wouldn't catch up if you still doing the same way everytime.
- Review what you've done, track anything that might help you to improve the process, example: number of similiar incidents
- Automate if you can automate it, even you're very good in details, there is always a chances you might missed something.
- Be creative, you have something to get fix, how do you fix the issue? You have many ways to do it.