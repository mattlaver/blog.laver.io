---
layout: post
title:  "Setting up Jekyll Continuous Integration with Travis"
date:   2017-04-15 20:56:02 +0100
categories: jekyll travis CI
---

Now we have our site that we've setup locally the next requirements are

- Minimal infrastructure dependencies and low cost
- Build the site on each code change pushed to the git repository
- Perform some sanity tests (check dead links)

# Travis

Here enters the CI server. There are plenty of decent CI tools to choose from, TeamCity, Jenkins, Visual Studio Team Services, GoCD, Codefresh, Travis CI.

If I was setting up a CI server for a team of developers I would consider Temcity, Jenkins, VSTS or GoCD but as this is a small personal project I've chosen Travis CI as I know it meets my requirements with minimal effort on my behalf.

# Setting up a Travis Build

Travis builds can be configured with a .travis.yml file that succintly describes the build:

```yml
language: ruby
rvm:
- 2.4.1

cache:
  bundler: true

install: 
  - bundle update
  - gem install jekyll html-proofer

script:   
  - jekyll build && htmlproofer ./_site

branches:
  only:
  - master
 
env:
  global:
  - NOKOGIRI_USE_SYSTEM_LIBRARIES=true # speeds up installation of html-proofer
```

The above travis file is fairly self explanitory, it defines the language we want to use, the bash commands required and the branch we wish to build from.

The only other noteworthy item in the file is html-proofer, which is used for testing the site post build. More can be read about html-proofer here.

The .travis.yml file should be checked into the root of the project.

# Create Build in Travis

Next we can set the build up in Travis which is simple enough:


We then point the travis build to the repository that we will be building from:


And bingo - Travis builds the site on code check ins and tests the links on the site.


