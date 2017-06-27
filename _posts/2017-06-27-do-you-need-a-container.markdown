---
layout: post
title:  "Do you need an Inversion of Control Container?"
date:   2017-06-27 20:56:02 +0100
categories: DesignPatterns Architecture IoC
---

The benefits of architecting software with Dependency Injection in mind are widely aknowledged to be a good thing, it's so widespread now that it's unusual to see new code that isn't loosely coupled with dependencies injected. And this is a good thing.

However this does not mean that software is all now beautifully architected - with the [SOLID](https://scotch.io/bar-talk/s-o-l-i-d-the-first-five-principles-of-object-oriented-design){:target"_blank" class="external"}  principles engraved in our brains we sometimes forget about one of the older principles of software development - [KISS](https://people.apache.org/~fhanik/kiss.html){:target"_blank" class="external"}.

Dependencies in modern enterprise software are almost always managed with an [Inversion of Control (IoC)](https://martinfowler.com/articles/injection.html){:target"_blank" class="external"} container - and the debates about the use of IoC containers go back a [long time](http://stackoverflow.com/questions/871405/why-do-i-need-an-ioc-container-as-opposed-to-straightforward-di-code){:target"_blank" class="external"}.

In the places I've worked at in the last five years I've seen very few applications that do not have an IoC container at their heart and the use of IoC containers encourages code to be programmed to an interface and injections managed by a bootstrapper for the IoC container. 

Greg Young in his talk on [8 lines of code](https://www.infoq.com/presentations/8-lines-code-refactoring){:target"_blank" class="external"} argues that defaulting to an IoC container when architecting software can often lead to more complex code, steeper learning curve for new developers and more lines of code to maintain and manage.

So how does this make things more complicated? Lets look at a common programming task - the command handler.

# Command Handler Using IoC container

Let's take a look at a typical application with a command handler where we create a command and pass it into a handler to be handled:

```c#
    class Program
    {
        static void Main(string[] args)
        {
            var container = Container.For<Bootstrapper>();

            var handler = container.GetInstance<IItemHandler<InsertItemCommand>>();

            handler.Handle(new InsertItemCommand());
        }
    }
```

So the container is initialised and then an appropriate handler is sought and finally called with the command we wish to execute.

This example uses StructureMap and a typical Bootstrapper looks like this:

```c#
    public class Bootstrapper : Registry
    {
        public Bootstrapper()
        {
            For<IItemRepository<InsertItemCommand>>().Use<ItemRepository>();
            For<IItemHandler<InsertItemCommand>>().Use<InsertItemHandler>();
        }
    }
```

A typical pattern for a handler might look like this with any dependencies passed via the constructor:

```c#
    public class InsertItemHandler : IHandles<InsertItemCommand>
    {
        private readonly ItemRepository _repository;

        public InsertItemHandler(IItemRepository repository)
        {
            _repository = repository;
        }

        public void Handle(InsertItemCommand command)
        {
            this._repository.Insert(command);
        }
    }
```

One of the issues taken with this pattern in the 8 lines of code talk are these parts:

```c#
    private readonly ItemRepository _repository;

    public InsertItemHandler(ItemRepository repository)
    {
        _repository = repository;
    }
```

The ItemRepository is only used in the Handle method so it seems like a lot of excess code to constructor inject and store as a private class variable.

But that's not all, there is also the obligatory interface we've programmed against:

```c#
    public interface IHandles<T> where T:ItemCommand
    {
        void Handle(T command);
    }
```



# Command Handler Simpler alternative

An alternative approach is simply to have a static handler:


```c#
    public static class Handlers
    {
        public static void InsertItem(ItemRepository repository, InsertItemCommand command)
        {
            repository.Insert(command);
        }
    }
```

So how is the ItemRepository passed in? Let's start at the Main entry point where a Dictionary of command handlers is maintained:


```c#
    class Program
    {
        private static readonly Dictionary<Type, Action<ItemCommand>> HandlersRegistry = new Dictionary<Type, Action<ItemCommand>>();

        static void Main(string[] args)
        {
            Bootstrapper.RegisterHandlers(HandlersRegistry);

            ItemHandlers.ExecuteHandler(HandlersRegistry, new InsertItemCommand());
        }      
    }

```

The handlers are simply registered like:

```c#    
    public static void RegisterHandlers()
    {
        _handlersRegistry.Add(typeof(InsertItemCommand), x => Handlers.InsertItem(new ItemRepository(), (InsertItemCommand)x));
    }
```

And we execute the Handler with another static method:

```c#    
    public static void ExecuteHandler(ItemCommand command)
    {
        Action<ItemCommand> handler;
        if (_handlersRegistry.TryGetValue(command.GetType(), out handler))
        {
            handler(command);
        }
    }
```

Obviously this is quite a simple example and with more complex applications IoC can offer a number of advantages but like all things, I think it's worth considering if you really need that IoC container.

