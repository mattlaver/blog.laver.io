---
layout: post
title:  "Setting up Jekyll Continuous Delivery with Azure"
date:   2017-04-16 20:56:02 +0100
categories: jekyll azure travis cd
---

The last part of the jigsaw is nearly in place and from experience, deploying and delivering software to production can often be fraught with issues. Thankfully Travis and Azure integration is beautifully simple and easy to use.

# Setup Azure Web App

# Configure local git deploy


# Configure Travis for Azure Deploy

Two things are required for deploying from Travis:

## Azure Credentials

Add the following Azure credentials in the build settings:


## Deploy step

Now Azure is setup and the  add this deploy step to the .travis.yml file:

```yml
deploy:
  skip_cleanup: true
  provider: azure_web_apps
```
