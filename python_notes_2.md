# Chapter 35: Functional Programming in Python
Functional programming decomposes a problem into a set of functions. Ideally,
functions only take inputs and produce outputs, and don't have any internal 
state that affects the output produced for a given input.


### 35.1 Lambda Function
An anonymous, inlined function defined with lambda. The parameters of the 
lambda are defined to the left of the colon. The function body is defined to
the right of the colon. The result of running the function body is(implicitly)
returned.
```python
s = lambda x: x*x
s(2) # 4
```


### 35.2 Map Function
Map takes a function and a collection of items. It makes a new, empty 
collection, runs the function on each item in the original collection and 
inserts each return value into the new collection. It returns the new 
collection.

This is a simple map that takes a list of names and returns a list of the
length of those names:
```python
name_lengths = map(len, ["Mary", "Isla", "Sam"])
print(name_lengths)  # [4, 4, 3]
```


### 35.3 Reduce Function
Reduce takes a function and a collection of items. It returns a value that is
created by combing the items.

This is a simple reduce. It returns the sum of all the items in the collection.
```python
total = reduce(lambda a, x: a + x, [0, 1, 2, 3, 4])
print(total)  # 10
```


### 35.4 Filter Function
Filter takes a function and a collection. It returns a collection of every item
for which the function returned True.
```python
arr = [1, 2, 3, 4, 5, 6]
[i for i in filter(lambda x: x > 4, arr)]
# [5, 6]
```



# Chapter 36: Partial functions
| Param | Details                        |
|-------|--------------------------------|
| x     | the number to be raised        |
| y     | the exponent                   |
| raise | the function to be specialized |

As you probably know if you came from OOP school, specializing an abstract 
class and use it is a practice you should keep in mind when writing your code.

What if you could define an abstract function and specialize it in order to
create different versions of it? Thinks it as a sort of _function inheritance_
where you bind specific params to make them reliable for a specific scenario.


### 36.1 Raise the power
Let's suppose we want ot raise x to a number y.

You'd write this as:
```python
def raise_power(x, y):
    return x**y
```

What if your y value can assume a finite set of values?

Let's suppose `y` can be one of `[3, 4, 5]` and let's say you don't want to 
offer end user the possibility to use such function since it is very 
computationally intensive. In fact you would check if provided `y` assumes a 
valid value and rewrite you function as:
```python
def raise(x, y):
    if y in (3, 4, 5):
        return x**y
    raise NumberNotInRangeException("You should provide a valid exponet")
```

Messy? Let's use the abstract form and specialize it to all there cases: Let's
implement them `partially`.
```python
from functors import partial
raise_to_three = partial(raise, y=3)
raise_to_four = partial(raise, y=4)
raise_to_five = partial(raise, y=5)
```

What happens here? We fixed the `y` params and we defined three different 
functions.

No need to use the abstract function defined above(you could make it private)
but you could use __partial applied__ functions to deal with raising a number
to a fixed value.



# Chapter 37: Decorators
| Parameters | Details                               |
|------------|---------------------------------------|
| f          | The function to be decorated(wrapped) |

Decorator functions are software design patterns. They dynamically alter the
functionality of a function, method, or class without having to directly use
subclasses or change the source code of the decorated function. When used 
correctly, decorators can become powerful tools in the development process.
This topic covers implementation and applications of decorator functions in
Python.


### 37.1 Decorator function
Decorators augment the behavior of other functions or methods. Any function 
that takes a function as a parameter and returns an augmented function can be
used as a decorator.
```python
# This simplest decorator does nothing to the function being decorated. Such
# minimal decorators can occassionally be used as a kind of code markers.
def super_secret_function(f):
    return f

@super_secret_function
def my_function():
    print("This is  my secret function.")
```

The `@-notation` is syntactic sugar that is equivalent to the following:
```python
my_function = super_secret_function(my_function)
```

It is important to bear this in mind in order to understand how the decorators
works. This "unsugared" syntax makes it clear why the decorator function takes
a function as an argument, and why it should return another function. It also
demonstrates what would happen if you don't return a function:
```python
def disable(f):
    """
    This function returns nothing, and hence removes the decorated function
    from the local scope.
    """
    pass

@disable
def my_function():
    print("This function can no longer be called...")


my_function()
# TypeError: 'NoneType' object is not callable
```

Thus, we usually define a _new function_ inside the decorator and return it.
This new function would first do something that it needs to do, then call the
original function, and finally process the return value. Consider this simple
decorator function that prints the arguments that the original function 
receives, then calls it.
```python
# This is the decorator
def print_args(func):
    def inner_func(*args, **kwargs):
        print(args)
        print(kwargs)
        return func(*args, **kwargs) # Call the original function with its args
    return inner_func

@print_args
def multiply(num_a, num_b):
    return num_a * num_b


print(multiply(3, 5))
# Out:
# (3, 5)
# {}
# 15
```


### 37.2 Decorator class
As mentioned in the introduction, a decorator is a function that can be applied
to another function to augment its behavior. The syntactic sugar is equivalent
to the following: `my_func = decorator(my_func)`. But what if the decorator was
instead a class. If this class implements the `__call__()` magic method, then 
it would still be possible to use my_func as if was a function:
```python
class Decorator(object):
    """Simple decorator class."""

    def __init__(self, func):
        self.func = func

    def __call__(self, *args, **kwargs):
        print('Before the function call.')
        res = self.func(*args, **kwargs)
        print('After the function call.')
        return res


@Decorator
def testFunc():
    print('Inside the function.')

testFunc()
# Before the function call.
# Inside the function.
# After the function call.
```

Note that a function decorated with a class decorator will no longer be 
consider a 'function' from type-checking perspective:
```python
import types
isinstance(testFunc, types.FunctionType)
# False
type(testFunc)
# <class '__main__.Decorator'>
```

__Decorating Methods__

For decorating methods you need to define an additional `__get__`-method:
```python
from types import MethodType

class Decorator(object):
    def __init__(self, func):
        self.func = func

    def __call__(self, *args, **kwargs):
        print('Inside the decorator.')
        return self.func(*args, **kwargs)

    def __get__(self, instance, cls):
        # Return a Method if it is called on instance
        return self if instance is None else MethodType(self, instance)


class Test(object):
    @Decorator
    def __init__(self):
        pass


a = Test()
# Inside the decorator.
```

__Warning__
Class Decorators only produce one instance for a specific function so 
decorating a method with a class decorator will share the same decorator
between all instances of that class:
```python
from types import MethodType

class CountCallsDecorator(object):
    def __init__(self, func):
        self.func = func
        self.ncalls = 0  # Number of calls of this method

    def __call__(self, *args, *kwargs):
        self.ncalls += 1  # Increment the calls counter

    def __get__(self, instance, cls):
        return self if instance is None else MethodType(self, instance)


class Test(object):
    def __init__(self):
        pass

    @CountCallsDecorator
    def do_something(self):
        return 'something was done'


a = Test()
a.do_something()
a.do_something.ncalls  # 1
b = Test()
b.do_something()
b.do_something.ncalls  # 2
```


### 37.3 Decorator with arguments(decorator factory)
A decorator takes only one argument: the function to be decorated. There is no
way to pass other arguments. But additional arguments are often desired. The 
trick is then to make a function which takes arbitrary arguments and returns a
decorator.

__Decorator functions__
```python
def decorator_factory(message):
    def decorator(func):
        def wrapped_func(*args, **kwargs):
            print('The decorator wants to tell you: {}'.format(message))
            return func(*args, **kwargs)
        return wrapped_func
    return decorator


@decorator_factory('Hello, World')
def test():
    pass

test()
# The decorator wants to tell you: Hellow World
```

__Important Note__
With such decorator factories you must call the decorator with a pair of 
parentheses:
```python
@decorator_factory # Without paretheses
def test():
    pass

test()
# TypeError: decorator() missing 1 required positional argument: 'func'
```

__Decorator classes__
```python
def decorator_factory(*decorator_args, **decorator_kwargs):
    
    class Decorator(object):
        def __init__(self, func):
            self.func = func

        def __call__(self, *args, **kwargs):
            """The *args and **kwargs are arguments for func"""
            print('Inside the decorator with arguments {}'.format(decorator_args))
            return self.func(*args, **kwargs)

    return Decorator


@decorator_factory(10)
def test():
    pass

test()
# Inside the decorator with arguments(10, )
```


### 37.4 Making a decorator look like the decorated function
Decorators normally strip function metadata as they aren't the same. This can
cause problems when using meta-programming to dynamically access function
metadata. Metadata also includes function's docstrings and its name. 
`functools.wraps` makes the decorated function look like the original function
by copying several attributes to the wrapper function.
```python
from functools import wraps
```

The two methods of wrapping a decorator are achieving th same thing in hiding
that the original funciton has been decorated. There is no reason to perfer the
function version to the class version unless you're already using one over the 
other.

__As a function__
```python
def decorator(func):
    # Copies the docstring, name, annotations and module to the decorator
    @wraps(func)
    def wrapped_func(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapped_func


@decorator
def test():
    pass

test.__name__
# 'test'
```

__As a class__
```python
class Decorator(object):
    def __init__(self, func):
        # Copies name, module, annotations and docstring to the instance
        self._wrapped = wraps(func)(self)

    def __call__(self, *args, **kwargs):
        return self._wrapped(*args, **kwargs)


@Decorator
def test():
    """Docstring of test."""
    pass

test.__doc__
# 'Docstring of test'
```


### 37.5 Using a decoratorto time a function
```python
import time


def timer(func):
    def inner(*args, *kwargs):
        t1 = time.time()
        f = func(*args, *kwargs)
        t2 = time.time()
        print('Runtime took {0} seconds'.format(t2-t1))
        return f
    return inner

@timer
def example_function():
    # do stuff

example_function()
```


### 37.6 Create singleton class with a decorator
A singleton is a pattern that restricts the instantiation of a class to one
instance/object. Using a decorator, we can define a class as a singleton by
forcing the class to either return an existing instane of the class or create a
new instance(if it doesn't exist).
```python
def singleton(cls):
    instance = [None]
    def wrapper(*args, **kwargs):
        if instance[0] is None:
            instance[0] = cls(*args, **kwargs)
        return instance[0]
    return wrapper
```

This  decorator can be added to any class declaration and will make sure that
at most one instance of the class is created. Any subsequent calls will return
the already existing class instance.
```python
@singleton
class SomeSingletonClass(object):
    x = 2
    def __init__(self):
        print("Created")


instance = SomeSingletonClass()  # prints: Created
instance = SomeSingletonClass()  # doesn't print anything
print(instance.x)                # 2

instance.x = 3
print(SomeSingletonClass().x)    # 3
```

So it doesn't matter whether you refer to the class instance via your local
variable or whether you create another "instance", you always get the same
object.



# Chapter 38: Classes

### 38.1 Introduction to classes
