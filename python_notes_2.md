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
A class, functions as a template that defines the basic characteristics of a
particular object. Here's an example:
```python
class Person(object):
    """A simple class."""           # docstring
    species = "Homo Sapiens"        # class attribute

    def __init__(self, name):
        """This is the initializer. 
        It's a special method.
        """
        self.name = name            # instance method


    def __str__(self):
        """This method is run when Python tries
        to cast the object to a string. Return
        this string when using print(), etc.
        """
        return self.name


    def rename(self, renamed):      # regular method
        """Reassign and print the name attribute."""
        self.name = renamed
        print("Now my name is {}".format(self.name))
```

There are a few things to note when looking at the above example.
1. The class is made up of _attributes(data)_ and _methods(functions)_.
2. Attributes and methods are simply defined as normal variables and functions.
3. As noted in the corresponding docstring, the `__init()__` method is called
    the _initializer_. It's equivalent to the constructor in other object 
    oriented languages, and is the method that is first run when you create a
    new object, or new instance of the class.
4. Attributes that apply to thye whole class are defined first, and are called
    _class attributes_.
5. Attributes that apply tp a specific instance of a class(an object) are 
    called _class attributes_. They are generally defined inside `__init__()`;
    this is not necessray, but it is recommended(since attributes defined 
    outside of `__init__()` run the risk of being accessed before they are 
    defined.)
6. Every method, included in the class definition passes the object in question
    as its first parameter. The word `self` is used for this parameter(usage of
    `self` is actually by convention, as the word `self` has no inherent 
    meaning in Python, but this is one of Python's most respected conventions,
    and you should always follow it).
7. Those used to object-oriented progamming in other languages may be surprised
    by a few things. One is that Python has no real concept of `private` 
    elements, so everything, by default, imitates the behavior of the C++/Java
    public keyword. For more information, see the "Private Class Members" 
    example on this page.
8. Some of the class's methods have the following form: `__functionname__(self
    , other_stuff).` All such methods are called "magic methods" and are an 
    important part of classes in Python. For instance, operator overloading in
    Python is implemented with magic methods. For more information, see the
    relevant documentation.

Now let's make a few instances of our Person class!
```python
# Instances
kelly = Person("Kelly")
joseph = Person("Joseph")
john_doe = Person("John Doe")


# Note again the difference between class and instance attributes:
>>>kelly.species
'Homo Sapiens'
>>>john_doe.species
'Homo Sapiens'
>>>joseph.species
'Homo Sapiens'

>>> kelly.name
'Kelly'
>>> joseph.name
'Joseph'


>>> # Methods
>>> john_doe.__str__()
'John Doe'
>>> print(john_doe)
'John Doe'
>>> john_doe.rename("John")
'Now my name is John'
```


### 38.2 Bound, unbound, and static methods
The idea of bound and unbound methods was `removed in Python3`. In Python3 when
you declare a method within a class, you are using a `def` keyword, thus 
creating a function object. THis is a regular function, and the surrounding 
class works as its namespace. In the following example we declare method f 
within class A, and it becomes a function A.f:

```python
# Python 3.x
class A(object):
    def f(self, x)
        return 2 * x

A.f
# <function A.f at ...>
```

In Python2 the behavior was different: function objects within the class were 
implicitly replaced with objects of type `instancemethod`, which were called
_unbound methods_ because they were not bound to any particular class instance.
It was possible to access the underlying function using `.__func__` property.

```python
# Python2.x
A.f
# <unbound method A.f>
A.f.__class__
# <type 'instancemethod'>
A.f.__func__
# < function f at ...>
```

The latter behaviors are confirmed by inspection - methods are recognized as
functions in Python3, while the distinction is upheld in Python 2.

```python
# Python3.x
import inspect

inspect.isfunction(A.f)
# True
inspect.ismethod(A.f)
# False
```

```python
# Python 2.x
import inspect

inspect.isfunction(A.f)
# False
inspect.ismethod(A.f)
# True
```

In both versions of Python function/method A.f can be called directly, provided
that you pass an instance of class A as the first argument.

```python
A.f(1, 7)
# Python 2: TypeError: unbound method f() must be called with
#                      A instance as first argument(got int instance instead)
# Python 3: 14
a = A()
A.f(a, 20)
# Python 2 & 3: 40
```
Now suppose `a` is an instance of class A, what is `a.f` then? Well, 
intuitively this should be the same method f of class A, only it should somehow
"know" that it was applied to the object `a` - in python this is callde method
bound to `a`.

The nitty-gritty details are as follows: writing a.f invokes the magic 
`__getattribute__` method of a , which ﬁrst checks whether a has an attribute 
named f (it doesn't), then checks the class A whether it contains a method 
with such a name (it does), and creates a new object m of type method which 
has the reference to the original A.f in `m.__func__` , and a reference to the 
object a in `m.__self__` . When this object is called as a function, it simply 
does the following: `m(...) => m.__func__(m.__self__, ...)` . Thus this object 
is called a bound method because when invoked it knows to supply the object it 
was bound to as the ﬁrst argument. (These things work same way in Python 2 and 
3)

```python
a = A()
a.f
# < bound method A.f of <__main__.A object at ...>>
a.f(2)
# 4

# Note: the bound method object a.f is recreated *every time* you call it:
a.f is a.f  # False
# As a performance optimization you can store the bound method in the object's
# __dict__, in which case the method object will remain fixed:
a.f = a.f
a.f is a.f  # True
```

Finally, Python has __class methods__ and __static methods__ -- special kinds
of methods. Class methods work the same way as regular methods, except that 
when invoked on an object they bind to the class of the object instead of to 
the object. Thus `m.__self__ = type(a)`. When you call such bound method, it
passes the class of a as the first argument. Static methods are even simpler:
they don't bind anything at all, amd simply return the underlying function 
without any transformations.

```python
class D(object):
    multiplier = 2

    @classmethod
    def f(cls, x):
        return cls.multiplier * x

    @staticmethod
    def g(name):
        print("Hello, %s" % name)


D.f
# <bound method type.f of <class '__main__.D'>>
D.f(12)
# 24
D.g
# <function D.g at ...>
D.g("world")
# Hello, world
```

Note that class methods are bound to class even when accessed on the instance:
```python
d = D()
d.multiplier = 1337
(D.multiplier, d.multiplier)
(2, 1337)
d.f
# <bound method D.f of <class '__main__.D'>>
d.f(10)
# 20
```

It is worth noting that at the lowest level, functions, methods, staticmethods,
etc. are actually descriptors that invoke `__get__, __set__` and optionally 
`__del__` special methods.


### 38.3 Basic inheritance
A new class can be derived from an existing class as follows:
```python
class BaseClass(object):
    pass


class DerivedClass(BaseClass):
    pass
```

The `BaseClass` is the already existing(parent) class, and the `DerivedClass` 
is the new(child) class that inherits(or sunclasses) attributes from `BaseClass`
__Note__: all classes implicitly inherit from the object class, which is the 
base class for all built-in types.

```python
class Rectangle():
    def __init__(self, w, h):
        self.w = w
        self.h = h

    def area(self):
        return self.w * self.h

    def perimeter(self):
        return 2 * (self.w + self.h)
```

The Rectangel class can be used as a base class for defining a Square class, as
a square is a special case of rectangle.

```python
class Square(Rectangel):
    def __init__(self, s):
        # call parent constructor, w and h are both s
        super(Square, self).__init__(s, s)
        self.s = s
```

The Square class will automatically inherit all attributes of the Rectangle 
class as well as the object class. `super()` is used to call the `__init__()`
method of a Rectangle class, essentially calling any overridden method of the
base class.

__Note__: in Python3, `super()` does not require arguments.

Derived class objects can access and modify the attributes of its base classes:
```python
r.area()
# Output: 12
r.perimeter()
# Output: 14

s.area()
# Output: 4
s.perimeter()
# Output: 8
```

__Built-in functions that work with inheritance__
```
issubclass(DerivedClass, BaseClass): return True if DerivedClass is subclass of
the BaseClass

isinstance(s, Class): return True if s is an instance of Class or any of the 
derived  classes of Class
```

```python
issubclass(Square, Rectangle)
# True

r = Rectangle(3, 4)
s = Square(2)

isinstance(r, Rectangle)
# True

isinstance(r, Square)
# False
# a rectangle is not a square

isinstance(s, Rectangle)
# True
# A square is a rectangle
isinstance(s, Square)
# True
```


### 38.4 Monkey Patching
In this case, "monkey patching" means adding a new variable or method to a 
class after it's been defined. For instance, say we defined class A as
```python
class A(object):
    def __init__(self, num):
        self.num = num

    def __add__(self, other):
        return A(self.num + other.num)
```

But now we want to add another function later in the code. Suppose this 
function is as folows.
```python
def get_num(self):
    return self.num
```

But how do we add this as a method in A? That's simple we just essentially
place that function into A with an assignment statement.
```python
A.get_num = get_num
```

Why does this work? Because functions are objects just like any other object,
and methods are functions that belong to the class.

The function `get_num` shall be available to all existing(already created) as
well to the new instances of A. These additions are available on all instances
of that class(or its subclasses) automatically. For example:
```python
foo = A(42)

A.get_num = get_num

bar = A(5)

foo.get_num()  # 42
bar.get_num()  # 6
```

Note that, unlike some other languages, this technique does not work for 
certain built-in types, and it is not considered good style.


### 38.5 New-style vs. old-style classes
New-style class were introduced in Python 2.2 to unify classes and types. They
inherit from the top-level `object` type.

Old-style classes do not inherit from `object`. Old-style instances are always
implemented with a built-in instance type.

In Python 3, old-style classes were removed.

New-style classes in Python3 implicitly inherit from `object`, so there is no
need to specify `MyClass(object)` anymore.


### 38.6 Class methods: alternate initializers
Class methods present alternate ways to build instances of classes. To 
illustrate, let's look at an example. Let's suppose we have a relatively simple
`Person` class:

```python
class Person(object):
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
        self.full_name = first_name + " " + last_name

    def greet(self):
        print('Hello, my name is ' + self.full_name + '.')
```

It might be handy to have a way to build instances of this class specifying a
full name instead of first and last name separately. One way to do this would
be to have `last_name` be an optional parameter, and assuming that if it isn't
given, we passed the full name in:
```python
class Person(object):
    def __init__(self, first_name, age, last_name=None):
        if last_name == None:
            self.first_name, self.last_name = first_name.split(' ', 2)
        else:
            self.first_name = first_name
            self.last_name = last_name
        self.age = age
        self.full_name = first_name + " " + last_name

    def greet(self):
        print('Hello, my name is ' + self.full_name + '.')
```

However, there are two main problems with this bit of code:
1.  The parameters first_name and last_name are now misleading, since you can
    enter a full name for `first_name`. Also, if there are more cases and/or
    more parameters that have this kind of flexibility, the if/elif/else 
    branching can get annoying fast.
2.  Not quite as important, but still worth pointing out: what if `last_name`
    is None, but first_name doesn't split into two or more things via spaces?
    We have yet another layer of input validation and/or exception handling...

Enter class mehtods. Rather than having a single initializer, we will create a
separate initializer, called `from_full_name`, and decorate it with the 
(built-in) `classmethod` decorator.

```python
class Person(object):
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
        self.full_name = first_name + " " + last_name

    @classmethod
    def from_full_name(cls, name, age):
        if ' ' not in name:
            raise ValueError
        first_name, last_name = name.split(' ', 2)
        return cls(first_name, last_name, age)

    def greet(self):
        print('Hello, my name is ' + self.full_name + '.')
```

Notice `cls` instead of `self` as the first argument to `from_full_name`. Class
methods are applied to the overall class, not an instance of a given class(
which is what `self` usually denotes). So, if `cls` is our Person class, then
the returned value from the `from_full_name` class method is `Person(
first_name, last_name, age)`, which uses Person's `__init__` to create an 
instance of the Person class. In particular, if we were to make a subclass
Emploee of Person, then `from_full_name` would work in the Employee class as
well.

To show that this works as expected, let's create instances of Person in more
than one way without the branching in `__init__`:
```python
bob = Person("Bob", "Bobberson", 24)

alice = Person.from_full_name("Alice Henderson", 31)

bob.greet()
# Hello, my name is Bob Bobberson.

alice.greet()
# Hello, my name is Alice Henderson.
```


### 38.7 Multiple Inheritance
Python uses the `C3 linearization` algorithm to determine the order in which to
resolve class attributes, including methods, This is known as the Method 
Resolution Order(MRO).

Here's a simple example:
```python
class Foo(object):
    foo = 'attr foo of Foo'

class Bar(object):
    foo = 'attr foo of Bar'  # we won't see this.
    bar = 'attr bar of Bar'

class FooBar(Foo, Bar):
    foobar = 'attr foobar of FooBar'
```

Now if we instantiate FooBar, if we look up the foo attribute, we see that 
Foo's attributes is found first
```python
fb = FooBar()

>>> fb.foo
# 'attr foo of Foo'
```

Here's the MRO of FooBar:
```
>>> FooBar.mro()
[<class '__main__.FooBar'>, <class '__main__.Foo'>, <class '__main__.Bar'>, <type 'object'>]
```

It can be simply stated that Python's MRO algorithm is
1. Depth first(e.g. FooBar then Foo) unless
2. a shared parent(object) is blocked by a child(Bar) and
3. no circular relationships allowde.

That is, for example, Bar cannot inherit from FooBar while FooBar inherits from
Bar.

Another powerful feature in inheritance is `super`. super can fetch parent 
classes features.

```python
class Foo(object):
    def foo_method(self):
        print('foo Method')

class Bar(object):
    def bar_method(self):
        print('bar Method')

class FooBar(Foo, Bar):
    def foo_method(self):
        super(FooBar, self).foo_method()
```

Multiple inheritance with init method of class, when every class has own init
method then we try for multiple inheritance then only init method get called of
class which is inherit first.

For below example only Foo class __init__ method getting called, __Bar__ class
init not getting called
```python
class Foo(object):
    def __init__(self):
        print('foo init')

class Bar(object):
    def __init__(self):
        print('bar init')

class FooBar(Foo, Bar):
    def __init__(self):
        print('foobar init')
        super(FooBar, self).__init__()

a = FooBar()
# foobar init
# foo init
```

But it doesn't mean that Bar class is not inherit. instance of final FooBar 
class is also instance of Bar class and Foo class.
```python
print(isinstance(a, FooBar)) # True
print(isinstance(a, Bar))    # True
print(isinstance(a, Foo))    # True
```


### 38.8 Properties
Python classes support properties, which look like regular object variables, 
but with the possibility of attaching custom behavior and documentation.

```python
class MyClass(object):
    def __init__(self):
        self._my_string = ''

    @property
    def string(self):
        """A profoundly important string."""
        return self._my_string

    @string.setter
    def string(self, new_value):
        assert isinstance(new_value, str), \
               "Give me a string, not a %r!" % type(new_value)
        self._my_string = new_value

    @string.deleter
    def x(self):
        self._my_string = None
```

The object's of class MyClass will appear to have a property `.string`, however
it's behavior is now tightly controlled:
```python
mc = MyClass()
mc.string = "String!"
print(mc.string)
del mc.string
```

As well as the useful syntax as above, the property syntax allows for 
validation, or other augmentations to be added to those attributes. This could
be especially useful with public APIs - where a level of help should be given 
to the user.

Another common use of properties is to enable the class to persent "virtual
attributes: - attributes which aren't actually stored but are computed only
when requested.

```python
class Character(object):
    def __init__(self, name, max_hp):
        self._name = name
        self._hp = max_hp
        self._max_hp = max_hp

    # Make hp read only by not providing a set method
    @property
    def hp(self):
        return self._hp

    # Make name read only by not providing a set method
    @property
    def name(self):
        return self.name

    def take_damage(self, damage):
        self.hp -= damage
        self.hp = 0 if self.hp < 0 else self.hp

    @property
    def is_alive(self):
        return self.hp != 0

    @property
    def is_wounded(self):
        return self.hp < self.max_hp if self.hp > 0 else False

    @property
    def is_dead(self):
        return not self.is_alive


bilbo = Character('Bilbo Baggins', 100)
bilbo.hp
# out: 100
bilbo.hp = 200
# out: AttributeError: can't set attribute
# hp attribute is read only.

bilbo.is_alive # True
bilbo.is_wounded # False
bilbo.is_dead  # False

bilbo.take_damage(50)
bilbo.hp    # 50

bilbo.is_alive # True
bilbo.is_wounded # True
bilbo.is_dead  # False

bilbo.take_damage(50)
bilbo.hp    # 50

bilbo.is_alive # False
bilbo.is_wounded # True
bilbo.is_dead  # True
```


### 38.9 Default values for instance variables
If the variable contains a value of an immutable type(e.g. a string) then it is
okay to assign a default value like this
```python
class Rectangle(object):
    def __init__(self, width, height, color='blue'):
        self.width = width
        self.height = height
        self.color = color

    def area(self):
        return self.width * self.height


# Create some instances of the class
default_rectangle = Rectangle(2, 3)
print(default_rectangle.color)  # blue

red_rectangle = Rectangle(2, 3, 'red')
print(red_rectangle.color)  # red
```

One needs to be careful when initializing mutable objects such as lists in the
constructor. Consider the following example:
```python
class Rectangle2D(object):
    def __init__(self, width, height, pos=[0, 0], color='blue'):
        self.width = width
        self.height = height
        self.pos = pos
        self.color = color


r1 = Rectangle2D(5, 3)
r2 = Rectangle2D(7, 8)
r1.pos[0] = 4
r1.pos  # [4, 8]
r2.pos  # [4, 8] r2's pos has changed as well
```

This behavior is caused by the fact that in Python default parameters are bound
at function execution and not at function declaration. To get a default 
instance variable that's not shared among instances, one should use a construct
like this:
```python
class Rectangle2D(object):
    def __init__(self, width, height, pos=None, color='blue'):
        self.width = width
        self.height = height
        self.pos = pos or [0, 0] 
        self.color = color


r1 = Rectangle2D(5, 3)
r2 = Rectangle2D(7, 8)
r1.pos[0] = 4
r1.pos  # [4, 0]
r2.pos  # [0, 0]
```


### 38.10 Class and instance variables
Instance variables are unique for each instance, while class variables are 
shared by all instances.

```python
classs C:
    x = 2  # calss variable

    def __init__(self, y)
        self.y = y  # instance variable


C.x  # 2
C.y  # AttributeError: type object 'C' has no attribute 'y'

c1 = C(3)
c1.x # 2
c1.y # 3

c2 = C(4)
c2.x # 2
c2.y # 4
```

Class variables can be accessed on instances of this class, but assigning to 
the class attribute will create an instance variable which shadows the class
variable

```python
c2.x = 4
c2.x  # 4
C.x   # 2
```

Note that mutating class variables from instances can lead to some unexpected
consequences.
```python
class D:
    x = []
    def __init__(self, item):
        self.x.append(item)  # note that this is not an assignment!


d1 = D(1)
d2 = D(2)

d1.x  # [1, 2]
d2.x  # [1, 2]
D.x   # [1, 2]
```


### 38.11 Class composition
Class composition allows explicit relations between objects. In this example,
people live in cities that belong to countries. Composition allows people to
access the number of all people living in their country:
```python
class Country(object):
    def __init__(self):
        self.cities = []

    def addCity(self, city):
        self.cities.append(city)


class City(object):
    def __init__(self, numPeople):
        self.people = []
        self.numPeople = numPeople

    def addPerson(self, person):
        self.people.append(person)

    def join_country(self, country):
        self.country = country
        country.addCity(self)

        for i in range(self.numPeople):
            person(i).join_city(self)


class Person(object):
    def __init__(self, ID):
        self.ID = ID

    def join_city(self, city):
        self.city = city
        city.addPerson(self)

    def people_in_my_country(self):
        x = sum([len(c.people) for c in self.city.country.cities])
        return x


US = Country()
NYC = City(10).join_country(US)
SF = CIty(5).join_country(US)

print(US.cities[0].people[0].people_in_my_country())
# 15
```


### 38.12 Listing All Class Members
The `dir()` function can be used to get a list of the members of class:
```python
dir(Class)
```

For example:
```python
>>> dir(list)
['__add__', '__class__', '__contains__', ...]
```

It is common to look only for "non-magic" members. This can be done using a
simple comprehension that lists members with names not starting with `__`:
```python
>>> [m for m in dir(list) if not m.startswith('__')]
['append', 'clear', 'copy', 'count', 'extend', 'index', 'insert', 'pop', 
'remove', 'reverse', 'sort']
```


### 38.13 Singleton class
A singleton is a pattern that restricts the instantiation of a class to one
instance/object. For more info on python singleton design patterns, see [here](
https://python-3-patterns-idioms-test.readthedocs.io/en/latest/Singleton.html)

```python
class Singleton:

    def __new__(cls):
        try:
            it = cls.__it__
        except AttributeError:
            it = cls.__it__ = object.__new__(cls)
        return it

    def __repr__(self):
        return '<{}>'.format(self.__class__.__name__.upper())

    def __eq__(self, other):
        return other is self
```

Another method is to decorate your class. Following the example create a 
Singleton class:
```python
class Singleton:
    def __init__(self, decorated):
        self._decorated = decorated

    def Instance(self):
        """
        Returns the singleton instance. Upon its first call, it creates a new
        instance of the decorated class and calls its `__init__` method. On all
        subsequent calls, the already created instance is returned.
        """
        try:
            return self._instance
        except AttributeError:
            self._instance = self._decorated()
            return self._instance

    def __call__(self)
        raise TypeError('Singletons must be accessed throuth `Instance()`.')

    def __instancecheck__(self, inst):
        return isinstance(inst, self._decorated)
```

To use you can use the Instance method
```python
@Singleton
class Single:
    def __init__(self):
        self.name = None
        self.val = 0

    def getName(self):
        print(self.name)

x = Single.Instance()
y = Single.Instance()
x.name = "I'm single"
x.getName()  # I'm single
y.getName()  # I'm single 
```


### 38.14 Descriptors and Dotted Lookups
__Descriptors__ are objects that are (usually) attributes of classes and that 
have any of `__get__, __set__`, pr `__delete__` special methods.

__Data Descriptors__ have any of `__set__, or __delete__`

These can control the dotted lookup on an instance, and are used to implement
functions, `staticmethod, classmethod, and property`. A dotted lookup(e.g. 
instance foo of class Foo looking up attribute bar-i.e. foo.bar) uses the 
following algorithm:
1. `bar` is looked up in the class, Foo. If it is there and it is a 
    __Data Descriptor__, then the data descriptor is used. That's how `property`
    is able to control access to data in an instance, and instances cannot 
    override this.  If a __Data Descriptor__ is not there, then.
2. bar is looked up in the instance `__dict__`. This is why we  can override or
    block methods being called from an instance with a dotted lookup. If bar 
    exists in the instance, it is used. If not, we then
3. look in the class Foo for bar. If it is a Descriptor, then the descriptor
    protocol is used. This is how functions(in this context, unbound methods),
    `classmethod, and staticmethod` are implemented. Else it simply returns 
    the object there, or there is an `AttributeError`



# Chapter 39: Metaclasses
Metaclasses allow you to deeply modify the behavior of Python classes(in terms
of how they're defined, instantiated, accessed, and more) by replacing the 
`type` metaclass that new classes use by default.


### 39.1 Basic Metaclasses
When `type` is called with three arguments it behaves as the (meta)class it is,
and creates a new instance, ie. it produces a new class/type.

```python
Dummy = type('OtherDummy', (), dict(x = 1))
Dummy.__class__             # <type 'type'>
Dummy.__class__.__class__   # <type 'type'>
```

It is possible to subclass `type` to create an custom metaclass.
```python
class mytype(type):
    def __init__(cls, name, bases, dict):
        # call the base initializer
        type.__init__(cls, name, bases, dict)

        # perform custom initialization...
        cls.__custom_attribute__ = 2
```


Now, we have a new custom mytype metaclass which can be used to create classes 
in the same manner as type
```python
MyDummy = mytype('MyDummy', (), dict(x=2))
MyDummy.__class__               # <class '__main__.mytype'>
MyDummy().__class__.__class__   # <class '__main__.mytype'>
MyDummy.__custom_attribute__    # 2
```

When we create a new class using the `class` keyword the metaclass is by 
default chosen based on upon the baseclass
```python
class Foo(object):
    pass

type(Foo)
# type
```

In the above example the only baseclass is `object` so our metaclass will be 
the type of `object`, which is `type`. It is possible override the default, 
however it depends on whether we use Python 2 or Python 3:

Python 2.x Version <= 2.7

A special class-level attribute `__metaclass__` can be used to specify the 
metaclass.
```python
class MyDummy(object):
    __metaclass__ = mytype

type(MyDummy)  # <class '__main__.mytype'>
```

Python 3.x

A special `metaclass` keyword argument specify the metaclass.
```python
class MyDummy(metaclass=mytype):
    pass

type(MyDummy)  # <class '__main__.mytype'>
```

Any keyword arguments(except metaclass) in the class declaration will be passed
to the metaclass. Thus `class MyDummy(metaclass=mytype, x=2)` will pass `x=2` 
as a keyword argument to the mytype constructor.



### 39.2 Singletons using metaclasses
A singleton is a pattern that restricts the instantiation of a class to one
instance/object.
```python
class SingletonType(type):
    def __call__(cls, *args, **kwargs):
        try:
            return cls.__instance
        except AttributeError:
            cls.__instance = super(SingletonType, cls).__call__(*args, **kwargs)
            return cls.__instance

# Python 2.x
class MySingleton(object):
    __metaclass__ = SingletonType

# Python 3.x
class MySingleton(metaclass=SingletonType):
    pass

MySingleton(0 is MySingleton()  # True, only one instantiation occurs
```



### 39.3 Using a metaclass
__Metaclass syntax__

Python 2.x
```python
class MyClass(object):
    __metaclass__ = SomeMetaclass
```

Python 3.x
```python
class MyClass(metaclass=SomeMetaclass):
    pass
```

Python 2 and 3 compatibility with six
```python
import six

class MyClass(six.with_metaclass(SomeMetaclass)):
    pass
```



### 39.4 Introduction to Metaclasses
__What is a metaclass?__

In Python, everything is an object: integers, strings, lists, even functions
and classes themselves are objects. And every object is an instance of a class.

To check the class of an object x, one can call `type(x)`, so:
```python
>>> type(5)
<type 'int'>
>>> type(str)
<type 'type'>
>>> type([1, 2, 3])
<type 'list'>


>>> class C(object):
...     pass
...
>>> type(C)
<type 'type'>
```

Most classes in Python are instances of `type`. `type` itself is also a class.
Such classes whose instances are also classes are called metaclasses.

__The Simplest Metaclass__
Ok, so there is already one metaclass in Python: type. Can we create anther 
one?

```python
class SimplestMetaclass(type):
    pass

class MyClass(object):
    __metaclass__ = SimplestMetaclass
```

That does not add any functionality, but it is a new metaclass, see that 
MyClass is now an instance of SimplestMetaclass:
```python
>>> type(MyClass)
< class '__main__.SimplestMetaclass' >
```

__A Metaclass which does Something__
A Metaclass which does something usually override type's `__new__`, to modify
some properties of the class to be created, before calling the orginal 
`__new__` which creates the class:
```python
class AnotherMetaclass(type):
    def __new__(cls, name, parents, dict):
        """
        Args:
            cls is this class
            name is the name of the class to be created
            parents is the list of the class's parent classes
            dict is the list of class's attributes(methods, static variables)
        """

        # here all of the attributes can be modified before creating the class, 
        # e.g.

        dict['x'] = 8  # now the class will have a static variable x = 8

        # return value is the new class. super will take care of that
        return super(AnotherMetaclass, cls).__new__(cls, name, parents, dict)
```



### 39.5 Custon functionality with metaclasses
__Functionality in metaclasses__ can be changed so that whenever a class is 
built, a string is printed to standard output, or an exception is thrown. This
metaclass will print the name of the class being built.
```python
class VerboseMetaclass(type):
    def __new__(cls, class_name, class_parents, class_dict):
        print('Creating class ", class_name)
        new_class = super().__new__(cls, class_name, class_parents, class_dict)
        return new_class
```

You can use the metaclass like so:
```python
class Spam(metaclass=VerboseMetaclass):
    def eggs(self):
        print('[insert example string here]')


s = Spam()
s.eggs()
# Out:
# Creating class Spam
# [insert example string here]
```



### 39.6 The default metaclass
You may have heard that everything in Python is an object. It is true, and all
objects have a class:
```
>>> type(1)
int
```

The literal 1 is an instance of int. Let's declare a class:
```
>>> class Foo(object):
...     pass
...

```

Now let's instantiate it:
```
>>> bar = Foo()
```

What is the class of bar?
```
>>> type(bar)
Foo
```

Nice, bar is an instance of Foo. But what is the class of Foo itself?
```
type(Foo)
type
```

Ok, Foo is an instance of type. How about type itself?
```
>>> type(type)
type
```

So what is a metaclass? For now let's pretend it is just a fancy name for the
class of a class. Takeaways:
    - Everything is an object in Python, so everything has a class
    - The class of a class is called metaclass
    - The default metaclass is type, and by far it is the most common metaclass

But why should you know about metaclasses? Well, Python itself is quite 
"hackable", and the concept of metaclass is important if you are doing advanced
stuff like meta programming or if you want to control how your classes are
initialized.



# Chapter 40: String Formatting
When storing and transforming data for humans to see, string formatting can 
become very important. Python offers a wide variety of string formatting 
methods which are outlined in this topic.



### 40.1 Basics of String formatting
```python
foo = 1
bar = 'bar'
baz = 3.14
```

You can use `str.format` to format output. Bracket pairs are replaced with 
arguments in the order in which the arguments are passed:
```python
print('{}, {} and {}'.format(foo, bar, baz))
# Out: "1, bar and 3.14'
```

Indexes can also be specified inside the brackets. The numbers correspond to 
indexes of the arguments passed to the `str.format` function(0-based).
```python
print('{0}, {1}, {2}, and {1}'.format(foo, bar, baz))
# Out: '1, bar, 3.14, and bar'
print('{0}, {1}, {2}, and {3}'.format(foo, bar, baz))
# Out: index out of range error
```

Named arguments can be also used:
```python
print('X value is: {x_val}. Y value is: {y_val}.'.format(x_val=2, y_val=3))
# Out: 'X value is: 2. Y value is: 3.'
```

Object attributes can be referenced when passed into `str.format`:
```python
class AssignValue(object):
    def __init__(self, value):
        self.value = value


my_val = AssignValue(6)
print('My value is: {0.value}'.format(my_val))  # "0" is optional
# Out: 'My value is: 6'
```

Dictionary keys can be used as well:
```python
my_dict = {'key': 6, 'other_key': 7}
print('My other key is: {0[other_key]}'.format(my_dict))  # "0" is optional
# Out: 'My other key is: 7'
```

__Same applies to list and tuple__

Note: In addition to `str.format`, Python also provides the modulo operator `%`
-- also known as the string formatting or interpolation operator(see PEP 31011)
-- for formatting strings. `str.format` is a successor of `%` and it offers 
greater flexibility, for instance by making it easier to carry out multiple
substitutions.

In addition to argument indexes, you can also include a _format specification_
inside the curly brackets. This is an expression that follows special rules and
must be preceded by a colon(:). An example of format specification is the 
alignment directive `:~^20` (^ stands for center alignment, total width 20, 
fill with ~ character):
```python
'{:~^20}'.format('centered')
# Out: '~~~~~centered~~~~~'
```

format allows behavior not possible with `%`, for example repetition of 
arguments:
```python
t = (12, 45, 22, 103, 6)
print('{0} {2} {1} {2} {3} {2} {4} {2} '.format(*t))
# Out: 12 22 45 22 103 22 6 22
```

As format is a function, it can be used as an argument in other functions:
```python
number_list = [12, 45, 78]
print(map('the number is {}'.format, number_list))
# Out: ['the number is 12', 'the number is 45', 'the number is 78'] 
```

```python
from datetime import datetime, timedelta

once_upon_a_time = datetime(2020, 5, 25, 11, 5, 0, 0)
delta = timedelta(days=3, hours=8, minutes=20)

gen = (once_upon_a_time + x * delta for x in xrange(5))

print('\n'.join(map('{:%Y-%m-%d %H:%M:%S}'.format, gen)))
# Out:
# 2020-05-25 11:05:00
# 2020-05-28 19:25:00
# 2020-06-01 03:45:00
# 2020-06-04 12:05:00
# 2020-06-07 20:25:00 
```



### 40.2 Alignment and padding
The format() method can be used to change the alignment of the string. You have
to do it with a format expression of the form: `[fill_char][align_operator]
[width]` where `align_operator` is one of:
    - < forces the field to be left-aligned within width
    - > forces the field to be right-aligned within width
    - ^ forces the field to be centered within width.
    - = forces the padding to be placed after the sign(numeric types only)

`fill_char`(if omitted default is whitespace) is the character used for the 
padding.
```python
'{:~<9s}, World'.format('Hello')
# 'Hello~~~~, World'

'{:~>9s}, World'.format('Hello')
# '~~~~Hello, World'

'{:~^9s}, World'.format('Hello')
# '~~Hello~~, World'

'{:0=6d}'.format(-123)
# '-00123'
```



### 40.3 Format literals(f-string)
Literal format strings were introduced in PEP 498(Python 3.6 and upwards), 
allowing you to prepend `f` to the beginning of a string literal to effectively
apply `.format` to it with all variables in the current scope.
```python
foo = 'bar'
f'Foo is {foo}'
'Foo is bar'


# This works with more advanced format strings too, including alignment and dot
# notation.

f'{foo:^7s}'
'  bar  '
```
__Note__: The f'' does not denote a particular type like b'' for bytes or u''
for `unicode` in python2. The formatting is immediately applied, resulting in
a normal string.

The format string can also be _nested_:
```python
price = 478.23
f"{f'${price:0.2f}':*>20s}"
# '*************$478.23'
```

The expressions in an f-string are evaluated in left-to-right order. This is
detectable only if the expressions have side effects:
```python
def fn(l, incr):
    result = l[0]
    l[0] += incr
    return result

lst = [0]
f'{fn(lst, 2)} {fn(lst, 3)}'
# '0 2'

f'{fn(lst, 2)} {fn(lst, 3)}'
# '5 7'

print(lst)
#[10]
```



### 40.4 Float formatting 
```bash
>>> '{0:.0f}'.format(42.12345}
'42'

>>> '{0:.1f}'.format(42.12345}
'42.1'

>>> '{0:.3f}'.format(42.12345}
'42.123'

>>> '{0:.5f}'.format(42.12345}
'42.12345'

>>> '{0:.7f}'.format(42.12345}
'42.1234500'
```

Same hold for other way of referencing
```python
>>> '{0:.3f}'.format(42.12345}
'42.123'

>>> '{answer:.3f}'.format(answer=42.12345}
'42.123'
```

Floating point numbers can also be formatted in `scientific notation` or as
percentages:
```python
>>> '{answer:.3e}'.format(answer=42.12345}
'4.212e+01'

>>> '{answer:.0%}'.format(answer=42.12345}
'4212%'
```

You can also combine the {0} and {name} notations. This is especially useful 
when you want to round all variables to a pre-specified number of decimals with
1 _declaration_:
```python
>>>  s = 'Hello'
>>> a, b, c = 1.12345, 2.34567, 3.45678
>>> digits = 2

>>> '{0}! {1:.{n}f}, {2:.{n}f}, {3:.{n}f}'.format(s, a, b, c, n=digits) 
'Hello! 1.12, 2.35, 34.57'
```



### 40.5 Named placeholders
Format strings may contain named placeholders that are interpolated using 
keyword arguments to `format`.
__using a dictionary (Python 2.x)__
```python
>>> data = {'first': 'Hodor', 'last': 'Hodor!'}
>>> '{first} {last}'.format(**data)
'Hodor Hodor!'
```

__using a dictionary (Python 3.2+)__
```python
>>> '{first} {last}'.format_map(data)
'Hodor Hodor!'
```

`str.format_map` allows to use dictionaries without having to unpack them 
first. Also the class of data(which might be a custom type) is used instead of
a newly filled `dict`.

__without a dictonary__
```python
>>> '{first} {last}'.format(first='Hodor', last='Hodor!')
'Hodor Hodor!'
```



### 40.6 String formatting with datatime
Any class can configure its own string formatting syntax through the 
`__format__` method. A type in the standard Python library that makes handy use
of this is the `datetime` type, where one can use `strftime-like` formatting 
codes directly within `str.format`:
```python
>>> from datetime import datetime
>>> 'Chinese: {dt:%m/%d/%Y}.  ISO: {dt:%Y-%m-%d}.'.format(dt=datetime.now())
'Chinese: 05/28/2020.  ISO: 2020-05-28.'
```



### 40.7 Formatting Numerical Values
The `.format()` method can interpret a number in different formats, such as:
```python
>>> '{:c}'.format(65)  # Unicode character
'A'

>>> '{:d}'.format(0x0a)  # base 10
'10'

>>> '{:n}'.format(0x0a)  # base 10 using current locale for separators
'10'
```

Format integers to different bases(hex, oct, binary)
```python
>>> '{:x}'.format(10)  # base 16, lowercase - Hexadecimal
'a'

>>> '{:X}'.format(10)  # base 16, uppercase - Hexadecimal
'A'

>>> '{:o}'.format(10)  # base 8, Octal
'12'

>>> '{:b}'.format(10)  # base 2, Binary
'1010'

>>> '{0:#b}, {0:#o}, {0:#x}'.format(42)  # with prefix 
'0b101010, 0o52, 0x2a'

>>> '8 bit: {0:08b}; Three bytes: {0:06x}'.format(42)  # Add zero padding
'8 bit: 00101010; Three bytes: 00002a'
```

Using formatting to convert an RGB float tuple to a color hex string:
```python
>>> r,g,b = (1.0, 0.4, 0.0)
>>> '#{:02X}{:02X}{:02X}'.format(int(255*r), int(255*g), int(255*b))
'#FF6600'
```

Only integers can be converted
```python
>>> '{:x}'.format(42.0)
ValueError: Unknown format code 'x' for object of type 'float'
```



### 40.8 Nested formatting
Some formats can take additional parameters, such as the width of the formatted
string, or the alignment:
```python
>>> '{:.>10}'.format('foo')
'.......foo'
```

Those can also be provided as parameters to format by nesting more {} inside {}:
```python
>>> '{:.>{}}'.format('foo', 10)
'.......foo'

>>> '{:{}{}{}}'.format('foo', '*', '^', 15)
'******foo******'
```

This can be useful in cases when parameters are not known beforehand, for 
instances when aligning tabular data:
```python
>>> data = ["a", "bbbbbbb", "ccc"]
>>> m = max(map(len, data))
>>> for d in data:
...     print('{:>{}}'.format(d, m))
      a
bbbbbbb
    ccc
```



### 40.9 Format using Getitem and Getattr
Any data structure that supports `__getitem__` can have their nested structure
formatted:
```python
person = {'first': 'Arthur', 'last': 'Dent'}
'{p[first]} {p[last]}'.format(p = person)
# 'Arthur Dent'
```

Object attributes can be accessed using `getattr()`:
```python
class Person(object):
    first = 'Zaphod'
    last = 'Beeblebrox'

'{p.first} {p.last}'.format(p = Person())
# 'Zaphod Beeblebrox'
```



### 40.10 Padding and truncating strings, combined
Say you want to print variables in a 3 character column.

Note: doubling { and } escape them.
```python
s = """"

pad
{{:3}}      :{a:3}:

truncate
{{:.3}}     :{e:.3}:

combined
{{:>3.3}}   :{a:>3.3}:
{{:3.3}}    :{a:3.3}:
{{:3.3}}    :{c:3.3}:
{{:3.3}}    :{e:3.3}:
"""

print(s.format(a='1'*1, c='3'*3, e='5'*5))
# Out:
pad
{:3}      :1  :

truncate
{:.3}     :555:

combined
{:>3.3}   :  1:
{:3.3}    :1  :
{:3.3}    :333:
{:3.3}    :555:
```



### 40.11 Custom formatting for a class
For every value which is passed to the format function, Python looks for a
`__format__` method to determine how the format function will display and 
format your class and it's attributes.

This is different than the `__str__` method, as in the `__format__` method you
can take into account the formatting language, including alignment, field width
etc, and even(if you wish) implement your own format specifiers, and your own
format ting language extensions.
```python
object.__format__(self, format_spec)
```

For example:
```python
class Example(object):
    def __init__(self, a, b, c):
        self.a, self.b, self.c = a, b, c

    def __format__(self, format_spec):
        """ Implement special semantics for the 's' format specifier """
        # reject anything that isn't an s
        if format_spec[-1] != 's':
            raise ValueError('{} format specifier not understood for this 
                      object', format_spec[:-1])
        # output in this example will be (<a>, <b>, <c>)
        raw = '(' + ','.join([str(self.a), str(self.b), str(self.c)]) + ')' 
        # Honor the format language by using the inbuilt string format
        # Since we know the original format_spec ends in an 's'
        # we can take advantage of the str.format method with a string 
        # argument we constructed above.
        return "{r:{f}}".format(r=raw, f=format_spec)


instance = Example(1, 2, 3)
print("{0:>20s}".format(instance)
# Out:            (1,2,3)
# Note how the right align and field width of 20 has been honored
```

__Note__ 

In Python3, to pass your custom class to the format function, you will need 
define `__format__` method on your own custom class.



# Chapter 41: String Methods



### 41.1 Changing the cpitalization of a string
Python's string type provides many functions that act on the capitalization of 
a string. These include:
- str.casefold
- str.upper
- str.lower
- str.capitalize
- str.title
- str.swapcase

With unicode strings(the default in Python3), these operations are not 1:1 
mappings or reversible. Most of these operations are intended for dispaly 
purposes, rather than normalization.

```python
# Python 3.x
str.casefold()
```
`str.casefold` creates a lowercase string that is suitable for case insensitive
comparisons. This is more aggressive than `str.lower` and may modify strings
that are already in lowercase or cause strings to grow in length, and is not
intended  for dispaly purposes.
```python
"XßΣ".casefold()
# 'xssσ'
"XßΣ".lower()
# 'xßς'
```
The transformations that take place under casefolding are defined by the 
Unicode Consortium in the CaseFolding.txt file on their website.

```python
# str.upper()`
# str.upper takes every character in a string and converts it to its uppercase
# equivalent.

# str.lower()
# str.lower does the opposite; it takes every character in a string and 
# converts it to its lowercase equivalent.

# str.capitalize()
# str.capitalize returns a capitalized version of the string, that is, it makes
# the first character have upper case and the rest lower.

# str.title()
# str.title returns the title cased version of the string, that is, every 
# letter in the beginning of a word is made upper case and all others are made
# lower case:
"this Is a 'String'".title()
# "This Is A 'String'" 

# str.swapcase()
# str.swapcase returns a new string object in which all lower case characters
# are swapped to upper case and all upper case characters to lower:
"this iS A STRiNG".swapcase()
# "THIS Is a strIng"
```

__Usage as str class methods__
It is worth noting that these methods may be called either on string object(as
shown above) or as a class method of the `str` class(with an explicit call to
str.upper etc)
```python
str.upper('This is a string')
# 'THIS IS A STRING'
```

This is more useful when applying one of these methods to many strings at once
in say, a `map` function.
```python
map(str.upper, ["These", "are", "some", "strings"])
# ["THESE", "ARE", "SOME", "STRINGS"]
```



### 41.2 str.translate: Translating characters in a string
Python supports a translate method on the `str` type which allows you to 
specify the translation table(used for replacements) as well as any characters
which should be deleted in the process.

str.translate(table[, deletechars])
| Parameter   | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| table       | It is a lookup table that defines the mapping from one character to another |
| deletechars | A list of characters which are to be removed from the string.               |

The maketrans method(str.maketrans in Python 3 and string.maketrans in Python2)
allow you to generate a translation table.
```python
translation_table = str.maketrans('aeiou', '12345')
my_string = "This is a string"
translated = my_string.translate(translation_table)
# "Th3s 3s 1 str3ng"
```

The translate method returns a string which is a translated copy of the 
original string. You can set the table argument to None if you only need to
delete characters.
```python
'this syntax is very useful'.translate(None, 'aeiou')
# 'ths syntx s vry sfl'
```



### 41.3 str.format and f-strings: Format values into a string
Python provides string interpolation and formatting functionality through the 
`str.format` function, introduced in version 2.6 and f-strings introduced in 
version 3.6

Given the following variables
```python
i = 10
f = 1.5
s = 'foo'
l = ['a', 1, 2]
d = {'a': 1, 2: 'foo'}
```

The following statements are all equivalent
```python
"10 1.5 foo ['a', 1, 2] {'a': 1, 2: 'foo'}"
>>> "{} {} {} {} {}".format(i, f, s, l, d)
>>> str.format("{} {} {} {} {}", i, f, s, l, d)
>>> "{0} {1} {2} {3} {4}".format(i, f, s, l, d)
>>> "{0:d} {1:0.1f} {2} {3!r} {4!r}".format(i, f, s, l, d)
>>> "{i:d} {f:0.1f} {s} {l!r} {d!r}".format(i=i, f=f, s=s, l=l, d=d)
>>> f"{i} {f} {s} {l} {d}"
>>> f"{i:d} {f:0.1f} {s} {l!r} {d!r}"
```

For reference, Python also supports C-style qualiﬁers for string formatting. 
The examples below are equivalent to those above, but the `str.format` version
are preferred due to benefits in flexibility, consistency of notation, and
extensibility:
```python
"%d %0.1f %s %r %r" % (i, f, s, l, d)
"%(i)d %(f)0.1f %(s)s %(l)r %(d)r" % (i=i, f=f, s=s, l=l, d=d)
```

The braces uses for interpolation in `str.format` can also be numbered to 
reduce duplication when formatting strings. For example, the following are
equivalent:
```python
"I am from Australia. I love cupcakes from Australia!"
>>> "I am from {}. I love cupcakes from {}!".format("Australia", "Australia")
>>> "I am from {0}. I love cupcakes from {0}!".format("Australia")
```

While the oﬃcial python documentation is, as usual, thorough enough, 
pyformat.info has a great set of examples with detailed explanations.

Additionally, the { and } characters can be escaped by using double brackets:



### 41.4 String module's useful constants
Python's string module provides constants for string related operations. To use
them, import the string module:
```python
>>> import string
>>> string.ascii__letters
'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

>>> string.ascii_lowercase
'abcdefghijklmnopqrstuvwxyz'

>>> string.ascii_uppercase
'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

>>> string.digits
'0123456789'

>>> string.hexdigits
'0123456789abcdefABCDEF'

>>> string.octaldigits
'01234567'

>>> string.punctuation
'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'

>>> string.whitespace
' \t\n\r\x0b\x0c'
```



### 41.5 Stripping unwanted leading/trailing characters from a string
Three methods are provided that offer the ability to strip leading and trailing
characters from a string: `str.strip, str.rstrip, str.lstrip`. All three 
methods have the same signature and all three return a new string object with
unwanted characters removed.

```
str.strip([chars])
```
`str.strip` acts on a given string and removes(strips) any leading or trailing
characters contained in the argument chars; if chars is not supplied or is 
None, all white space characters are removed by defaul. For example:
```python
>>> "    a line with leading and trailing space     ".strip()
'a line with leading and trailing space'
```
If chars is supplied, all characters contained in it are removed from the 
string, which is returned. FOr example:
```python
>>> ">>> a Python prompt".strip('> ')  # strips '>' character and space character
'a Python prompt'
```

__str.rstrip([chars[) and str.lstrip([chars[)__

These methods have similar semantics and arguments with `str.strip()`, their
difference lies in the direction from which they start. `str.rstrip()` starts
from the end of the string while `str.lstrip()` splits from the start of the
string.

For example, using `str.rstrip`:
```python
>>> "     spacious string        ".rstrip()
"     spacious string"
```

While, using `str.lstrip`:
```python
>>> "     spacious string        ".lstrip()
"spacious string        "
```



### 41.6 Reversing a string
A string can reversed using the built-in `reversed()` function, which takes a 
string and returns an iterator in reverse order.
```python
>>> reversed('hello')
<reversed object at 0x...>
>>> [char for char in reversed('hello')]
['o', 'l', 'l', 'e', 'h']
```

`reversed()` can be wrapped in a call to `''.join()` to make a string from the
iterator.
```python
>>> ''.join(reversed('hello'))
'olleh'
```

While using `reversed()` might be more readable to uninitiated Python users, 
using extended slicing with a step of -1 is faster and more concise.
```python
>>> def reversed_string(main_string):
...     return main_string[::-1]
...
>>> reversed_string('hello')
'olleh'
```



### 41.7 Split a string based on a delimiter into a list of strings
__str.split(sep=None, maxsplit=-1)__

`str.split` takes a string and returns a list of substrings of the original
string. The behavior differs depending on whether the sep arguments is provided
or omitted.

If sep isn't provided, or is None, then the splitting takes place wherever 
there is whitespace. However, leading and trailing whitespace is ignored, and
multiple consecutive whitespace characters are treated the same as a single
whitespace character:
```python
>>> "This is a sentence.".split()
['This', 'is', 'a', 'sentence.']

>>> " This is    a sentence.  ".split()
['This', 'is', 'a', 'sentence.']

>>> "               ".split()
[]
```

The sep parameter can be used to define a delimiter string. The original string 
is split where the delimiter string occurs, and the delimiter itself is 
discarded. Multiple consecutive delimiters are not treated the same as a single
occurrence, but rather cause empty strings to be created.
```python
>>> "This is a sentence.".split(' ')
['This', 'is', 'a', 'sentence.']
>>> "Earth,Stars,Sun,Moon".split(',')
['Earth', 'Stars', 'Sun', 'Moon']
>>> " This is
a sentence. ".split(' ')
['', 'This', 'is', '', '', '', 'a', 'sentence.', '', '']
>>> "This is a sentence.".split('e')
['This is a s', 'nt', 'nc', '.']
>>> "This is a sentence.".split('en')
['This is a s', 't', 'ce.']
```

The default is to split on every occurrence of the delimiter, however the 
maxsplit parameter limits the number of splittings that occur. The default 
value of -1 means no limit:
```python
>>> "This is a sentence.".split('e', maxsplit=0)
['This is a sentence.']
>>> "This is a sentence.".split('e', maxsplit=1)
['This is a s', 'ntence.']
>>> "This is a sentence.".split('e', maxsplit=2)
['This is a s', 'nt', 'nce.']
>>> "This is a sentence.".split('e', maxsplit=-1)
['This is a s', 'nt', 'nc', '.']
```

__str.rsplit(sep=None, maxsplit=-1)__
`str.rsplit`("right split") differs from `str.split`("left split") when 
maxsplit is specified. The splitting starts at the ending of the string rather
that at the beginning:
```python
>>> "This is a sentence.".rsplit('e', maxsplit=1)
['This is a sentenc', '.']
>>> "This is a sentence.".rsplit('e', maxsplit=2)
['This is a sent', 'nc', '.']
```



### 41.8 Replace all occurrences of one substring with another substring

__str.replace(old, new[, count])__

`str.replace` takes two arguments old and new containing the old substring 
which is to be replaced by the new substring. The optional argument count
specifies the number of replacements to be made:
```python
>>> "Make sure to foo your sentence.".replace('foo', 'spam')
"Make sure to spam your sentence."
```

If the given string contains multiple examples that match the old argument, all 
occurrences are replaced with the value supplied in new:
```python
>>> "It can foo multiple examples of foo if you want.".replace('foo', 'spam')
"It can spam multiple examples of spam if you want."
```
unless, of course, we supply a value for count.



### 41.9 Testing what a string is composed of
Python's str type also features a number of methods that can be used to 
evaluate the contents of a string. These are `str.isalpha, str.isdigit, 
str.isalnum, str.isspace.` Capitalization can be tested with `str.isupper,
str.islower and str.istitle`.

__str.isalpha__

str.isalpha takes no arguments and returns True if the all characters in a given
string are alphabetic, for example:
```python
>>> "Hello World".isalpha()  # contains a space
False
>>> "Hello2World".isalpha()  # contains a number
False
>>> "HelloWorld!".isalpha()  # contains punctuation
False
>>> "HelloWorld".isalpha()
True
```

As an edge case, the empty string evaluates to False when used with "".isalpha() .

__str.isupper , str.islower , str.istitle__

These methods test the capitalization in a given string.

str.isupper is a method that returns True if all characters in a given string 
are uppercase and False otherwise.
```python
>>> "HeLLO WORLD".isupper()
False
>>> "HELLO WORLD".isupper()
True
>>> "".isupper()
False
```



### 41.10 String contains
Python makes it extremely intuitive to check if a string contains a given 
substring. Just use the in operator:
```python
>>> 'foo' in 'foo.baz.bar'
True
```

Note: testing an empty string will always result in True
```python
>>> '' in 'test'
True
```



### 41.11 Join a list of strings into one string
A string can be used as a separator to join a list of strings together into a
single string using the `join()` method. For example you can create a string
where each element in a list is separated by a space.
```python
>>> ' '.join(['once', 'upon', 'a', 'time'])
"once upon a time"
```

The following example separates the string elements with three hyphens.
```python
>>> '---'.join(['once', 'upon', 'a', 'time'])
"once---upon---a---time"
```



### 41.12 Counting number of times a substring appears in a string
One method is available for counting the number of occurrences of a sub-string
in another string, `str.count`.

`str.count(sub[, start[, end]])`

`str.count` returns an int indicating the number of non-overlapping occurrences
of the sub-string `sub` in another string. The optional arguments `start` and 
`end` indicate the beginning and the end in which the search will take place.
By default `start = 0` and `end = len(str)` meaning the whole string will be
searched:
```python
>>> s = "She sells seashells by the seashore."
>>> s.count("sh")
2
>>> s.count("se")
3
>>> s.count("sea")
2
>>> s.count("seashells")
1
```

By specifying a different value for start , end we can get a more localized 
search and count, for example, is start is equal to 13 the call to:
```python
>>> s.count('sea', start=13)
1
```



### 41.13 Case insensitive string comparisons
Comparing string in a case insensitive way seems like something that's trivial,
but it's not. This section only considers unicode strings(the default in 
Python3). Note that Python2 may have subtle weaknesses relative to Python 3 - 
the later's unicode handling is much more complete.

The first thing to note it that case-removing conversions in unicode aren't 
trivial. There is text for which `text.lower() != text.upper().lower()`, such 
as "ß":
```python

>>> "ß".lower()
'ß'
>>> "ß".upper().lower()
'ss'
```

But let's say you wanted to caselessly compare "BUSSE" and "Buße". You probably
also want to compare "BUSSE" and "BUßE" equal - that's teh newwe capital form.
The recommended way is to use `casefold`:
```python
>>> help(str.casefold)
"""
Help on method_descriptor:

casefold(...)
    S.casefold() -> str
    
    Return a version of S suitable for caseless comparisons.
"""
```

Do not just use `lower`. If `casefold` is not available, doing 
`.upper().lower()` helps(but only somewhat). Then you should consider accents.
if your font renderer is good, you probably think `"ê" == "ê"` - but it 
doesn't:
```python
>>> "ê" == "ê"
False
```

This is because they are actually
```python
>>> import unicodedata
>>> [unicodedata.name(char) for char in "ê"]
['LATIN SMALL LETTER E WITH CIRCUMFLEX']

>>> [unicodedata.name(char) for char in "ê"]
['LATIN SMALL LETTER E', 'COMBINING CIRCUMFLEX ACCENT']
```

The simplest way to deal with this is `unicodedata.normalize`. You probably 
want to use __NFKD__ normalization, but feel free to check the documentation.
Then one does
```python
>>> unicodedata.normalize("NFKD", "ê") == unicodedata.normalize("NFKD", "ê")
True
```

To finish up, here this is expressed in functions:
```python
import unicodedata

def normalize_caseless(text):
    return unicodedata.normalize("NFKD", text.casefold())

def caseless_equal(left, right):
    return normalize_caseless(left) == normalize_caseless(right)
```



### 41.14 Justify strings
Python provides functions for justigying strings, enabling text padding to make
aligning various strings much easier. Below is an example of `str.ljust` and
`str.rjust`:
```python
interstates_length = {
    5: (1381, 2222),
    19: (63, 102),
    40: (2555, 4112),
    93: (189, 305),
}

for road, length in interstates_lengths.items():
    miles, kms = length
    print('{} -> {} mi. ({}km.)'.format(str(road).rjust(4), str(miles).ljust(4),
          str(kms).ljust(4)))

# 40 -> 2555 mi. (4112 km.)
# 19 -> 63   mi. (102  km.)
# 5  -> 1381 mi. (2222 km.)
# 93 -> 189  mi. (305  km.)
```

ljust and rjust are very similar. Both have a width parameter and an optional 
fillchar parameter. Any string created by these functions is at least as long
as the width parameter that was passed into the function. If the string is 
longer that width alread, it is not truncated. The fillchar argument, which
defaults to the space character ' ' must be a single character, not a 
multicharacter string.

The ljust function pads the end of the string it is called on with the fillchar
until it is width characters long. Therefore, the `l and r` in the names of 
these functions refer to the side that the original string, not the fillchar, 
is positioned in the output string.



### 41.15 Test the starting and ending characters of a string
In order to test the beginning and ending of a given string in Python, one can
use the methods `str.startswith() and str.endswith()`.

`str.startswith(prefix[, start[, end]])`

As its name implies, `str.startswith` is used to test whether a given string
starts with the given characters in prefix.
```python
>>> s = 'This is a test string'
>>> s.startswith('T')
True
>>> s.startswith('Thi')
True
>>> s.startswith('thi')
False
```

The optional arguments start and end specify the start and end points from 
which the testing will start and finish. In the following example, by specify
a start value of 2 our string will be searched from position 2 and afterwards:
```
>>> s.startswith('is', 2)
True
>>> s[2]
'i'
>>> s[3]
's'
```

You can also use a `tuple` to check if it starts with any of a set of strings
```python
>>> s.startswith(('This', 'That'))
True
>>> s.startswith(('ab', 'cd'))
False
```

`str.endswith(prefix[, start[, end]])`

str.endswith is exactly similar to `str.startswith` with the only difference
being that it searches for ending characters and not starting characters.
```
>>> s = "this ends in a full stop."
>>> s.endswith('.')
True
>>> s.endswith('!')
False
```

as with startswith more than one characters can used as the ending sequence:
```
>>> s.endswith('stop.')
True
>>> s.endswith('Stop.')
False
```

You can also use a tuple to check if it ends with any of a set of strings
```
>>> s.endswith(('.', 'something'))
True
>>> s.endswith(('ab', 'bc'))
False
```



### 41.16 Conversion between str or bytes data and unicode characters
The contents of files and network messages may represent encoded characters.
They often need to be converted to unicode for proper display.

In Python 2, you may need to convert str data to Unicode characters. The 
default('', "", etc.) is an ASCII string, with any values outside of ASCII
range displayed as escaped values. Unicode strings are u''(or u"", etc.)

In Python 3, you may need to convert arrays of bytes(referred to as a 'byte 
literal') to strings of Unicode characters. The default is now a Unicode 
string, and bytestring literals must now be entered as b'', b"", etc. A byte
literal will return True to `isinstance(some_val, byte)`, assuming `some_val`
to be a string that might be encoded as bytes.
```python
>>> s = b'\xc2\xa9 abc'  # s is a byte array, not characters
                         # In Python 3, the default string literal is Unicode;
>>> s
b'\xc2\xa9 abc'
>>> s[0]
194
>>> type(s)
<class 'bytes'>

>>> u = s.decode('utf-8')# bytes.decode converts a byte array to a string(which
                         # will, in Python 3, be Unicode)
>>> u[0]
'©'
>>> type(u)
<class 'str'>
>>> u.encode('utf-8')
b'\xc2\xa9 abc'
```



# Chapter 42: Using loops within functions
In Python function will be returned as soon as execution hits "return" 
statement.



### 42.1 Return statement inside loop in a function
```python
def func(params):
    for value in params:
        print ('Got value {}'.format(value))
        if value == 1:
            # Returns from function as soon as value is 1
            print (">>>> Got 1")
            return
        print('Still looping')
    return "Couldn't find 1"


func([5, 3, 1, 2, 8, 9])

# Out:
# Got value 5
# Still looping
# Got value 3
# Still looping
# Got value 1
# >>>> Got 1
```



# Chapter 43: Importing modules



### 43.1 Importing a module
Use the `import` statement:
```python
>>> import random
>>> print(random.randint(1, 10))
4
```

`import` module will import a module and then allow you to reference its 
objects -- values, functions and classes, for example -- using the module.name
syntax. In the above example, the random module is imported, which contains the
randint function. So by importing random you can call randint with 
`random.randint`.

You can import a module and assign it to a different name:
```python
>>> import random as rn
>>> print(rn.randint(1, 10))
4
```


If your python file main.py is in the __same folder__ as a custom.py. You can 
import it like this:
```python
import custom
```

It is also possible to import a function from a module:
```python
>>> from math import sin
>>> sin(1)
0.8414709848078965
```

To import specific functions deeper down into a module, the dot operator may be
used __only__ on the left side of the `import` keyword.
```python
from urllib.request import urlopen
```

In Python, we have two ways to call function from top level. One is import and
another is from. We should use `import` when we have a possibility of name 
collision. Suppose we have hello.py file and world.py files having same 
function named function. The import statement will work good.
```python
from hello import function
from world import function

function()  # world's function will be invoked. Not hello's
```

In general import will provide you a namespace.
```python
import hello
import world

hello.function()
world.function()
```

But if you are sure enough, in your whole project there is no way having same 
function name you should use `from` statement

Multiple imports can be made on the same line:
```python
# Multiple modules
import time, sockets, random

# Multiple functions
from math import sin, cos, tan

# Multiple constants
from math import pi, e
```

The keywords and syntax shown above can also be used in combinations:
```python
from urllib.request import urlopen as geturl, pathname2url as path2url, getproxies
from math import fatorial as fact, gamma, atan as arctan
import random.randint, time, sys
```



### 43.2 The `__all__` special variable
Modules can have a special variable named `__all__` to restrict what variables
are imported when using `from module import *`

Given the following module:
```python
# mymodule.py
__all__ = ['imported_by_star']

imported_by_star = 42
not_imported_by_star = 21
```

Only `imported_by_star` is imported when using `from module import *`:
```python
>>> from mymodule import *
>>> imported_by_star
42
>>> not_imported_by_star
NameError: name 'not_imported_by_star' is not defined
```

However, `not_imported_by_star` can be imported explicitly:
```python
>>> from mymodule import not_imported_by_star
>>> not_imported_by_star
21
```



### 43.3 Import modules from an arbitrary filesystem location
If you want to import a module that doesn't already exist as a built-in module
in the `Python Standard Library' nor as a side-package, you can do this by
adding the path to the directory where your module is found to `sys.path`. This
may be useful where multiple python environments exist on a host.

```python
import sys
sys.path.append('/path/to/directory/containing/your/module')
import mymodule
```

It is important that you append the path to the `directory` in which `mymodule`
is found, not the path to the module itself.



### 43.4 Importing all names from a module

```
from module_name import *
```

For example:
```python
from math import *
sqrt(2)  # instead of math.sqrt(2)
ceil(2.7)# instead of math.ceil(2.7)
```

This will import all names defined in the math module into the global 
namespace, other than names that begins with an underscore(which indicates that
the writer feels that it is for internal use only).

__Warning__: if a function with the same name was already defined or imported, 
it will be overwritten. Almost always importing only specific names `from math
import sqrt, ceil` is the recommended way.

Starred imports are only allowed at the module level. Attempts to perform them
in class or function definitions result in a `SyntaxError`.



### 43.5 Programmatic importing
To import a module through a function call, use the `importlib` module(included
in Python starting in version 2.7):
```python
import importlib
random = importlib.import_module('random')
```

The `importlib.import_module()` function will also import the submodule of a 
package directly:
```python
>>> collections_abc = importlib.import_module('collections.abc')
```



### 43.6 PEP8 rules for Imports
Some recommended style guidelines for imports



### 43.7 Importing specific names from a module
Instead of  importing the complete module you can import only specified names:
```python
from random import randint  # Syntax "from MODULENAME import 
                            # Name1[, NAME2[, ...]]"
print(randint(1, 10))
```

`from random` is needed, because the python interpreter has to kenow from which
resource it should import a function or class and `import` randint specifies
the function or class itself.

The following example will raise an error, because we haven't imported a module:
```python
random.randrange(1, 10)  # works only if "import random" has been run before
# Outputs:
# NameError: name 'random' is not defined
```

The python interpreter does not understand what you mean with random. It needs 
to be declared by adding `import random` to the example:
```python
import random
random.randrange(1, 10)
```



### 43.8 Importing submodules
```python
from module.submodule import function
```

This imports function from module.submodule



### 43.9 Re-importing a module
When using the interactive, you might want to reload a module. This can be 
useful if you're editing a module and want to import the newest version, or if
you've monkey-patched an element of an existing module and want to revert your
changes.

```python
import math
math.pi = 3
print(math.pi)  # 3
import math
print(math.pi)  # 3
```

This is because the interpreter registers every module you import. And when you
try to reimport a module, the interpreter sees it in the register and does 
nothing. So the hard way to reimport is to use import after removing the 
corresponding item from the register:
```
>>> if 'math' in sys.modules:
...     del sys.modules['math']
... 
>>> print(math.pi)
3
>>> import math
>>> print(math.pi)
3.141592653589793
```

But there is more a straightforward and simple way.

__Python 3__
```
import math
math.pi = 3
print(math.pi)  # 3
from importlib import reload
reload(math)
print(math.pi)  # 3.14159265358973
```



### 43.10 `__import__()` function
The `__import__()` function can be used to import modules where the name is 
only known at runtime
```python
if user_input == 'os':
    os = __import__('os')
# equivalent to import os

# This function can also be used to specify the file path to a module
mod = __import__(r"/path/to/file/anywhere/on/computer/module.py")
```



# Chapter 44: Difference between Module and Package

### 44.1 Modules
A module is a single Python file that can be imported. Using a module looks 
like this:
```python
# module.py
def hi():
    print('Hello world!')
```

```python
# my_script.py
import module
module.hi()
```

in an interpreter
```python
>>> from module import hi
>>> hi()
# Hello world!
```



### 44.2 Packages
A package is made up of multiple Python file(or modules), and can even include
libraries written in C or C++. Instead of being a single file, it is an entire
folder structure which might look like this:

Folder package
- `__init__.py`
- dog.py
- hi.py

`__init__.py`
```python
from package.dog import woof
from package.hi import hi
```

dog.py
```python
def woof():
    print('WOOF!!!')
```

hi.py
```python
def hi():
    print('Hello world!')
```

All Python packages must contain an `__init__.py` file. When you import a 
package in your script(import package), the `__init__.py` script will be run,
giving you access to the all of the functions in the package. In this case, it
allows you to use the `package.hi` and `package.woof` functions.



# Chapter 88: Exceptions
Errors detected during execution are called exceptions and are not 
unconditionally fatal. Most exceptions are not handled by programs; it is
possible to write programs that handle selected exceptions. There are specific
features in Python to deal with exceptions and exception logic. Furthermore,
exceptions have a rich type hierarchy, all inheriting from the BaseException
type.



### 88.1 Catching Exceptions
Use `try...except`: to catch exceptions. You should specify as precise an
exception as you can:
```python
>>> try:
...     x = 5 / 0
... except ZeroDivisionError as e:
...     # `e` is the exception object
...     print("Got a divide by zero! The exception was:", e)
...     # handle exceptional case
...     x = 0
... finally:
...     print("The END")
...     # it runs no matter what execute.
...
Got a divide by zero! The exception was: division by zero
The END
```

The exception class that is specified - in this case, `ZeroDivisionError` - 
catches any exception that is of that class or of any subclass of that 
exception.

For example, `ZeroDivisionError` is a subclass of `ArithmeticError`:
```python
>>> ZeroDivisionError.__bases__
(<class 'ArithmeticError'>,)
```

And so, the following will still catch the `ZeroDivisionError`:
```python
try:
    5 / 0
except ArithmeticError:
    print("Got arithmetic error")

# Got arithmetic error
```



### 88.2 Do not catch everything!
While it's often tempting to catch every Exception:
```python
try:
    very_difficult_function()
except Exception:
    # log / try to reconnect / exit gratiously
finally:
    print('The END')
```

Or even everything(that includes BaseException and all its children including
`Exception`):
```python
try:
    even_more_difficult_function()
except:
    pass # do whatever needed
```

In most cases it's bad practice. It might catch more than intended, such as
`SystemExit, KeyboardInterrupt and MemoryError` - each of which should 
generally be handled differently than usual system or logic errors. It also 
means there's no clear understanding for what the internal code may do wrong
and how to recover properly from that condition. If you're catching every 
error, you won't know what error occured or how to fix it.

This is more commonly referred to as 'bug masking' and should be avoided. Let
your program crash instead of silently failing or even worse, failing at deeper
level of execution.(Imagine it's a transactional system)

Usually these constructs are used at the very outer level of the program, and
wil log the details of the error so that the bug can be fixed, or the error can
be handled more specifically.



### 88.3 Re-raising exceptions
Sometimes you want to catch an exception just to inspect it, e.g. for logging
purposes. After the inspection, you want the exception to continue propagating
as it did before.

In this case, simply use the `raise` statement with no parameters.
```python
>>> try:
...     5 / 0
... except ZeroDivisionError:
...     print("got an error")
...     raise
... 
got an error
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
ZeroDivisionError: division by zero
```

Keep in mind, though, that someone further up in the caller stack can still 
catch the exception and handle it somehow. The done output could be a nuisance
in this case because it will happen in any case(caught or not caught). So it
might be a better idea to raise a different exception, containing your comment
about the situation as well as the original exception:
```python
>>> try:
...     5 / 0
... except ZeroDivisionError as e:
...     raise ZeroDivisionError("Got an error", e)
...
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
ZeroDivisionError: division by zero

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
ZeroDivisionError: ('Got an error', ZeroDivisionError('division by zero',))
```

But this has the drawback of reducing the exception trace to exactly this 
`raise` while the `raise` without argument retains the original exception trace.

In Python3 you can keep the original stack by using the raise-from syntax:
```python
raise ZeroDivisionError("Got an error") from e
```



### 88.4 Catching multiple exceptions



### 88.9 Practical examples of exception handling

__User input__

Imagine you want a user to enter a number via `input`. You want to ensure the
input is a number. You can use `try/except` for this:
```python
while True:
    try:
        nb = int(input('Enter a number'))
        break
    except ValueError:
        print('This is not a number, try again.')
```

If the input could not be converted to an integer, a `ValueError` is raised. 
You can catch it with `except`. If no exception is raised, break jumps out of
the loop. After the loop, `nb` contains an integer.

__Dictionaries__

Imagine you are iterating over a list of consecutive integers, like `range(n)`,
and you have a list of dictionaries `d` that contains information about things
to do when you encounter some particular integers, say skip the `d[i]` next 
ones.

```python
d = [{7: 3}, {25: 9}, {38: 5}]
for i in range(len(d)):
do_stuff(i)
try:
dic = d[i]
i += dic[i]
except KeyError:
i += 1
```

A KeyError will be raised when you try to get a value from a dictionary for a
key that doesn't exist.



### 88.10 Exceptions are Objects too
Exceptions are just regular Python objects that inherit from the built-in 
BaseException. A Python script can use the `raise` statement to interrupt
execution, causing Python to print a stack trace of the call stack at that 
point and a representation of the exception instance. For instance:

```python
>>> def failing_function():
...     raise ValueError('Example error!')
... 
>>> failing_function()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in failing_function
ValueError: Example error!
```

which says that a `ValueError` with the message ' Example error!' was raised by
our `failing_function()`, which was executed in the interpreter.

Calling code can choose to handle any and all types of exception that a call 
can raise:
```python
>>> try:
...     failing_function()
... except ValueError:
...     print('Handled the error')
... 
Handled the error
```

You can get hold of the exception objects by assigning them in the `except...`
part of the exception handling code:
```python
>>> try:
...     failing_function()
... except ValueError as e:
...     print('Caught exception', repr(e))
... 
Caught exception ValueError('Example error!',)
```



### 88.11 Running clean-up code with finally
Sometimes, you may want something to occur regradless of whatever exception
happened, for example, if you have to clean up some resources.

The `finally` block of a `try` clause will happen regradless of whether any
exceptions were raised.
```python
resource = allocate_some_expensive_resource()
try:
    do_stuff(resource)
except SomeException as e:
    log_error(e)
    raise  # re-raise the error
finally:
    free_expensive_resource(resource)
```

This pattern is often better handled with context managers(using the `with` 
statement).



### 88.12 Chain exceptions with raise from
In the process of handling an exception, you may want to raise another 
exception. For example, if you get an `IOError` while reading from a file, you
may want to raise an application-specific error to present to the users of your
library, instead.

You can chain exceptions to show how the handling of exceptions proceeded:
```python
>>> try:
...     5 / 0
... except ZeroDivisionError as e:
...     raise ValueError('Division failed!') from e
... 
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
ZeroDivisionError: division by zero

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
ValueError: Division failed!
```



# Chapter 90: Commonwealth Exceptions
Here in Stack Overflow we often see duplicates talking about the same errors:
"ImportError: No module named '???', SyntaxError: invalid syntax or NameError:
name '???' is not defined". This is an effort to reduce them and to have some
documentation to link to.



### 90.1 Other Errors

__AssertError__

The `assert` statement exists in almost every programming language. When you 
do:

`assert condition`

or:

`assert condition, message`

It's equivalent to this:
```python
if __debug__:
    if not condition: raise AssertionError(message)
```

Assertions can include an optional message, and you can disable them when 
you're done debugging.

Note: the built-in variable debug is True under normal circumstances, False 
when optimization is requested(command line option -O). Assignments to debug
are illegal. The value for the built-in variable is determined when the 
interpreter starts.

__KeyboardInterrupt__

Error raised when the user presses the interrupt key, normally `Ctrl + C or del`

__ZeroDivisionError__



### 90.2 NameError: name '???' is not defined
Is raised when you tried to use a vairable, method or function that is not 
initialized(at least not before). In other words, it is raised when a requested
local or global name is not found. It's possible that you misspelt the name of
the object or forgot to `import` something. Also maybe it's in another scope. 
We'll cover those with separate examples.

- It's simply not defined nowhere in the code

    It's possible that you forgot to initialize it, especially if it is a 
    constant.
    ```python
    foo  # This variable is not defined
    bar()  # This function is not defined
    ```

- Maybe it's defined later
    
    ```python
    baz()

    def baz():
        pass
    ```

- Or it wasn't imported
    ```python
    # needs import math

    def sqrt():
        x = float(input('Value: '))
        return math.sqrt(x)
    ```

- Python scopes and the LEGB Rule
    
    The so-called LEGB Rule talks about the Python scopes. Its name is based on
    the different scopes, ordered by the correspondent priorities:

    `Local -> Enclosed -> Global -> Built-in`

    * Local: Variables not declared global or assigned in a function.
    * Enclosing: Variables defined in a function that is wrapped inside another
        function.
    * Global: Variables declared global, or assigned at the top-level of a file
    * Built-in: Variables preassigned in the built-in names module.

    ```python
    for i in range(5):
        d = i * 2
    print(d)
    ```
    d is accessible because the `for` loop does not mark a new scope, but if it
    did, we would have an error and its behavior would be similar to:
    ```python
    def noaccess():
        for i in range(5):
            d = i * 2
    noaccess()
    print(d)
    ```
    Python says NameError: name 'd' is not defined



### 90.3 TypeError

These exceptions are caused when the type of some object should be different

- TypeError: [definition/method] takes ? positional arguments but ? was given

    A function or method was called with more(or less) arguments than the ones
    it can accept.

    ```python
    >>> def foo(a):
    ...     return a
    ... 
    >>> foo(a, b, c, d)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    NameError: name 'a' is not defined
    >>> foo(1, 2, 3, 4)
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: foo() takes 1 positional argument but 4 were given

    >>> def bar(a, b, c, d): return a+b-c+d
    ...
    >>> bar(1)
    traceback (most recent call last):
      file "<stdin>", line 1, in <module>
    typeerror: bar() missing 3 required positional arguments: 'b', 'c', and 'd'
    ```

    Note: if you want use an unknown number of arguments, you can use 
    `*args or **kwargs`.

- TypeError: unsupported operand type(s) for [operand]: '???' and '???'
    
    Some types cannot be operated together, depending on the operand.

    For example: + is used to concatenate and add, but you can't use any of 
    them for both types. For instance, trying to make a `set` by concatenating
    `set1 and tuple1` gives the error.
    ```python
    >>> set1, tuple1 = {1, 2}, (3, 4)
    >>> a = set1 + tuple1
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: unsupported operand type(s) for +: 'set' and 'tuple'
    ```

    Some types(eg: int and string) use both + but for different things:

    Or they may not be even used for anything
    ```python
    >>> b = 400 + 'foo'
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: unsupported operand type(s) for +: 'int' and 'str'
    >>> c = ["a", "b"] - [1, 2]
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: unsupported operand type(s) for -: 'list' and 'list'
    ```

    But you can for example add a `float` to an `int`:
    ` d = 1 + 1.0`

- TypeError: '???' object is not iterable/subscriptable
    
    For an object ot be iterable it can take sequential indexes starting from
    zero until the indexes are no longer valid and a IndexError is raised(More
    technically: it has to have an `__iter__` method which returns an 
    `__iterator__` or which defines a `__getitem__` method that does what was
    previously mentioned).

    Here we are saying that bar is the zeroth item of 1. Nonsense:
    ```python
    >>> foo = 1
    >>> bar = foo[0]
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'int' object is not subscriptable
    >>> amount = 10
    >>> for x in amount: print(x)
    ...
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'int' object is not iterable
    ```

- TypeError: '???' object is not callable
    
    You are defining a variable and calling it later(like what you do with a 
    function or method)

    ```python
    >>> foo = 'notAFunction'
    >>> foo()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'str' object is not callable
    ```



### 90.4 Syntax Error on good code
The gross majority of the time a SyntaxError which points to an uninteresting 
line means there is an issue on the line before it(in this example, it's a
missing parenthesis):
```python
>>> def my_print():
...     x = (1 + 1
...     print(x)
  File "<stdin>", line 3
    print(x)
        ^
SyntaxError: invalid syntax
```

The most common reason for this issue is mismatched parentheses/brackets, as
the example shows. There is one major caveat for print statements in Python 3:
```python
>>> print "hello world"
  File "<stdin>", line 1
    print "hello world"
                      ^
SyntaxError: Missing parentheses in call to 'print'. Did you mean print("hello world")?
```

Because the print statement was replaced with the print() function



### 90.5 IndentationErrors(or indentation SyntaxErrors)
In most other languages indentation is not compulsory, but in Python(and other
languages: early versions of FORTRAN, Makefiles, Whitespace(esoteric language),
etc.) that is not the case, what can be confusing is you come from another 
language, if you were copying code from an example to your own, or simply if 
you are new.

- IndentationError/SyntaxError: unexpected indent
    
    This exception is raised when the indentation level increases with no 
    reason.

    ```python
    >>> print('This line is ok')
    This line is ok
    >>>     print('This line isn't ok')
      File "<stdin>", line 1
        print('This line isn't ok')
        ^
    IndentationError: unexpected indent
    ```
    ```python
    >>> print('hello')
    hello
    >>>  print('This line isn't ok')
      File "<stdin>", line 1
          print('This line isn't ok')
              ^
    IndentationError: unexpected indent
    ```

- IndentationError/SyntaxError: unindent does not match any outer indentation
    level

    ```python
    >>> def foo():
    ...     print('this should be part of foo()')
    ...    print('Error')
      File "<stdin>", line 3
          print('Error')
                       ^
    IndentationError: unindent does not match any outer indentation level\
    ```

- IndentationError: expected an indented block
    
    After a colon(and then a new line) the indentation level has to increase.
    This error is raised when that didn't happen.
    ```python
    >>> if ok:
    ... pass
      File "<stdin>", line 2
        pass
           ^
    IndentationError: expected an indented block
    ```

- IndentationError: inconsistent use of tabs and spaces in indentation

    ```python
    >>> def foo():
    ...     if ok:
    ...       return "Two != Four != Tab"
    ...         return 'I don't care i do whatever i want'
      File "<stdin>", line 4
          return 'I don't care i do whatever i want'
              ^
    IndentationError: unexpected indent
    ```

    __How to avoid this error
    1. Set your editor to use 4 spaces for indentation
    2. Make a search and replace to replace all tabs with 4 spaces.
    3. Make sure your editor is set to display tabs as 8 spaces, so that you 
        can realize easily that error and fix it.



# Chapter 77: Context Managers("with Statement")
While Python's context managers are widely used, few understand the purpose 
behind their use. These statements, commonly used with reading and writing 
files, assist the application in conserving system memory and improve resource
management by ensuring specific resources are only in use for certain 
processes. This topic explains and demonstrates the use of Python's context 
managers.



### 77.1 Introduction to context managers and the with statement

A context manager is an object that is notified when a context(a block of code)
starts and ends. You commonly use one with the `with` statement. It takes care 
of notifying.

For example, file objects are context managers. When a context ends, the file
object is closed automatically:
```python
open_file = open(filename)
with open_file:
    file_contents = open_file.read()

# the open_file object has automatically been closed.
```

The above example is usually simplified by using the as keyword:
```python
with open(filename) as open_file:
    file_contents = open_file.read()

# the open_file object has automatically been closed.
```

Anything that ends execution of the block causes the context manager's exit
method to be called. This includes exceptions, and can be useful when an error
causes you to prematurely exit from an open file or connection. Exiting a 
script without properly closing files/connections is a bad idea, that may cause
data loss or other problems. By using a context manager you can ensure that
precautions are always taken to prevent damage or loss in this way. This 
feature was added in Python 2.5.



### 77.2 Writing your own context manager
A context manager is any object that implements two magic methods `__enter__() 
and __exit__()` (although it can implement other methods as well)

```python
class AContextManager():
    def __enter__(self):
        print('Entered')
        # optionally return an object
        return "A-instance"

    def __exit__(self, exception_type, exception_value, traceback):
        print("Exited" + (" (with an exception)" if exception_type else ""))
        # return True if you want to suppress the exception
```

If the context exits with an exception, the information about that exception 
will be passed as a triple `exception_type, exception_value, traceback`(these
are the same variables as returned by the `sys.exc_info()` function). If the
context exits normally, all three of these arguments will be None.

If an exception occurs and is passed to the `__exit__`method, the method can
return `True` in order to suppress the exception, or the exception will be 
raised at the end of the `__exit__` function.

```python
with AContextManager() as a:
    print('a is %r' % a)
# Entered
# a is 'A-instance'
# Exited

with AContextManager() as a:
    print('a is %d' % a)
# Entered
# Exited with an exception
# Traceback (most recent call last):
#   File "<stdin>, line 2, in <module>
# TypeError: %d format: a number is required, not str
```

Note that in the second example even though an exception occurs in the middle
of the body of the with-statement, the `__exit__` handler still gets executed,
before the exception propagates to the outer scope.

If you only need an `__exit__` method, you can return the instance of the 
context manager:

```python
class MyContextManager:
    def __enter__(self):
        return self

    def __exit__(self):
        print('something')
```



### 77.3 Writing your own contextmanager using generator syntax
It is also possible to write a context manager using generator syntax thanks to
the `contextlib.contextmanager` decorator:

```python
import contextlib


@contextlib.contextmanager
... def context_manager(num):
...     print('Enter')
...     yield num+1
...     print('Exit')
...
>>> with context_manager(2) as cm:
...     # the following instructions are run when the 'yield' point of the 
...     # context manager is reached.
...     # 'cm' will have the value that was yielded
...     print('Right in the middle with cm = {}'.format(cm))
...
Enter
Right in the middle with cm = 3
Exit
```

The decorator simplifies the task of writing a context manager by converting a
generator into one. Everything before the yield expression becomes the 
`__enter__` method, the value yielded becomes the value returned by the 
generator(which can be bound to a variable in the with statement), and 
everything after the yield expression becomes the `__exit__` method.

If an exception needs to be handled by the context manager, a `try...except...
finally`-block can be written in the generator and any exception raised in the
`with`-block will be handled by this exception block.

```python
>>> @contextlib.contextmanager
... def error_handling_context_manager(num):
...     print('Enter')
...     try:
...         yield num+1
...     except ZeroDivisionError:
...         print("Caught error")
...     finally:
...         print('Cleaning up')
...     print('Exit')
...
>>> with error_handling_context_manager(-1) as cm:
...     print('Dividing by cm = {}'.format(cm))
...     print(2/cm)
...
Enter
Dividing by cm = 0
Caught error
Cleaning up
Exit
```

