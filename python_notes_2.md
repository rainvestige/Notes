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
