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

The Azure credentials for the Web App are entered into Travis as the following environmental variables:

- AZURE_WA_USERNAME
- AZURE_WA_PASSWORD
- AZURE_WA_HOST

Add these in the settings of the travis build:

![image-title-here](/assets/travis_settings.png){:class="img-responsive"}

## Deploy step

Travis recognises azure with the azure_web_apps provider and can be configured easily in a deploy step like this:

```yml
deploy:
  skip_cleanup: true
  provider: azure_web_apps
```

The skip_cleanup line tells Travis not to clean up the statically generated site (Artifacts) as this is what we want to deploy to Azure. 
