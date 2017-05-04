---
layout: post
title:  "Jekyll - Part 1 - Create"
date:   2017-04-13 20:56:02 +0100
categories: jekyll ci azure
---

I've started this blog to begin recording my thoughts around my experience with delivering software.

I'm a big fan of automating software so it makes sense that I write up how I automated the blogging platform I'm using.

There is certainly no shortage of tools for blogging but before I start throwing code at the solution I had some requirements to think about:

- The blog posts should be in source control
- The posts to be in markdown so they are not coupled to one particular blogging platform
- The site should automatically update upon changes being checked into source control

With the above in mind I narrowed my selection to static site generators, of which there are plenty, for example Hugo, Jekyll, Ghost.

After spiking all three I liked them all but found Jekyll the easiest to get things cooking so decided to go with that. As the posts are in markdown it should be fairly simple to change this later but for now I wanted my blog up and running.

 # Jekyll

I installed Jekyll on both a Windows and my macOS. The Windows install and setup was very simple but I wanted to use my Macbook Air (MBA) as my main machine for blogging as it's so portable. Setting Jekyll up on a MBA is a little more involved and requires jumping through a few more hoops.

## Install Ruby (attempt 1)

macOS already has Ruby installed but the general wisdom is to not mess with this installation and use a Ruby environment manager when writing Ruby on OS X.

## Install rbenv

Right, [rbenv](https://github.com/rbenv/rbenv){:target"_blank" class="external"} it is then.

To install this I used [homebrew](https://brew.sh/){:target"_blank" class="external"} 

```bash
brew update
brew install rbenv
```

But it's not as simple as just that, once installed rbenv should be initialised:

```bash
rbenv init
```

And the instuctions from the above:

```bash
# Load rbenv automatically by appending
# the following to ~/.zshrc:

eval "$(rbenv init -)"
```

So the shell needed bootstrapping, in my case I use [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh){:target"_blank" class="external"} so I edited my .zshrc file with nano and added the above line.

```bash
nano .zshrc
```



## Install Ruby (attempt 2)

Alright! Now to install the latest stable ruby:

```bash
rbenv install 2.4.1
```

Verify the version:

```bash
ruby -v
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]
```


## Install Jekyll 

Finally! we can install Jekyll.

```bash
gem install jekyll bundler
```

Now create the site

```bash
jekyll new blog.laver.io
```

This creates a new folder with the site in, we can navigate to the root of the site:

```bash
cd blog.laver.io
```

## Build and Serve site

To generate the static site and serve it locally:

```bash
bundle exec jekyll serve
```

Browse to localhost:4000

Excellent - now time to write some posts, install a theme and tweak the settings.