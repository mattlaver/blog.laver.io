---
layout: post
title:  "Docker, Redis and .Net Core"
date:   2017-07-03 20:56:02 +0100
categories: Docker Redis dotnetcore 
---

Sometimes I just want to play with some technology but not spend time installing and configuring components on my system and this is why I love [Docker](https://www.docker.com).

# Use Docker to run Redis

Getting Docker is fairly trivial, simply go to the [Docker Site](https://www.docker.com), download and install the appropriate version for your operating system.

Docker Hub is the place to go for docker images and makes it super simple to download a container to play around with, example Redis:

```bash
    docker pull redis
```

Configuring and running the container is also relatively straightforward although exposing the port correctly so you can use it requires a small bit of config:

```bash
    docker run -d --name redisDev -p 6379:6379 redis
```

Check that the container is running correctly:

```bash
    docker ps
```

# .Net Core Application

Now for some quick application scaffolding to test our Redis docker container. This bit assumes you have [.Net Core](https://www.microsoft.com/net/core) running on your system.

Create a simple console application:

```bash
    dotnet new console 
```

Install a package to [Redis client](https://stackexchange.github.io/StackExchange.Redis/) kindly open sourced by the good folk at Stack Overflow.

```bash
    dotnet add package StackExchange.Redis
```

Connecting, writing and reading to the Redis container is a snip, edit the Program.cs generated above:

```c#
    using System;
    using StackExchange.Redis;
 
    namespace RedisTest
    {
        class Program
        {
            static void Main(string[] args)
            {
                ConnectionMultiplexer redis = ConnectionMultiplexer.Connect("localhost");

                IDatabase db = redis.GetDatabase();

                db.StringSet("thekey", "The Value");

                var returnValue = db.StringGet("thekey");

                Console.WriteLine(returnValue); 
            }
        }
    }
```

And from the commandline:

```bash
    dotnet run
```

Setting up a development environment with a database is so easy now Docker has matured, what's not to like?