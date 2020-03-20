# 1.2 Create variables and  assigning values
```python
a_name = an_object # "a_name" is now **a** name for the reference to the object 
                   # "an_object". an_object can have many names

# Things are a bit different when it comes to **modifying** the mutable objects
x = y = [1, 2, 3]
x[0] = 4
print(y)
# Output: [4, 2, 3]
```

# 1.3 Block Indentation
1. Blocks that contain exactly one single-line statement may be put on the same 
   line, though this form is generally not considered good style:

```python
    if a > b: print(a)
    else: print(b)
```

2. An empty block causes an IndentationError. Use `pass`(a commond that does
   nothing) when you have a block with no content:
```python
def will_be_implemented_later():
    pass
```

# 1.4 Datatypes
| Datatypes |                                     |
|-----------|-------------------------------------|
| boolean   | True False                          |
| integers  | **arbitrary sizes**                 |
| str       | unicode string -- 'hello'           |
| bytes     | byte string -- b'hello'             |
| None      | None is always less than any number |
## Sequences and collections
Python differentiates between orderd sequences and unorderd collections(such as
`set` and `dict`
- strings(`str, bytes`) are sequences 
- reversed: a reversed order of `str` with `reversed` function
    ```
    a = reversed('hello')
    ```
- tuple: An ordered collection of n values of any type(n >= 0)

    ```python
        a = (1, 2, 3)
        b = ('a', 1, 'python', (1, 2))
        b[2] = 'something else' # returns a TypeError
    ```
    Supports indexing; **immutable; hashable if al its members are hashable
- list: An ordered collections of n values
    ```
    a = [1, 2, 3]
    b = ['a', 1, 'python', (1, 2), [1, 2]]
    b[2] = 'something else' # allowed
    ```
    No hashable; mutable.
- set: An unordered collection of unique values. Items must be hashable
    ```
    a = {1, 2, 'a'}
    ```
- dict: An unordered collection of unique key-value **pairs**; keys must be hashable
    ```
    a = {1: 'one', 2: 'two'}
    b = {'a': [1, 2, 3], 'b': 'a string'}
    ```
> An object is hashable if it has a hash value which never changes during its 
> lifetime, and can be compared to other objects. Hashable objects which 
> compare equality must have the same hash value.

## Converting between datatypes
```python
a = '123'
b = int(a)
```
You can also convert sequence or collection types
```
a = 'hello'
b = list(a)
c = set(a)
d = tuple(a)
```
## Explicit string type at definition of literals
With one letter labels just in front of the quotes you can tell what type of 
string you want to define.
```python
byte_strings = b'foo bar' # results `bytes` in python3
unicode_strings = u'foo bar' # results `str` in pyhton3
strings = 'foo bar' # results `str`
raw_strings = r'foo bar' # results so called raw string, where escaping special 
                         # characters is not necessary, everything is taken 
                         # verbatim as you typed**
normal = 'foo\nbar' # foo
                    # bar
escaped = 'foo\\nbar' # foo\nbar
raw = r'foo\nbar' # foo\nbar
```

# 1.5 Collection Types
There are a number of collections types in Python. While types such as `int` and
`str` hold a single value, collection datatypes hold multiple values.

## List
- A list can be empty
- Indices can be negative which means counting from the end of the list(-1 being
    the index of the last element).
- It is possible to add or remove elements from a list:
    `.append(object)` Append object to **end** of the list
    `.insert(index, object) Add a new element to list at a specific index.
    `.remove(value) Remove the **first occurrence** of a **value** 
    `.index(value) Get the index in the list of the first occurrence of a value
    `len(list_name)`
    '.count(value)` Count occurrence of any item in list
    `.reverse()` Reverse the list
    ```
    a = [ 1, 1, 1, 2, 3, 4]
    a.reverse() # output: [4, 3, 2, 1, 1, 1]
    # or
    a[::-1] # output: [4, 3, 2, 1, 1, 1]
    ```
    '.pop([index])` Remove and return item at index(defaults to the last item)
    
## Tuples
A ` tuple` is similar to a list except that it is fixed-length and immutable. So
the values in the tuple cannot be changed nor the values be added to or removed 
from the tuple. Tuples are commonly used for small collections of values that 
will not need to change, such as **IP address** and **Port**.
```python
ip_address = ('192.168.1.100', 8080)
```
- A tuple with **only one** member must be defined(note the comma) this way:
```
one_member_tuple = ('note the comma',)
# or 
one_member_tuple = 'Only member', # No brackets
# or just using `tuple` syntax
one_member_tuple = tuple(['only member'])
```

## Dictionaries
```python
state_capitals = {
    'Arkansas': 'Little Rock',
    'Colorado': 'Denver',
    'California': 'Sacramento',
    'Georgia': 'Atlanta'
}

# To get a value, refer to it by its key:
ca_capital = state_capitals['California']

# You can also get all of the keys in a dictionary and then iterate over them
for k in state_capitals.keys():
    print('{} is the capital of {}'.format(state_capitals[k], k))
```
- Dictionaries strongly resemble JSON syntax.

## Set
A set is a collection of elements with no repeats and without insertion order 
but sorted order. They are used in situations where it is only important that 
some things are grouped together, and not what order they were included. For 
large groups of data, it is much faster to check whether or not an element is 
in a `set` that it is to do the same for a `list`.

```python
# Defining a `set` is very similar to defining a dictionary
first_names = {'Adam', 'Beth', Charlie'}
# Or you can bulid a `set` using an existing `list`:
my_list = [1, 2, 3]
my_set = set(my_list)
# check membership of the `set` using in:
if name in first_names:
    print(name)
```

## Defaultdict
**A defaultdict will never raise a KeyError. Any key that does not exist gets the
default value returned**

Let us try with a defaultdict. It can e found in the collections module.
```python
from collections import defaultdict
state_capitals = defaultdict(lambda: 'Boston')
# What we did here is to set a default value(Boston) in case the given key does
# not exist.
```

# 1.7 User Input
```
name = input('What is your name?') 
``` 
- **type(name): str**

# 1.8 Bulit in Modules and Functions
To check the built in function in python we can use `dir()`. If called without
an argument, return the names in the current scope. Else, return an alphabetized
list of names comprising(some of) the attribute of the given object, and of 
attributes reachable from it.
```python
dir(__builtins__)
```

The `__doc__` is useful to provide some documentation in, say, functions
```
>>> import math
>>> dir(math)
>>> math.__doc__
```
In addition to functions, documentation can also be provided in modules. So, 
if you have a file named **hello_world.py** like this:
```python
'''This is the module docstring.'''

def say_hello():
    '''This is the function docstring.'''
    return 'Hello World'
```

You can access its docstrings like this:
```
>>> import hello_world
>>> hello_world.__doc__
'This is the module docstring'
>>> hello_world.say_hello.__doc__
'This is the function docstring.
```

Any data type can be simply converted to string using a builtin function called 
`str`. This function is called by default when a data type is passed to `print`


# 1.9 Creating a module

If the module is inside a directory and needs to be detected by python, the 
directory should contain a file named `__init__.py`


# 1.11 String function - str() and repr()

- `repr(x)` call `x.__repr__()`: a representation of x. `eval` will usually convert
    the result of this function back to the original object.

- `str(x)` call `x.__str()__:`: a human-readable string that describes the object.
    This may elide some technical detail.

```python
# Example 1:
s = """w'o"w"""
repr(s) # Output: '\'w\\\'o"w\''
str(s) # Output: 'w\'o"w'
eval(str(s)) == s # Gives a SyntaxError
eval(repr(s)) == s # Output: True

# Example 2:
import datetime
today = datetime.datetime.now()
str(today) # '2020-03-19 10:14:25.614767'
repr(today) # 'datetime.datetime(2020, 3, 19, 10, 14, 25, 614767)'

class Represent(object):
    def __init__(self, x, y):
        self.x, self.y = x, y

    def __repr__(self):
        return "Represent(x={}, y=\"{}\")".format(self.x, self.y)

    def __str__(self): # overwrite the __str__ function
        return "Represent x as {} and y as {}".format(self.x, self.y)
```

# 1.12 Installing external modules using pip

## Finding/Installing a package
Searching for a package is as sample as typing
```bash
pip search <query>
# Searches for packages whose name or symmary contains <query>
```

Installing a package is as simple as typing
```bash
pip install [package_name]            # latest version of the package
pip install [package_name]==x.x.x     # specific version of the package
pip install [package_name]>=x.x.x     # minimum version of the package
```
Where `x.x.x` is the version number of the package you want to install.

## Upgrading installed packages
When new versions of installed packages appear they are not automatically 
installed to your system. To get an overview of which of your installed
packages have become outdated, run:
```bash
pip list --outdated
```

To upgrade a specific package, use
```bash
pip install [package_name] --upgrade
```

Updating all outdated packages is not a standard functionality of pip.

## Upgrading pip
You can upgrade your existing pip installation by using the following commands:
- On Linux or macOS x:
    ```bash
    pip install -U pip
    ```
- On windows:
    ```
    py -m pip install -U pip
    or
    python -m pip install -U pip
    ```

# Chapter 2: Python Data Types
Data types are nothing but variables you use to reserve some space in memory.
Python variables do not need an explicit declaration to reverse memory space.
The declaration happens automatically when you assign a value to a variable.

# 2.1 String Data Type
Strings are **immutable** sequence data type, i.e. each time one makes any changes
to a string, completely new sring object is created.

# 2.2 Set Data Types
Sets are unordered collections of **unique** objects, there are two types of set:
1. Sets-They are **mutable** and new elements can be added once sets are defined
2. Frozen Sets - They are **immutable** and new elements cannot be added after its
    defined.
```python
b = frozenset('asdfagsa')
print(b) #Output: frozenset({'f', 'g', 'd', 'a', 's'})
```

# 2.3 Numbers Data Type
Numbers ahve four types in Python. **Int, float, complex and long.**
```python
int_num = 12
float_num = 10.2
complex_num = 3.14j
long_num = 1234567L
```

# 2.4 List Data Type
A list contains items separated by commas and enclosed within square brackets[].
Lists are almost similar to arrays in C. One difference is that all the items
belonging to a list can be of different data type.

# 2.5 Dictionary Data Type
Dictionary consists of key-value pairs. It is enclosed by curly braces{} and 
values can be assiged and accessed using square brackets[].
```python
dic = {'name': 'red', 'age': 18}
print(dic)
print(dic['name'])
print(dic.values())
print(dic.keys())
```

# 2.6 Tuple Data Type
Lists are enclosed with square brackets[] and their elements and size can be 
changed, while tuples enclosed in parentheses() and connot be updated. Tuple
are **immutable.**

# Chapter 3: Indentation

# Chapter 4: Comments and Documentation

# 4.1 Single line, inline and multiline comments

# 4.2 Programmatically accessing docstrings
**Docstrings are -unlike regular comments-stored as an attribute of the function**
**they document, meaning that you can access them programmatically.**
```python
def func():
    '''This is a function that does nothing at all'''
    return
```
The docstring can be accessed using the `__doc__` attribute:
```python
print(func.__doc__)
# Output: This is a function that does nothing at all
```

# 4.3 Write documentation using docstrings
A `docstring` is a **multi-line** comment used to document modules, classes, functions
and methods. It has to be the **first statement** of the component it describes.

 **PEP 257** defines a syntax standard for docstring comments. It basically allows
two types:
1. One-line Docstrings:
```python
def hello():
    '''Say hello to your friends.'''
    print('hello my friends!')
```
2. Multi-line Docstrings:
```python
def hello(name, language='en'):
    '''Say hello to a person.

    Arguments:
    name: the name of the person
    language: the language in which the person should be greeted
    '''

    print(greeting[language] + ' ' + name)
```

**Sphinx** 
`Sphinx` is a tool to generate HTML based documentation for Python projects based 
on docstrings.
```python
def hello(name, language='en'):
    '''Say hello to a person.

    :param name: the name of the person 
    :type name: str
    :param language: the language in which the person should be greeted
    :type language: str
    :return: a number
    :rtype: int
    '''

    print(greeting[language] + ' ' + name)
    return 4
```

**Google Python Style Guide**
```python
def hello(name, language='en'):
    '''Say hello to a person.

    Args:
        name: the name of the person 
        language: the language in which the person should be greeted
        type language: str

    Returns: 
        A number.
    '''

    print(greeting[language] + ' ' + name)
    return 4
```

# Chapter 5: Date and Time

# 5.1 Parsing a string into a **timezone** aware datetime object
```python
import datetime
dt = datetime.datetime.strptime('2020-03-20T16:31:18-0500', '%Y-%m-%dT%H:%M:%S%z')
# The `dt` variable is now a `datetime` onjcet with the folowing value:
datetime.datetime(2020, 3, 20, 16, 31, 18, 
    tzinfo=datetime.timezone(datetime.timedelta(-1, 68400)))
```

# 5.2 Constructing timezone-aware datetimes
By default all datetime objects are naive. To make them timezone-aware, you must 
attach a `tzinfo` object, which provides the UTC offset and timezone abbreviation
as a function of date and time.

## Fixed Offset Time Zones
For time zones that are a fixed offset from UTC, in Python3.2+, the `datetime` 
module provides the timezone class, a concrete implementation of tzinfo, which
takes a timedelta and an(optional) name paremeter:


# Decorators
- commonly used in frameworks

## snippet
```python
def logger(func):
    def wrapper():
        print('Logging execution')
        func()
        print('Done logging')
    return wrapper

@logger
def sample():
    print('-- Inside sample function')

sample()
```
## output
>Logging execution</br>
>-- Inside sample function</br>
>Done logging


## Pytorch Issues
1. what is .detach() ?
