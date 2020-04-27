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
> Modules: datetime, dateutil, pytz

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

## Fixed Offset **Time Zones**
For time zones that are a fixed offset from UTC, in Python3.2+, the `datetime` 
module provides the timezone class, a concrete implementation of tzinfo, which
takes a timedelta and an(optional) name paremeter:

```python
from datetime import datetime, timedelta, timezone
CCT = timezone(timedelta(hours=+8)) # china 东八区

dt = datetime(2020, 3, 21, 10, 27, 0, tzinfo=CCT)
print(dt)
# 2020-03-21 10:27:00+08:00

print(dt.tzname())
# UTC+08:00

# JST: japan 东九区
dt = datetime(2020, 3, 21, 10, 27, 00, tzinfo=timezone(timedelta(hours=9), 'JST'))
print(dt.tzname())
# JST
```

不同的方法构建时区对象(timezone object)

```python 
from datetime import datetime, timedelta
from dateutil import tz

CCT = tz.tzoffset('CCT', 8 * 3600)
dt = datetime(2020, 3, 21, 11, 14, tzinfo=CCT)
print(dt)
# 2020-03-21 11:14:00+08:00
print(dt.tzname())
# CCT
```

## Zones with daylight savings time
For zones with daylight savings time, python standard libraries do not provide
a standard class, so it is necessary to use a third party library. `pytz` and
`dateutil` are popular libraries provide timezone classes.

```python
from datetime import datetime
from dateutil import tz
local = tz.gettz() # local time
PT = tz.gettz('US/Pacific') #Pacific time

dt_1 = datetime(2020, 3, 21, 12, tzinfo=local)
dt_pst = datetime(2020, 3, 21, 12, tzinfo=PT)
dt_pdt = datetime(2020, 7, 21, 12, tzinfo=PT)
print(dt_1)
# 2020-03-21 12:00:00+08:000
print(dt_pst)
print(dt_pdt)
```

All edge cases are handled properly when using `pytz`, but `pytz` time zones
should not be directly attached to time zones through the constructor. Instead,
a `pytz` time zone should be attached using the time zone's localize method:

```python
from datetime import datetime, timedelta
import pytz

PT = pytz.timezone('US/Pacific')
dt_pst = PT.localize(datetime(2020, 3, 21, 12))
dt_pdt = PT.localize(datetime(2020, 6, 21, 0, 30))

print(dt_pst)
print(dt_pdt)

# Be aware that if you perform datetime arithmetic on a pytz-aware time zone,
# you must either perform the calculations in UTC(if you want absolute elapsed 
# time), or you must call `normalize()` on the result.

dt_new = dt_pdt + timedelta(hours=3)
print(dt_new)

dt_corrected = PT.normalize(dt_new)
print(dt_corrected)
```

# 5.3 Computing time differences
The `timedelta` module comes in handy to compute differences between times:

```python
from datetime import datetime, timedelta
now = datetime.now()
then = datetime(2020, 3, 21)

delta = now - then
# delta is of type `timedelta`
print(delta.days)

print(delta.seconds)

print(delta.microseconds)
```

To get n days after and n days before date we could use:
```python
def get_n_days_after_date(date_format='%d %B %Y', add_days=120):
    date_n_days_after = datetime.datetime.now() + timedelta(days=add_days)
    return date_n_days_after.strftime(date_format)


def get_n_days_before_date(date_format='%d %B %Y', days_before=120):
    date_n_days_before = datetime.datetime.now() - timedelta(days=days_before)
    return date_n_days_before.strftime(date_format)
```

# 5.4 Basic datetime objects usage
The datetime module contains three primary types of objects - date, time, and datetime

```
import datetime

# Date object
today = datetime.date.today()
new_year = datetime.date(2020, 01, 01)

# Time oject
noon = datetime.time(12, 0, 0)

# Current datetime
now = datetime.datetime.now()

# Datetime object
millenium_turn = datetime.datetime(2000, 1, 1, 0, 0, 0)
```

Arithmetic operations for these objects are only supported within same datetype
and performing simple arithmetic with instances of different types will result
in a TypeError.

# 5.5 Switching between time zones
To switch between time zones, you need datetime objects that are timezone-aware.

```python
from datetime import datetime
from dateutil import tz

utc = tz.tzutc()
local = tz.tzlocal()

utc_now = datetime.utcnow() # Not timezone-aware

utc_now = utc_now.replace(tzinfo=utc)
utc_now # Timezone-aware

local_now = utc_now.astimezone(local)
local_now # Converted to local time
```

# 5.6 Simple date arithmetic

```python
import datetime
today = datetime.date.today()

yesterday = today - datetime.timedelta(days=1)

```

# 5.7 Converting timestamp to datetime
The datetime module can convert a POSIX timestamp to a ITC datetime object.

The Epoch is January 1st, 1970 midnight.
```python
import time
from datetime import datetime
seconds_since_epoch = time.time() # timestamp?

utc_date = datetime.utcfromtimestamp(seconds_since_epoch)
# daatetime.datetime(2020, 3, 21, 9, 13, 46, 984290)
```

# 5.8 Subtracting months from a date accurately
Using the `calendar` module

```python
import calendar
from datetime import date

def monthdelta(date, delta):
    m, y = (date.month + delta) % 12, date.year + ((date.month) + delta - 1) // 12
    if not m: m = 12
    d = min(date.day, calendar.monthrange(y, m)[1])
    return date.replace(day = d, month = m, year = y)

next_month = monthdelta(date.today(), 1)

# Using the `dateutils` module
import datetime
import dateutil.relative delta

d = datetime.datetime.strptime('2020-03-31', '%Y-%m-$d')
d2 = d = dateutil.relativedelta.relativedelta(months=1)
# datetime.datetime(2020, 2, 29, 0, 0)
```

# 5.9 Parsing an arbitrary ISO 8601 timestamp with minimal libraries
Python has only limited support for parsing ISO 8601 timestamps. For strptime
you need to know exactly what format it is in. As a complication the 
stringification of a datetime is an ISO 8601 timestamp, with space as a separator
and 6 digit fraction:

```python
str(datetime.datetime(2020, 3, 22, 14, 18, 59, 555555))
# '2020-03-22 14:18:59.555555'
```

# 5.10 Get an ISO 8601 timestamp

## Without timezone, with microseconds
```python
from datetime import datetime

datetime.now().isoformat()
# '2020-03-22T14:21:27.846723'
```

## With timezone, with microseconds
```python
from datetime import datetime
from dateutil.tz import tzlocal

datetime.now(tzlocal()).isoformat()
# '2020-03-22T14:23:51.203451+08:00'
```

## With timezone, without microseconds
```python
from datetime import datetime
from dateutil.tz import tzlocal

datetime.now(tzlocal()).replace(microsecond=0).isoformat()
# '2020-03-22T14:26:07+08:00'
```

# 5.11 Parsing a string with a short time zone name into a timezone aware datetime object
For dates formatted with shorttime zone names or abbreviations, which are 
generally ambiguous or not necessarily available in standard database, it is
necessary to specify a mapping between time zone abbreviation and tzinfo object.

```python
from dateutil import tz
from dateutil.parser import parse

ET = tz.gettz('US/Rastern')
CT = tz.gettz('US/Central')
MT = tz.gettz('US/Mountain')
PT = tz.gettz('US/Pacific')

us_tzinfos = {
    'CST': CT, 'CDT': CT,
    'EST': ET, 'EDT': ET,
    'MST': MT, 'MDT': MT,
    'PST': PT, 'PDT': PT
}

dt_est = parse('2014-01-02 04:00:00 EST', tzinfos=us_tzinfos)
# datetime.datetime(2014, 1, 2, 4, 0, tzinfo=tzfile('usr/share/zoneinfo/US/Eastern')
dt_pst = parse('2014-01-02 04:00:00 PST', tzinfos=us_tzinfos)
```

# 5.12 Fuzzy datetime parsing(extracting datetime out of a text)
It is possible to extract a date out of a text using the `dateutil parser` in a 
`fuzzy` mode, where components of the string not recognized as being part of a 
date are ignored.
```python
from dateutil.parser import parse

dt = parse("Today is March 21, 2020 at 15:16 PM", fuzzy=True)
```

# 5.13 Iterate over dates
Sometimes you want to iterate over a range of dates from a start date to some
end date. You can do it using `datetime` library and `timedelta` object.
```python
from datetime import date,timedelta

# The size of each step in days
day_delta = timedelta(days=1)

start_date = date.today()
end_date = start_date + 7 * day_delta

for i in range((end_date - start_date).days):
    print(start_date + i*date_delta)
```


# Chapter 6: Date Formatting

# 6.1 Time between two date-times

```python
from datetime import datetime

a = datetime(2020, 3, 22, 0, 0, 0)
b = datetime(2020, 3, 11, 23, 59, 59)

a-b
(a-b).days
(a-b).total_seconds()
```

# 6.2 Outputting datetime object to string

```python
from datetime import datetime
datetime_for_string = datetime(2020, 3, 22, 0, 0)
date_string_format = '%b %d %Y, %H:%M:%S'
datetime.strftime(datetime_for_string, datetime_string_format)  # return a string
```

# 6.3 Parsing string to datetime object

```python
from datetime import datetime
datetime_string = 'Oct 1 2020, 10:23:43'
datetime_string_format = '%b %d %Y, %H:%M:%S'  # the format must match the datetime_string
datetime.strptime(datetime_string, datetime_string_format)
```


# Chapter 7: Enum

# 7.1 Creating an enum
Enums have been backported() from Python 3.4 to Python 2.4 through Python 3.3

```bash
pip install enum34
```

```python
from enum import Enum

class Color(Enum):
    red = 1
    green = 2
    blue = 3

print(Color.red)
print(Color(1))
print(Color['red'])
```

# 7.2 Iteration
Enums are iterable
```python
[c for c in Color] # [<Color.red: 1>, <Color.green: 2 >, <Color.blue: 3 >]
```


# Chapter 8: Set

# 8.1 Operation on sets

## with other sets
```python
# Intersection
{1, 2, 3, 4}.intersection({3, 4, 5})  # {3, 4}
{1, 2, 3, 4} & {3, 4, 5}

# Union
{1, 2, 3, 4}.union({3, 4, 5})  # {1, 2, 3, 4, 5}
{1, 2, 3, 4} | {3, 4, 5}

# Difference
{1, 2, 3, 4}.difference({3, 4, 5})  # {1, 2}
{1, 2, 3, 4} - {3, 4, 5}            # {1, 2}

# symmetric difference with
{1, 2, 3, 4}.symmetric_difference({3, 4, 5})  # {1, 2, 5}
{1, 2, 3, 4} ^ {3, 4, 5}            # {1, 2, 5}

# Superset check
{1, 2}.issuperset({1, 2, 3})  # False
{1, 2} >= {1, 2, 3}           # False

# Subset check
{1, 2}.issubset({1, 2, 3})  # True
{1, 2} <= {1, 2, 3}         # True

# Disjoint check
{1, 2}.isdisjoint({3, 4})  # True
{1, 2}.isdisjoint({1, 4})  # False
```

# with single elements
```python
# Existence check
2 in {1, 2, 3}  # True
4 in {1, 2, 3}  # False
4 not in {1, 2, 3}  # True

# Add and Remove
s = {1, 2, 3}
s.add(4)  # s == {1, 2, 3, 4}

s.discard(3)  # s == {1, 2, 4}
s.discard(5)  # s == {1, 2, 4}

s.remove(2)   # s == {1, 4}
s.remove(2)   # KeyError!
```

| method               | in-place operation | in-place method             |
|----------------------|--------------------|-----------------------------|
| union                | s \|=t             | update                      |
| intersection         | s &= t             | intersection_update
| difference           | s -= t             | difference_update           |
| symmetric_difference | s ^= t             | symmetric_difference_update |

For example:
```python
s = {1, 2}
s.update({3, 4})  # s == {1, 2, 3, 4}
```

# 8.2 Get the unique elements of a list
Let's say you've got a list of restaurants -- maybe you read it from a file.
You care about the unique restaurants in the list. The best way to get the unique
elements from a list is to turn it into a set:
```python
restaurants = ["McDonald's", "Burger King", "McDonald's", "Chicken Chicken"]
unique_restaurants = set(restaurants)
```
Note that the set is not **in the same order** as the original list; that is 
because sets are **unordered**, just like `dict`.

# 8.3 Set of Sets
`{1, 2}, {3, 4}}`

leads to:

`TypeError: unhashable type: 'set'`

Instead, use `frozenset`:

`{frozenset({1, 2}), frozenset({3, 4})}`

# 8.4 Set Operations using Methods and Builtins
the same as 8.1, the only difference is replace the {1,2,...} with the variables

# 8.5 Sets versus multisets
Sets are unordered collections of distinct elements. But sometimes we want to 
work with unordered collections of elements that are not necessarily distinct
and keep track of the elements's multiplicities. List object can do this, but 
a list data structure introduces an extra unneeded ordering that will slow down
our our computations.

For implementing multisets Python provides the Counter class from the `collections`
module(starting from version 2.7)
```python
from collections import Counter
counterA = Counter(['a', 'b', 'b', 'c'])  # Counter({'b': 2, 'a': 1, 'c': 1})
```
Counter is a dictionary where elements are stored as dictionary keys and their
counts are stored as dictionary values. And as all dictionaries, it is an 
unordered collection.


# Chapter 9: Simple Mathematical Operators

# 9.1 Division
Python does integer division when both operands are integers. The behavior of
Python's division operators have changed from python 2.x and 3.x
```python
a, b, c, d, e = 3, 2, 2.0, -3, 10

a / b  # = 1
a / c  # = 1.5
d / b  # = -2
b / a  # = 0
d / e  # = -1o
```

What if you want float division:
```python
from __future__ import division  # apply Python3 style division to the entire module
a / b   # 1.5
a // b  # 1

# In Python 3 the / operator performs `true` division regardless of types. The // 
operator performs floor division and maintains type.

a / b  # 1.5
e / b  # 5.0

a // b # 1
a // c # 1.0
```

# 9.2 Addition
```python
a, b = 1, 2
a + b  # = 3
a += b

import operator
operator.add(a, b)
operator.iadd(a, b)   # The '+=' operator is equivalent to
```
Note: the `+` operator is also used for concatenating strings, lists and tuples:
```
"first_string" + "second string"  
[1, 2, 3] + [4, 5, 6]
```

# 9.3 Exponentiation
```python
a, b = 2, 3
(a ** b)
pow(a, b)

import math
math.pow(a, b)

import operator
operator.pow(a, b)

# Another difference between the built-in pow and math.pow is that the built-in
# pow can accept three arguments:
a , b, c = 2, 3, 2

pow(2, 3, 2)  # 0, calculates (2 ** 3) % 2
```

## Special functions

```python
import math
import cmath  # complex math?

c = 4
math.sqrt(c)   # = 2.0 (always float; does not allow complex results)
cmath.sqrt(c)  # = (2 + 0j) (always complex)

x = 8
math.pow(x, 1/3)
x ** (1/3)
```
The function math.exp(x) computes `e ** x`.
The function math.expm1(x) computes `e ** x - 1`. When x is samll, this gives 
significantly better precision than `math.exp(x) - 1`

```python
math.exp(0)  # = 1
math.exp(1)  # = 2.71828(e)
```

# 9.4 Trigonometric Functions
```python
a, b = 1, 2

import math

math.sin(a)  # returns the sine of 'a' in radians

math.cosh(b) # returns the inverse hyperbolic cosine of 'b' in radians

math.atan(math.pi)  # returns the arc tangent of 'pi' in radians

math.hypot(a, b)  # returns the **Euclidean norm**, same as math.sqrt(a*a, b*b)
```

To convert from radians->degrees and degrees->radians respectively use 
`math.degrees` and `math.radians`

```python
math.degrees(a)
# Out: 57.29577951308232

math.radians(57.29577951308232)
# Out: 1.0
```

# 9.5 Inplace Operations
It is common within applications to need to have code like this:
```python
a = a + 1
# or
a = a * 2
```
There is an effective shortcut for these in place operations:
```python
a += 1
a *= 2
```
Any mathematic operator can be used before the '=' character to make an inplace
operation:

| Operators | Descriptions                                 |
|-----------|----------------------------------------------|
| -=        | decrement the variable in place              |
| //=       | floor divide the variable in place # Python3 |
| **=       | raise to a power in place                    |

# 9.6 Subtraction

# 9.7 Multiplication
```python
import operator
operator.mul(2, 3)  # =6
```
Note: The * operator is also used for repeated concatenation of strings, list, 
and tuples.
```python
3 * 'ab'  # = 'ababab'
3 * ('a', 'b')  # = ('a', 'b', 'a', 'b', 'a', 'b')
```

# 9.8 Logarithms
By default, the `math.log` calculates the logaritm of a number, base e. You can
optionally specify a base as the second argument.
```python
import math
import cmath

math.log(5)         # = ln(5) = 1.6094379124341003
# optional base argument. Default is math.e

math.log(5, math.e) # = ln(5) = 1.6094379124341003
cmath.log(5)        # = (1.6094379124341003 + 0j)

math.log(1000, 10)  # = 3.0 (always return float)
```

Special variations of the `math.log` function exist for different bases.
```python
# Logarithm base e - 1(higher precision for low values)
math.log1p(5)       # = 1.791759469228055

math.log2(8)        # = 3.0
math.log10(1000)    # = 3.0
```

# 9.9 Modulus
```python
3 % 4   # = 3
10 % 2  # = 0
6 % 4   # = 2

# Or by usingi the operator module:
import operator
operator.mod(3, 4)  # = 3

# negative numbers (floor divide 向下取整，向负无穷方向取最接近精确值的整数)
-9 % 7  # = 5
9 % -7  # = -5
-9 & -7 # = -2

# If you need to find the result of integer division and modulus, you can use
# the `divmod` function as a shortcut:

quotient, remainder = divmod(9, 4)
# quotient = 2, remainder = 1
```

# Chapter 10: Bitwise Operators

# 10.1 Bitwise Not
The `~` operator will flip all of the bits in the number. Since computers use
`signed number representations`--most notably, the `two's complement notation`
to encode negative binary numbers where negative numbers are written with a 
leading one(1) instead of a leading zero(0).

In general, though, this mean ~n = -n - 1
```python
# 0 = 0b0000 0000
~0  # Out: -1
# -1 = 0b1111 1111

# -1 = 0b1000 0001
~-1  # Out: 0 
```

#10.2 Bitwise XOR(Exclusive OR)
The ^ operator will perform a binary XOR in which a binary 1 is copied if and 
only if it is the value of exactly one operand.
```python
# 60 = 0b111100
# 30 = 0b011110
60 ^ 30  # Out: 34
# 34 = 0b100010

bin(60 ^ 30)
# Out: 0b100010
```

# 10.3 Bitwise AND
The & operator will perform a binary AND, where a bit is copied if it exists in
both operands.

```python
60 & 30
# Out: 28
# 28 = 0b11100
```

# 10.4 Bitwise OR
The | operator will perform a binary "or", where a bit is copied if it exists 
in either operand.

# 10.5 Bitwise Left Shift
The << operator will perform a bitwise "left shift", where the left operand's
value is moved left by the number of bits given by the right operand.
```python
# 2 = 0b10
2 << 2
# Out: 8
# 8 = 0b1000
```

# 10.6 Bitwise Right Shift
The >> operator...

# 10.7 Inplace Operations
All of the Bitwise operators (except ~) have their own in place versions.

# Chapter 11: Boolean Operators

# 11.1 `and` and `or` are not guaranteed to return a boolean

# 11.2 A simple example
In python you can compare a single element using two binary operators--one on
either side
```python
if 3.14 < x < 3.142:
    print('x is near pi')
```
In many(most?) programming languages, this would be evaluated in a way contrary
to regular math: (3.14 < x) < 3.142, but in Python it is treated like 3.14 < x
and x < 3.142, just like most non-programmers would expect.

# 11.3 Short-circuit evaluation
Python minimally evaluates Boolean expressions
```
>>> def true_func():
...  print("true_func()")
...  return True
...
>>> def false_func():
...  print("false_func()")
...  return False
...
>>> true_func() or false_func()
true_func()
True
>>> false_func() or true_func()
false_func()
true_func()
True
>>> true_func() and false_func()
true_func()
false_func()
False
```

# 11.4 and
```
x = 1
y = 1
z = x and y  # z = y, so z = 1, see `and` and `or` are not guaranteed to be boolean
```

# 11.5 or
```
x = 1
y = 1
z = x or y  # z = x, so z = 1, see `and` and `or` are not guaranteed to be boolean
```

# 11.6 not


# Chapter 12: Operator Precedence
Python operators have a set order of precedence, which determines what operators
are evaluated ﬁrst in a potentially ambiguous expression. For instance, in the 
expression 3 * 2 + 7, ﬁrst 3 is multiplied by 2, and then the result is added 
to 7, yielding 13. The expression is not evaluated the other way around, because
`*` has a higher precedence than `+`.

Below is a list of operators by precedence, and a brief description of what they (usually) do.

# Section 12.1: Simple Operator Precedence Examples in python
```python
a, b ,c ,d = 2, 3, 5, 7
a ** (b + c)  # parentheses = 256
a * b ** c  # exponent: same as `a * (b ** c)` = 7776
```

Mathematical rules hold, but not always
```
300 / 300 * 200  # = 200.0
300 * 200 / 300  # = 200.0

1e300 / 1e300 * 1e200  # = 1e+200
1e300 * 1e200 / 1e300  # = inf
```


# Chapter 13: Variable Scope and Binding

# 13.1 Nonlocal Variables
Python 3 added a new keyword called `nonlocal`. The nonlocal keyword adds a 
scope override to the inner scope. This is best illustrated with a couple of 
code examples. One of the most common examples is to create function that can
increment:
```python
def counter():
    num = 0
    def incrementer():
        num += 1
        return num
    return incrementer
```
If you try running this code, you will receive an `UnboudLocalError` because
the `num` variable is referenced before it is assigned in the innermost 
function. Let's add nonlocal to the mix:
```python
def counter():
    nonlocal num
    num = 0
    def incrementer():
        num += 1
        return num
    return incrementer

c = counter()
c()  # = 1
c()  # = 2
c()  # = 3
```
Basically `nonlocal` will allow you to assign to variables in an outer scope,
but not a global scope. So you can't use nonlocal in out counter function
because then it would try to assign to a global scope. Instead you must use 
nonlocal in a **nested function**

# 13.2 Global Variables
In Python, variables inside functions are considered local if and only if
they appear in the left side of an assignment statement, or some other binding
occurrence; otherwise such a binding is looked up in enclosing functions, up to
the global scope. This is true even if the assignment statement is never 
executed.

Normally, an assignment inside a scope will shadow any outer variables of the
same name:
```python
x = 'Hi'

def change_local_x():
    x = 'Bye'
    print(x)

change_local_x()  # Bye
print(x)  # Hi
```

Declaring a name global means that, for the rest of the scope, any assignments
to the name will happen at the module's top level:
```python
x = 'Hi'

def change_local_x():
    global x
    x = 'Bye'
    print(x)

change_local_x()  # Bye
print(x)  # Bye
```
The `global` keyword means that assignments will happen at the module's top 
level, not at the program's top level. Other modules will still need the usual
dotted access to variables within the module.

To summarize: in order to know whether a variable x is local to a function, you
should read the entire function:
1. If you've found `global` x, then x is a global variable
2. If you've found `nonlocal` x, then x belongs to an enclosing function, and 
    is neither local nor global
3. If you've found x =5 or for x in range(3) or some other binding, then x is a
    local variable
4. Otherwise x belongs to some enclosing scope(functio scope, global scope, or 
    builtins)

# 13.3 Local Variables
If a name is _bound_ inside a function, it is by default accessible only within
the function:

Control flow constructs have **no impact** on the scope(with the exception of 
`except`), but accessing variable that was not assigned yet is an error:

```python
def foo():
    if True:
        a = 5
    print(a) # ok
b = 3
def bar():
    if False:
        b = 5
    print(b) # UnboundLocalError: local variable 'b' referenced before assignment
```
Common binding operations are assignments, for loops, and augmented assignments 
such as a += 5

# 13.4 The del command
The command has several related yet distinct forms.

`del v`

If v is a variable, the command `del v` removes the variable from its scope. 
For example:
```python
x = 5
print(x) # out: 5
del x
print(x) # NameError: name 'x' is not defined
```
Note that `del` is a binding occurrence, which means that unless explicitly 
stated otherwise(using nonlocal or global), del v will make v local to the 
current scope. If you intend to delete v in an outer scope, use `nonlocal v` or
`global v` in the same scope of the `del v` statement


# 13.5 Functions skip class scope when looking up names
Classes have a local scope during definition, but functions inside the class do
not use that scope when looking up names. Because lambdas are functions, and
comprehensions are implemented using function scope, this can lead to some
surprising behavior.
```python
a = 'global'
class Fred:
    a = 'class' # class scope
    b = (a for i in range(10)) # function scope
    c = [a for i in range(10)] # function scope
    d = a # class scope
    e = lambda: a # function scope
    f = lambda a=a: a # default argument uses class scope

    @staticmethod # or @classmethod, or regular instance method
    def g(): # function scope
        return a
print(Fred.a) # class
print(next(Fred.b)) # global
print(Fred.c[0]) # class in Python 2, global in Python 3
print(Fred.d) # class
print(Fred.e()) # global
print(Fred.f()) # class
print(Fred.g()) # global
```
Users unfamiliar with how this scope works might expect b , c , and e to print class .

# 13.6 Local vs Global Scope
1. What are local and global scope?

All Python variables which are accessible at some point in code are either in
_local_ scope or in _global_ scope.

The explanation is that local scope includes all variables defined in the 
current function and global scope includes variables defined outside of the
current function.

One can inspect which variables are in which scope, Built-in functions `locals()`
and `globals()` return the whole scopes as dictionaries.


2. The scope is defined for the whole body of the function!
What it means is that a variable will never be global for a half of the function
and local afterwards, or vice-versa.
```python
foo = 1
def func():
    print(foo)  # raises UnboundLocalError, because local foo is not yet initialized
    foo = 3
    print(foo)
```

3. Functions within functions
There are many levels of functions nested within functions, but within any one 
function there is only one local scope for that function and the global scope.
There are no intermediate scopes.
```python
foo = 1
def f1():
    bar = 1

    def f2():
        baz = 2
        # here, foo is a global variable, baz is a local variable
        # bar is not in either scope
        print(locals().keys()) # ['baz']
        print('bar' in locals()) # False
        print('bar' in globals()) # False

    def f3():
        baz = 3
        print(bar) # bar from f1 is referenced so it **enters** local scope of f3 (closure)
        print(locals().keys()) # ['bar', 'baz']
        print('bar' in locals()) # True
        print('bar' in globals()) # False

    def f4():
        bar = 4 # a new local bar which hides bar from local scope of f1
        baz = 4
        print(bar)
        print(locals().keys()) # ['bar', 'baz']
        print('bar' in locals()) # True
```

4. global vs nonlocal(python3 only)
Both these keywords are used to gain write access to the vars which are not local
to the current functions.

# 13.7 Binding Occurrence


# Chapter 14: Conditions

# 14.1 Conditional Expression(or "The Ternary Operator")
The ternary operator is used for inline conditional expressions. It is best used
in simple, concise operators that are easily read.

-   The order of the arguments is different from many other languages, which
    may lead to bugs when people unfamiliar with Python's suprising behavior use
    it(they may reverse the order)
```python
n = 5
'Greater than 2' if n > 2 else 'Smaller than or equal to 2'

```

# 14.2 if, elif, and else
In Python you can define a series of conditionals using if for the first one, 
elif for the rest, up until the final (optional) else for anything not caught
by the other conditionals.

Using `else if` instead of `elif` will trigger a syntax error and is not allowed.


# 14.3 Truth Values
The following values are considered falsey, in that they evaluate to False when
applied to a boolean operator.
- None
- False
- 0, or any numerical value equivalent to zero, for example 0L, 0.0, 0j
- Empty sequence: '', "", (), []
- Empty mappings: {}
- User-defined types where the `__bool__` or `__len__` methods return 0 or False.

Note: A common mistake is to simply chech for the Falseness of an operation which
returns different Falsey values where the difference matters. For example, using
`if foo()` rather than the more explicit `if foo() is None`

# 14.4 Boolean Logic Expressions
Boolean logic expressions, in addition to evaluating to `True` or `False`, return
the value that was interpreted as `True` or `False`. It is Pythonic way to 
represent logic that might otherwise require an `if-else` test.

- And operator
    The and operator evaluates all expressions and returns the last expression 
    if all expressions evaluate to `True`. Otherwise it returns the first value
    that evaluates to False:
    ```
    1 and 2  # 2

    1 and 0  # 0

    1 and 'hello world'  # 'hello world'

    '' and 'pancakes'  # ''
    ```

- Or operator
    The or operator evaluates the expressions left to right and returns the 
    first value that evaluates to `True` or the last value(if none are True)
    ```
    1 or 2  # 1

    None or 1  # 1

    0 or []  # []
    ```

- Lazy evaluation
    When you use this approach, remember that the evaluation is lazy. Expressions
    that are not required to be evaluated to determine the result are not 
    evaluated.
    ```
    def print_me():
        print('I am here!')

    0 and print_me()  # 0
    ```

- Testing for multiple conditions   


# 14.5 Using the cmp function to get the comparison result of two objects
Python 2 includes a `cmp` function which allows you to determine if one object
is less than, equal to, or greater than another object. This function can be
used to pick a choice out of a list based on one of those three options.
```python
['equal', 'greater than', 'less than',] [cmp(x, y)]
# x, y = 1, 1 output: 'equal'
# x, y = 1, 2 output: 'less than'
# x, y = 2, 1 output: 'greater than'
```
`cmp(x, y)` returns the following values
| Comparison | Result |
|------------|--------|
| x < y      | -1     |
| x == y     | 0      |
| x > y      | 1      |
This function is removed on Python 3. You can use the `cmp_to_key(func)` helper
function located in functools in Python 3 to convert old comparison functions
to key functions.


# 14.6 Else statement


# 14.7 Testing if an object is None and assigning it
You'll often want to assign something to an object if it is None, indicating it
has not been assigned.

The simplest way to do it is to use `is None` test.
```python
if a_date is None:
    a_date = datetime.date.today()
```
Note that it is more Pythonic to say `is None` instead of `== None`.

But this can be optimized slightly by exploiting the notion that `not None` will
evaluate to `True` in a boolean expression. The following code is equivalent:
```python
if not a_date:
    a_date = datetime.date.today()
```

But there is a more Pythonic way. The following code is equivalent:
```python
a_date = a_date or datetime.date.today()
```
This does a short circuit evaluation.


# 14.8 If statement


# Chapter 15: Comparisons


# 15.1 Chain Comparisons
You can compare multiple items with multiple comparison operators with chain 
comparison. For example
```python
x > y > z
# is just a short form of:
x > y and y > z
```
This will evaluate to True only if both comparisons are True

## Side effects
As soon as one comparison returns False, the expression evaluates immediately 
to False, skipping all remaining comparisons.

Note that the expression `exp` in `a > exp > b` will be evaluated only once,
whereas in the case of
```python
a > exp and exp > b
# exp will be computed twice if `a > exp` is true
```


# 15.2 Comparison by `is` vs `==`
A common pitfall is confusing the equality comparison operator `is` and `==`.
- `a == b` compares the value of a and b
- `a is b` will compare the identities of a and b
```python
a = 'Python is fun!'
b = 'Python is fun!'  
a == b  # True
a is b  # False the identities is different

a = [1, 2, 3, 4]
b = a  # b references a
a == b  # True
a is b  # True

b = a[:]  # b now references a copy of a
a == b  # True
a is b  # False[!!]
```
Basically, `is` can be thought of as shorthand for id(a) == id(b)

Beyond this, there are quirks of the run-time environment that further 
complicate things. Short strings and small integers will return True when
compared with `is`, due to the Python machine attempting to use less memory 
for identical objects.
```python
a = 'short'
b = 'short'
c = 5
d = 5
a is b # True
c is d # True
```

But longer strings and larger integers will be stored separately.


A use of `is` is to test for a 'sentinel'(i.e. a unique object)
```python
sentinel = object()

def my_func(var=sentinel):
    if var is sentinel:
        # value wasn't provided
        pass
    else:
        # value was provided
        pass
```


# 15.3 Greater than or less than
For numbers this simply compares the numerical values to see which is larger:

For strings they will compare lexicographically, which is similar to 
alphabetical order but not quite the same.
```python
'alpha' < 'beta' # True
'gamma' > 'beta' # True
'gamma' < 'OMEGA'  # False
```

In these comparisons, lowercase letters are considered 'greater than', which is
why 'gamma' < 'OMEGA' is false. If they were all uppercase it would return the
expected alphabetical ordering result:
```python
'GAMMA' < 'OMEGA'  # True
```

Each type define it's calculation with the < and > operators differently, so 
you should investigate what the operators mean with a given type before using
it.


# 15.4 Not equal to
`x != y`


# 15.5 Equal to
`x == y`

# 15.6 Comparing Objects
In order to compare the equality of custom classes, you can override == and !=
by defing `__eq__` and `__ne__` methods. You can also override `__lt__(<)`, 
`__le__(<=)`, `__gt__(>)`, `__ge__(>=)`. Note than you only need to override
two comparison methods, and Python can handle the rest(== is the same as not <
and not >, etc.)
```python
class Foo(object):
    def __init__(self, item):
        self.my_item = item
    def __eq__(self, other):
        return self.my_item == other.my_item

a = Foo(5)
b = Foo(5)
a == b   # True
a != b   # False
a is b   # False
```
Note that this imple comparison assumes that other(the object being compared to)
is the same object type.


# Chapter 16: Loops

# 16.1 Break and Continue in Loops

## break statement
When a `break` statement executes inside a loop, control flow 'breaks' out of
the loop immediately:
```python
i = 0
while i < 7:
    print(i)
    if i == 4:
        print('Breaking from loop')
        break
    i += 1
```

Note that `break` statement are only allowed inside loops, syntactically.

`break` statement can also be used inside `for` loops, the other looping 
construct provided by Python

## continue statement
A `continue` statement will skip to the next iteration of the loop bypassing
the rest of the current block but continuing the loop. As with break, continue
can only appear inside loops.


## Nested Loops
break and continue only operate on a single level of loop.


## Use return from within a function as a break


# 16.2 For loops
`for` loops iterate over a collection of items, such as `list` or `dict`, and 
run a block of code with each element from the collection.
```
for i in [0, 1, 2, 3, 4]:
    print(i)

```
The above `for` loop iterates over a list of numbers.

`for` loop can iterate on any iterable object which is an object which defines
a `__getitem__` or a `__iter__` function. The `__iter__` function returns an 
iterator, which is an object with a next function that is used to access the 
next element of the iterable.


# Iterating over lists
If you want to loop though both the elements of a list and have an index for 
the elements as well, you can use Python's enumerate function:
```python
for index, item in enumerate(['one', 'two', 'three', 'four']):
    print(index, '::', item)
```
`enumerate` will generate tuples, which are unpacked into index(an integer) and
item(the actual value from the list).

Iterate over a list with value manipulaion using map and lambda, i.e. apply
lambda function on each element in the list.
```python
x = map(lambda e: e.upper(), ['one', 'two', 'three'])
print(list(x))
# Output: ['ONE', 'TWO', 'THREE']
```

# 16.3 Loops with an 'else' clause
The `for` and `while` compound statements(loops) can optionally have an `else`
clause(in practice, this usage is fairly rare).

The `else` clause only executes after a `for` loop terminates by iterating to
completion, or after a `while` loop terminates by its conditional expression
becoming false.
```python
for i in range(3):
    print(i)
else:
    print('done')

i = 0
while(i < 3):
    print(i)
    i += 1
else:
    print('done')
```
The `else` clause does not execute if the loop terminates some other way(
through a break statement or by raising an exception).

## Why would one use this strange construct?
The main use case for the `for...else` construct is a concise implementation of
search as for instance:
```python
a = [1, 2, 3, 4]
for i in a:
    if type(i) is not int:
        print(i)
        break
else:
    print('no exception')
```
To make the `else` in this construct less confusing one can think of it as "if
not break' or `if not found'.


# 16.5 The Pass Statement
`pass` is a null statement for when a statement is required by Python syntax(
such as within the body of a for or while loop), but no action is required or
desired by the programmer. This can be useful as a placeholder for code that is
yet to be written.
```python
for x in range(10):
    pass

while x == y:
    pass
```


# 16.6 Iterating over dictionaries
Considering the following dictionary:
`d = {'a': 1, 'b': 2, 'c': 3}`
To iterate through its keys, you can use:
```python
for key in d:
    print(key)
```
Output:
"a"
"b"
"c"

This is equivalent to:
```python
for key in d.keys():
    print(key)
```

To iterate through its values, use:
```python
for value in d.values():
    print(value)
```

To iterate through its keys and values, use:
```python
for key, value in d.items():
    print(key, '::', value)
```

Note that in Python 2, .keys(), .values() and .items() return a `list` object.
If you simply need to iterate through the result, you can use the equivalent
.iterkeys(), .itervalues() and .iteritems().

The difference between .keys() and .iterkeys(), is that the `iter\*` methods 
are generators. Thus, the elements within the dictionary are yielded one by one
as they are evaluated. When a `list` object is returned, all of the elements are
packed into a list and then returned for further evaluation.


# 16.7 The "half loop" do-while
Unlike other languages, Python do not have a do-while or do-until construct(
this will allow  code to be executed once before the condition is tested).
However, you can combine a `while True` with a `break` to achieve the same
purpose.
```python
a = 10
while True:
    a -= 1
    print(a)
    if a < 7:
        break
print('done')
```

# 16.8 Looping an Unpacking
If you want to loop over a list of tuples for example:
> collection = [('a', 'b', 'c'), (1, 2, 3), ('x', 1, 'y')]

Instead of doing something like this:
```python
for item in collection:
    i1 = item[0]
    i2 = item[1]
    i3 = item[2]

for item in collection:
    i1, i2, i3 = item
```
You can simply do this
```python
for i1, i2, i3 in collection:
    pass
```
This also works for most types of iterables, not just tuples.


# 16.9 Iterating different portion of a list with different step size
Suppose you have a long list of elements and you are only interested in every
other element of the list. Perhaps you only want to examine the first or last
elements, or a specific range of entires in your list. Python has strong 
indexing built-in capabilities. Here are some examples of how to achieve these
scenarios.
```python
lst = ['alpha', 'bravo', 'charlie', 'delta', 'echo']

for s in lst:
    print(s[:1])  # print the first letter
```

## Iterate over sub-list
```python
for i in range(2, 4):
    print('lst at %d contains %s' % (i, lst[i]))

for s in lst[2::4]:
    print(s)

for i in range(1, len(lst), 2):
    print(lst[i])
```


# 16.10 While Loop
While the while loop can be translated into a more elegant `for` loop, `while`
loop are useful for checking if some condition has been met. 
```python
my_object = an_object()
while my_object.is_not_ready():
    my_object.try_to_get_ready()
```


# Chapter 17: Arrays

# 17.1 Access individual elements through indexes
```python
my_array = array('i', [1, 2, 3, 4])
my_array[1] # = 2
my_array[2] # = 3
my_array[0] # = 1
```

# 17.2 Basic Introduction to Arrays
An array is a data structure that stores values of same data type. In Python
this is the main difference between arrays and lists.

To use arrays in python language, you need to import the standard `array` module.
This is because array is not a fundamental data type like strings, integer etc.
Here is how you can import `array` module in python:
```python
from array import *

# Once you have imported the array module, you can declare an array. Here is 
how you do it:

array_identifier_name = array(typecode, [Initializers])
```
| Typecode | Details |
|----------|---------|
| b        |         |
| B        |         |
| c        |         |
| u        |         |
| h        |         |
| H        |         |
| i        |         |
| I        |         |
| w        |         |
| l        |         |
| L        |         |
| f        |         |
| d        |         |

In the declaration above, array_identifier_name is the name of array, typecode
lets python know the type of array and Initializers are the values with which
array is initialized.

# 17.3 Append any value to the array using append()
```python
my_array = array('i', [1, 2, 3, 4])
my_array.append(5)
```

# 17.4 Insert value in an array using insert method
```python
my_array = array('i', [1, 2, 3, 4])
my_array.insert(0, 5)
# array('i', [5, 1, 2, 3, 4])
```

# 17.5 Extend python array using extend() method
A Python array can be extended with more than one value using extend() method.
```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
my_extend_array = array('i', [6, 7, ,8 ,9 ,10])
my_array.extend(my_extend_array)
# array('i', [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
```

# 17.6 Add items from list into array using fromlist() method
```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
c = [11, 12, 13]
my_array.fromlist(c)
# array('i', [1, 2, 3, 4, 5, 11, 12, 13])
```

# 17.7 Remove any array element using remove() method
```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
my_array.remove(4)
# array('i', [1, 2, 3, 5])
```

# 17.8 Remove last array element using pop() method
```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
my_array.pop()
# array('i', [1, 2, 3, 4])
```

# 17.9 Fetch any element through its index using index() method
index() returns **first** index of the matching value. Remember that arrays are 
zero-indexed.

```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
my_array.index(4)
# 3

my_array = array('i', [1, 2, ,3 ,3 ,5])
my_array.index(3)
# 2
```

# 17.10 Reverse a python array using reverse() method
```python
my_array = array('i', [1, 2, ,3 ,4 ,5])
my_array.reverse()
# array('i', [5, 4, 3, 2, 1])
```

# 17.11 Get array buffer information through buffer_info() method
This method provides you the array buffer start address in memory and number of
elements in array.
```python
my_array = array('i', [1, 2, 3, 4, 5])
my_array.buffer_info()
# (139921518805200, 5)
```

# 17.12 Check for number of occurrences of an element using count() method
count() will return the number of times and element appears in an array.
```python
my_array = array('i', [1, 2, 3, 3, 5])
my_array.count(3)
# 2
```

# 17.13 Convert array to string using tostring() method
```python
my_char_array = array('u', ['g', 'e', 'e', 'k'])
# array('u', 'geek')
print(my_char_array.tostring())
# geek
```

# 17.14 Convert array to a python list with same elements using tolist() method
```python
my_array = array('i', [1, 2, 3, 4])
c = my_array.tolist()
# [1, 2, 3, 4]
```

# 17.15 Append a string to char array using fromstring() method
```python
my_char_array = array('u', ['g', 'e', 'e', 'k'])
my_char_array.fromstring('stuff')
print(my_char_array)
# array('u', 'geekstuff')
```


# Chapter 18: Multidimensioanl arrays

# 18.1 Lists in lists
```python
lst = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
lst[0][0] = 11
# lst = [[11, 2, 3], [4, 5, 6], [7, 8, 9]] 
lst[0] = [11, 12, 13]
# lst = [[11, 12, 13], [4, 5, 6], [7, 8, 9]] 
```

# 18.2 Lists in lists in lists in
This behavior can be extended. Here is a 3-dimensional array:
```python
[[[1,3,4], [3, 4, 5], [6, 7, 8]], [[5,6,1], [6,7,2], [8,9,0]]]
# As is obvious, this gets a bit hard to read. Use blackslashes to break up the
# different dimensions:
[[[1,3,4], [3, 4, 5], [6, 7, 8]],\
 [[5,6,1], [6,7,2], [8,9,0]]]
```


# Chapter 19: Dictionary
| Parameter | Details                    |
|-----------|----------------------------|
| key       | The desired key to lookup  |
| value     | The value to set or return |

# 19.1 Introduction to Dictionary
A dictionary is an example of a _key value store_ also know as _Mapping_ in 
Python. It allows you to store and retrive elements by referencing a key. As
dictionaries are referenced by key, they have very fast lookups. As they are
primarily used for referencing items by key, they are not **sorted**.

## creating a dict
- literal syntax
```python
d = {}               # empty dict
d = {'key': 'value'} # dict with initial values

# python 3.x version >= 3.5
# Also unpacking one or multiple dictionaries with the literal syntax is 
# possible

# makes a shallow copy of otherdict
d = {**otherdict}
# also updates the shallow copy with the contents of the yetanotherdict.
d = {**otherdict, **yetanotherdict}
```

- dict comprehension 
`d = {k:v for k, v in [('key', 'value',)]}`

- built-in class: dict()
```python
d = dict()             # empty dict
d = dict(key='value')  # explicit keyword arguments
d = dict([('key', 'value')])  # passing in a list of key/value pairs
# make a shallow copy of another dict(only possible if keys are only strings!)
d = dict(**otherdict)
```

- modifing a dict
```python
# To add item to a dictionary, simply create a new key with a value:
d['newkey'] = 42

# It also possible to add `list` and `dictionary` as value:
d['new_list'] = [1, 2, 3]
d['new_dict'] = {'nested_dict': 1}

# To delete an item, delete the key from the dictionary:
del d['newkey']
```

# 19.2 Avoiding KeyError Exceptions
One common pitfall when using dictionaries is to access a non-existent key. 
This typically results in a KeyError exception

```python
my_dict = {}
my_dict['not there']

Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
KeyError: 'not there'
```

One way to avoid key errors is to use the dict.get method, which allows you to
specify a default value to return in the case of an absent key.
```python
value = my_dict.get(key, default_value)
```
**Which returns my_dict[key] if it exists, but otherwise returns default_value.
Note that this doesn't add key to my_dict. So if you want to retain that key
value pair, you should use `my_dict.setdefault(key, default_value)`, which does
store the key value pair.**
```python
mydict = {}
print(mydict)           # {}
print(mydict.get('foo', 'bar'))  # bar
print(mydict)           # {}

print(mydict.setdefault('foo', 'bar'))  # bar
print(mydict)           # {'foo': 'bar'}
```

An alternative way to deal with the problem is catching the excpetion
```python
try:
    value = mydict[key]
except KeyError:
    value = default_value

# You could also check if the key is in the dictionary.
if key in mydict:
    value = mydict[key]
else:
    value = default_value
```
Do note, however, that in multi-threaded environments it is possible for the
key to be removed from the dictionary after you check, creating a race condition
where the exception can still be thrown.

Another option is to use a subclass of dict, collections.defaultdicct, that has
a default_factory to create new entries in the dict when given a new_key.

# 19.3 Iterating Over a Dictionary
If you use a dictionary as an iterator(e.g. in a for statement), it traverses
the keys of the dictionary.
```python
d = {'a': 1, 'b': 2, 'c': 3}
for key in d:
    print(key, d[key])
# a 1
# b 2
# c 3

# The same is true when used in a comprehension
print([key for key in d])
# ['a', 'b', 'c'] 
```

- The items() method can be used to loop over both the key and value 
simultaneously:
```python
d = {'a': 1, 'b': 2, 'c': 3}
for key, value in d.items():
    print(key, value)
# a 1
# b 2
# c 3
```

- While the `values()` method can be used to iterate over only the values, as 
would be expected:
```python
d = {'a': 1, 'b': 2, 'c': 3}
for value in d.values():
    print(value)
# 1
# 2
# 3
```
Here, the methods keys(), values() and items() return lists, and there are the
three extra methods iterkeys(), itervalues() and iteritems() to return iterators.

# 19.4 Dictionary with default values
Available in standard library as `defaultdict`
```python
from collections import defaultdict

d = defaultdict(int)
d['key']        # 0
d['key'] = 5    # 5
d['key']        # 5

d = defaultdict(lambda: 'empty')
d['key']            # 'empty'
d['key'] = 'full'   # 'full'
d['key']            # 'full'
```

Alternatively, if you must use the built-in `dict` class, using `dict.setdefault()`
will allow you to create a default whenever you access a key that did not exist
before:
```
>>> d = {}
{}
>>> d.setdefault('Another key', []).append('This worked!')
>>> d
{'Another key': ['This worded!']}
```

# 19.5 Merging dictionaries
```
>>> fish = {'name': 'Nemo', 'hands': 'fins', 'special': 'gills'}
>>> dog = {'name': 'Clifford', 'hands': 'paws', 'color': 'red'}

# Python 3.5+
>>> fishdog = {**fish, **dog}
>>> fishdog
{'hands': 'paws', 'color': 'red', 'name': 'Clifford', 'special': 'gills'}
```
As this example demonstrates, duplicate keys map to their lattermost value(for
example 'Clifford' overrides 'Nemo').

Python 3.3+
```
>>> from collections import ChainMap
>>> dict(ChainMap(fish, dog))
{'hands': 'fins', 'color': 'red', 'name': 'Nemo', 'special': 'gills'}
```
With this technique the foremost value takes precedence for a given key rather
than the last('Clifford' is thrown out in favor of 'Nemo').

```
>>> fish.update(dog)
>>> fish
{'hands': 'paws', 'color': 'red', 'name': 'Clifford', 'special': 'gills'}
```

# 19.6 Accessing keys and values
# 19.7 Accessing values of a dictionary

# 19.8 Creating a dictionary
> - Every key must be unique
> - Every key must be hashable
> - There is no particular order for the keys.
```python
# creating and populating it with values
stock = {'eggs': 5, 'milk': 2}

# Or creating an empty dict
dictionary = {}

# And populating it after
dictionary['eggs'] = 5
dictionary['milk'] = 2

# Values can also be lists
mydict = {'a': [1, 2, 3], 'b': ['one', 'two', 'three']}

# Use list.append() method to add new elements to the values list
mydict['a'].append(4)   
mydict['b'].append('four')   

# We can also create a dictionary using a list of two-items tuples
iterabel = [('eggs', 5), ('milk', 2)]
dictionary = dict(iterable)

# Or using keyword argument
dictionary = dict(eggs=5, milk=2)

# Another way will be to use the dict.fromkeys
dictionary = dict.fromkeys((milk, eggs))  # => {'milk': None, 'eggs': None}
dictionary = dict.fromkeys((milk, eggs), (2, 5))  # => {'milk': 2, 'eggs': 5}
```

# 19.9 Creating an ordered dictionary
You can create an ordered dictionary which will follow a determined order when
iterating over the keys in the dictionary.

Use OrderedDict from the collections module. This will always return the 
dictionary elements in the original insertion order when iterated over.

```python
from collections import OrderedDict

d = OrderedDict()
d['first'] = 1
d['second'] = 2
d['third'] = 3
d['last'] = 4

# Outputs "first 1", "second 2", "third 3", "last 4"
for key in d:
    print(key, d[key])
```

# 19.10 Unpacking dictionaries using the ** operator
You can use the `**` keyword argument unpacking operator to deliver the 
key-value pairs in a dictionary into a function's arguments. A simplified
example from the official documentation:
```
>>>
>>> def parrot(voltage, state, action):
...     print("This parrot wouldn't", action, end=' ')
...     print("if you put", voltage, "volts through it.",  end=' ')
...     print("E's", state, "!")
...
>>> d = {'voltage': 'four million', 'state': "bleedin' demised", "action": "VOOM"}
>>> parrot(**d)
This parrot wouldn't VOOM if you put four million volts through it. E's bleedin's
demised !
```

# 19.11 The trailing comma
Like lists and tuples, you can include a trailing comma in your dictionary.
```python
role = {"By day": "A typical programmer",
        "By night": "Still a typical programmer", }
```

# 19.12 The dict() constructor
```python
dict(a=1, b=2, c=3)
dict([('d', 4), ('e', 5), ('f', 6)])
dict([('a', 1)], b=2, c=3)
dict({'a': 1, 'b': 2}, c=3)
```

# 19.13 Dictionaries Example

# 19.13 All combinations of dictionary values
```python
options = {
    "x": ["a", "b"],
    "y": [10, 20, 30]
}

Given a dictionary such as the one shown above, where there is a list 
representing a set of values to explore for the corresping key. Suppose you 
want to explore "x"="a" with "y"=10, the "x"="a" with y=20, and so on until you
have explored all possible combinations.

You can create a list that returns all such combinations of values using the
following code.
```python
import itertools
options = {
    "x": ["a", "b"],
    "y": [10, 20, 30]
}

keys = options.keys()
values = (options[key] for key in keys)
combinations = [dict(zip(keys, combination)) for combination in itertools.product(*values)]
print(combinations)

#[{'x': 'a', 'y': 10},
# {'x': 'b', 'y': 10},
# {'x': 'a', 'y': 20},
# {'x': 'b', 'y': 20},
# {'x': 'a', 'y': 30},
# {'x': 'b', 'y': 30}]
```


# Chapter 20: List

# 20.1 List methods and supported operators
```python
# Starting with a given list a:
a = [1, 2, 3, 4, 5]
```
1. append(value) - appends a new element to the end of the list
    ```python
    a.append(6)
    a.append(7)
    a.append(7)
    # a: [1, 2, 3, 4, 5, 6, 7, 7]
    
    # Append another list
    b = [8, 9]
    a.append(b)
    
    # Append an element of a different type, as list elements do not need to have 
    # the same type
    my_string = 'hello world'
    a.append(my_string)
    
    # Note that the append() method only appends one new element to the end of the
    # list. If you append a list to another list, the list that you append becomes
    # a single element at the end of the first list.
    ```

2. extend(enumerable) - extends the list by appending elements from another
enumerable.
    ```python
    a = [1, 2, 3, 4, 5, 6, 7, 7]
    b = [8, 9, 10]
    
    # Extend list by appending all elements from b
    a.extend(b)
    # a = [1, 2, 3, 4, 5, 6, 7, 7, 8, 9, 10]
    
    a.extend(range(3))
    # a = [1, 2, 3, 4, 5, 6, 7, 7, 0, 1, 2]
    
    a = [1, 2, 3, 4, 5, 6] + [7, 7] + b
    # a: [1, 2, 3, 4, 5, 6, 7, 7, 8, 9, 10]
    ```
    
3. index(value, [startIndex]) - gets the index of the first occurrence of the 
input value. If the input value is not in the list a ValueError exception is
raised. If a second argument is provided, the search is started at that 
specific index.
    ```python
    a.index(7)
    # Returns: 6
    
    a.index(49)
    # ValueError
    
    a.index(7, 7)
    # Returns: 7
    
    a.index(7, 8)
    # ValueError, because there is no 7 starting at index 8
    ```

4. insert(index, value) - inserts a value just before the specified index. Thus
after the insertion the new element occupies position index.

5. pop([index]) - removes and returns the item at index. With no argument it
removes and returns the last element of the list.

6. remove(value) - removes the first occurrence of the specified value. If the
provided value can not be found, a ValueError is raised.

7. reverse() - reverses the list in-place and returns None.

8. count(value) - counts the number of occurrentces of some value in the list

9. sort() - sorts the list in numerical and lexicographical order and returns
None.
    ```python
    a.sort()
    
    # Lists can also be reversed when sorted using the reverse=True flag in the 
    # sort() method.
    a.sort(reverse=True)
    ```
    
    If you want to sort by attributes of items, you can use the keyword argument:
    ```python
    import datetime
    class Person(object):
        def __init__(self, name, birthday, height):
            self.name = name
            self.birthday = birthday
            self.height = height
        def __repr__(self):
            return self.name
    
    l = [Person("John Cena", datetime.date(1992, 9, 12), 175),
         Person("Chuck Norris", datetime.date(1990, 8, 28), 180),
         Person("Jon Skeet", datetime.date(1991, 7, 6), 185)]
    
    l.sort(key=lambda item: item.name)
    # l: [Chuck Norris, John Cena, Jon Skeet]
    
    l.sort(key=lambda item: item.birthday)
    # l: [Chuck Norris, Jon Skeet, John Cena]
    
    l.sort(key=lambda item: item.height)
    # l: [John Cena, Chuck Norris, Jon Skeet]
    ```
    
    In case of list of dicts the concept is the same:
    ```python
    import datetime
    l = [{'name':'John Cena', 'birthday': datetime.date(1992, 9, 12),'height': 175},
         {'name': 'Chuck Norris', 'birthday': datetime.date(1990, 8, 28),'height': 180},
         {'name': 'Jon Skeet', 'birthday': datetime.date(1991, 7, 6), 'height': 185}]
    
    l.sort(key=lambda item: item['name'])
    # l: [Chuck Norris, John Cena, Jon Skeet]
    
    l.sort(key=lambda item: item['birthday'])
    # l: [Chuck Norris, Jon Skeet, John Cena]
    
    l.sort(key=lambda item: item['height'])
    # l: [John Cena, Chuck Norris, Jon Skeet]
    ```
    
    Sort by sub dict:
    ```python
    import datetime
    
    l = [{'name':'John Cena', 
          'birthday': datetime.date(1992, 9, 12),
          'size': {'height': 175, 'weight': 100}},
         {'name': 'Chuck Norris', 
          'birthday': datetime.date(1990, 8, 28),
          'size' : {'height': 180, 'weight': 90}},
         {'name': 'Jon Skeet', 
         'birthday': datetime.date(1991, 7, 6), 
         'size': {'height': 185, 'weight': 110}}]
    
    l.sort(key=lambda item: item['size']['height'])
    # l: [John Cena, Chuck Norris, Jon Skeet]
    ```
    
    Better way to sort using attrgetter and itemgetter
    Lists can also be sorted using attrgetter and itemgetter functions from the
    operator module. These can help improve readability and reusability.
    ```python
    from operator import itemgetter, attrgetter
    
    people = [{'name': 'chandan', 'age': 20, 'salary': 2000},
              {'name': 'chetan', 'age': 18, 'salary': 5000},
              {'name': 'guru', 'age': 30, 'salary': 3000}]
    
    by_age = itemgetter('age')
    by_salary = itemgetter('salary')
    
    people.sort(key=by_age)    # in-place sorting by age
    people.sort(key=by_salary) # in-place sorting by salary
    
    # itemgetter can also be given an index. This is helpful if you want to sort
    # based on indices of a tuple.
    list_of_tuples = [(1, 2), (3, 4), (5, 0)]
    list_of_tuples.sort(key=itemgetter(1))
    print(list_of_tuples)  # [(5, 0), (1, 2), (3, 4)]
    
    
    # Use the attrgetter if you want to sort by attributes of an object
    persons = [Person("John Cena", datetime.date(1992, 9, 12), 175),
               Person("Chuck Norris", datetime.date(1990, 8, 28), 180),
               Person("Jon Skeet", datetime.date(1991, 7, 6), 185)] 
    # reusing Person class from above example
    
    person.sort(key=attrgetter('name'))  # sort by name
    by_birthday = attrgetter('birthday')
    person.sort(key=by_birthday)  # sort by birthday
    ```

10. clear() - removes all items from the list

11. Replication - multiplying an existing list by an integer will produce a
larger list consisting of that many copies of the original. This can be useful
for example for list initialization

12. Element deletion - it is possible to delete multiple elements in the list 
using the `del` keyword and slice notation:
    ```python
    a = list(range(10))
    del a[::2]
    # a = [1, 3, 5, 7, 9]
    del a[-1]
    # a = [1, 3, 5, 7]
    del a[:]
    # a = []
    ```

13. Copying
    The default assignment '=' assigns a reference of the original list to the
    new name. That is, the original name and new name are both pointing to the
    same list object. Changes made through any of them will be reflected in 
    another.

    If you want to create copy of the list you have below options.
    ```python
    # You can slice it:
    new_list = old_list[:]

    # You can use the built-in list() function:
    new_list = list(old_list)

    # You can use generic copy.copy():
    import copy
    new_list = copy.copy(old_list) # inserts references to the objects found in the original.

    # This is a litter slower than list() because it has to find out the 
    #  datatype of old_list first.

    # If list have objects and you want to copy them as well, use generic copy.deepcopy():
    import copy
    new_list = copy.deepcopy(old_list)  # inserts copies of the objects found in originals.


    # copy() return a shallow copy of the list(version >= 3.0
    aa = a.copy()
    ```

# 20.2 Accessing list values
Python list are zero-indexed, and act like arrays in other languages.

Attempting to access an index outside the bounds of the list will raise an 
`IndexError`.

Negative indices are interpreted as counting from the end of the list.

**Lists allow to use `slice notation` as lst[start:end:step]. The output of the
slice notation is a new list cantaining elements from index `start to end-1`. If
options are omitted `start` defaults to beginning of list, `end` to end of list
and `step` to 1**
```python
lst = [1, 2, 3, 4]
lst[1:]     # [2, 3, 4]
lst[:3]     # [1, 2, 3] end-1 = 3-1 = 2
lst[::2]    # [1, 3]
lst[::-1]   # [4, 3, 2, 1]
lst[-1:0:-1]# [4, 3, 2]
lst[5:8]    # [] since starting index is greater than length of lst, returns empty list
lst[1:10]   # [2, 3, 4] same as omitting ending index

# When using step lengths of negative amounts(the start and end index should be
# positive), the starting index has to be greater than the ending index otherwise
# the result will be an empty list.

lst[3:1:-1] # [4, 3]
```


- Advanced slicing
When lists are sliced the `__getitem__()` method of the list  object is called,
With a `slice` object. Python has a builtin slice method to generate slice 
objects. We can use this to store a slice and reuse it later like so,
```python
data = 'chandan purohit    22 2000'  # assuming data fields of fixed length
name_slice = slice(0, 19)
age_slice = slice(19, 21)
salary_slice = slice(22, None)

# now we can have more readable slices
print(data[name_slice])     # 'chandan purohit    '
print(data[age_slice])      # '22'
print(data[salary_slice])   # ' 2000' white-space 
```
This can be of great use by providing slicing functionality to our objects by 
overriding `__getitem__` in our class.


# 20.3 Checking if list is empty
The emptiness of a list is associated to the boolean False, so you don't have
to check len(lst) == 0, but just `lst` or `not lst`
```python
lst = []
if not lst:
    print('list is empty')

# Output: list is empty
```


# 20.4 Iterating over a list
```python
lst = ['foo', 'bar', 'baz']
for item in lst:
    print(item)

for index, item in enumerate(lst):
    print('The item in position{} is {}'.format(index, item))

for i in range(0, len(lst)):
    print(lst[i])

# Note that changing items in a list while iterating on it may have unexpected
# results
for item in lst:
    if item == 'foo':
        del lst[0]
    print(item)

# Output: foo
# Output: baz
# In this last example, we deleted the first item at the first iteration, but 
# that caused bar to be skipped.
```


# 20.5 Checking whether an item is in a list
Simply use `in` operator
```python
lst = ['test', 'twest', 'tweast', 'treast']
'test' in lst
# True

'toast' in lst
# False

# Note: the `in` operator on sets if asymptotically faster than on lists. If 
# you need to use it many times on potentially large lists, you may want to
# convert your `list` to a set, and test the presence of elements on the set.

slst = set(lst)
'test' in slst
# True
```

# 20.6 Any and All
You can use all() to determine if all the values in an iterable evaluate to 
True
```python
nums = [1, 1, 0, 1]
all(nums)
# False
char = ['a', 'b', 'c', 'd']
all(char)
# True
```

Likewise, any() determines if one or more values in an iterable evaluate to True
```python
nums = [1, 1, 0, 1]
any(nums)
# True
char = ['a', 'b', 'c', 'd']
any(char)
# True
```

While this example uses a list, it is important to note these built-ins work
with any iterable, including generators.
```python
vals = [1, 2, 3, 4]
any(val > 12 for val in vals)
# False
any((val * 2) > 6 for val in vals)
# True
```


# 20.7 Reversing list elements
You can use the `reversed` function which returns an iterator to the reversed
list:
```python
numbers = [1, 2, 3, 4]
rev = reversed(numbers)
for r in rev:
    print(r)
# 4
# 3
# 2
# 1
```

Note that the list 'numbers' remains unchanged by this operation, and remains
in the same order it was originally.

To reverse in place, you can also use the `reverse` method.

```python
numbers[::-1]
```


# 20.8 Concatenate and Merge lists
1. The simplest way to concatenate list1 and list2
> merged = list1 + list2

2. `zip` returns a list of tuples, where the i-th tuple contains the i-th 
element from each of the argument sequences or iterables:
    ```python
    alist = ['a1', 'a2', 'a3']
    blist = ['b1', 'b2', 'b3']
    
    for a, b in zip(alist, blist):
        print(a, b)
    
    # Output:
    # a1 b1
    # a2 b2
    # a3 b3
    ```
    If the lists have different length then the result list will include only 
    as many elements as the shortest one.

    For padding lists of unequal length to the longest one with Nones use
    `itertools.zip_longest(itertools.izip_longest in python 2)`

    ```python
    alist = ['a1', 'a2', 'a3']
    blist = ['b1']
    clist = ['c1', 'c2', 'c3', 'c4'] 

    for a, b, c in zip(alist, blist, clist):
        print(a, b, c)

    # Output:
    # a1 b1 c1
    # a2 None c2
    # ...

    ```

3. Insert to a specific index values:
    ```python
    alist = [123, 'xyz', 'zara', 'abc']
    alist.insert(3, [2020])
    print('Final List: ', alist)

    # Output
    # Final List: [123, 'xyz', 'zara', 2009, 'abc']
    ```


# 20.9 Length of a list
Use `len()` to get the one-dimensional length of a list
```python
len(['one', [2, 3], 'four'])  # returns 3, not 4
```

`len()` also works on strings, dictionaries, and other data structure similar
to lists.


# 20.10 Remove duplicate values in list
Removing duplicate values in a list can be done by converting the list to a set
(that is an unordered collection of distinct objects). If a list data structure
is needed, then the set can be converted back to a list using the function 
list():
```python
names = ['aisk' , 'duke', 'eidk', 'topf', 'duke']
list(set(names))
# Outputs: ['duke', 'topf', 'aisk', 'eidk']
```

Note that by converting a list to a set the original ordering is lost.

**To preserve the order of the list one can use an OrderedDict**
```python
import collections
collections.OrderedDict.fromkeys(names).keys()
# Output: ['aisk', 'duke', 'eidk', 'topf']
```


# 20.11 Comparison of lists
It's possible to compare lists and other sequences lexicographically using
comparison operators. Both operands must be of the same type.

```python
[1, 10, 100] < [2, 10, 100]
# True, because 1 < 2
[1, 10, 100] < [1, 10, 100]
# False, because the lists are equal
[1, 10, 100] <= [1, 10, 100]
# True, because the lists are equal
[1, 10, 100] < [1, 10, 101]
# True, because 100 < 101
[1, 10, 100] < [0, 10, 100]
# False, because 0 < 1
```

If one of the lists are contained at the start of the other, the shortest list
wins.
```python
[1, 10] < [1, 10, 100]
# True
```


# 20.12 Accessing values in nested list
```python
# Starting with a three-dimensional list:
alist = [[[1, 2], [3, 4]], [[5, 6, 7], [8, 9, 10], [12, 13, 14]]]

# Accessing items in the list:
print(alist[0][0][1])
# Output: 2
# Accesses second element in the first list in the first list

alist[0][0].append(11)

# Using nested for loops to print the list:
for row in alist:
    for col in row:
        print(col)
# [1, 2, 11]
# [3, 4]
# [5, 6, 7 ]
# [8, 9, 10]
# [12, 13, 14]

# Note that this operation can be used in a list comprehension or even as a
# generator to produce efficiencies, e.g.:

[col for row in alist for col in row]
# [[[1, 2, 11], [3, 4]], [[5, 6, 7], [8, 9, 10], [12, 13, 14]]]

# Not all items in the outer lists have to be lists themselves:
alist[1].insert(2, 15)
# [[[1, 2, 11], [3, 4]], [[5, 6, 7], [8, 9, 10], 15, [12, 13, 14]]]

# Using slices in nested list:
print(alist[1][1:])
# [[8, 9, 10], 15, [12, 13, 14]]

```


# 20.13 Initializing a List to a Fixed Number of Elements
For `immutable` elements(e.g. None, string literals etc.)
```python
my_list = [None] * 10
my_list = ['test'] * 10
```

For `mutable` elements, the same construct will result in all elements of the
list referring to the same object, for example, for a set:
```python
my_list = [{1}] * 10
print(my_list)
# [{1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}, {1}] 
my_list[0].add(2)
# [{1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}, {1, 2}] 
```

Instead, to initialize the list with a fixed number of different mutable objects,
use:
```python
my_list = [{1} for _ in range(10)]
```


# Chapter 21: List Comprehensions

# 21.1 List Comprehensions
A list comprehension creates a new `list` by applying an expression to each
element fo an iterable. The most basic form is:
```python
[ <expression> for <element> in <iterabel> ]
```

There's also an optional 'if' condition:
```python
[ <expression> for <element> in <iterabel> if <condition>]
```

Each `<element>` in the `<iterable>` is plugged in to the `<expression>` if the
(optional) `<condition>` evaluates to true. All results are returned `at once` 
in the new list. Generator expressions are evaluated lazily, but list 
comprehensions evaluate the entire iterator immediately - consuming memory
proportional to the iterator's length.

To Create a list of squared integers:
```python
squares = [x*x for x in (1, 2 ,3 ,4 5)]
# [1, 4, 9, 16, 25]
```

The for expression sets x to each value in turn from (1, 2, 3, 4, 5). The result
of the expression x * x is appended to an internal list. The internal list is 
assigned to the variable `squares` when completed.

Besides a speed increase, a list comprehension is roughly equivalent to the 
following for-loop:
```python
squares = []
for x in (1, 2, 3, 4):
    squares.append(x * x)

[s.upper() for s in 'Hello World']
#['H', 'E', 'L', ...]

[w.strip(',') for w in ['these,', 'word,,', 'mostly', 'have, comma,']]
# ['these', 'word', 'mostly', 'have, comma']

# Organize letters in words more resonably - in an alphabetical order
sentence = "Beautiful is better than ugly"
[''.join(sort(word, key=lambda x: x.lower())) for word in sentence.split()]
# ['aBefiltuu', 'is', 'beertt', 'ahnt', 'gluy']

```

- else
    `else` can be used in list comprehension constructs, but be careful regrading
    the syntax. The if/else clauses should be used before `for` loop, not after
    ```python
    # create a list of characters in apple, replacing non vowels with '*'
    # Ex - 'apple' --> ['a', '*', '*', '*', 'e']
    
    [x for x in 'apple' if x in 'aeiou' else '*']
    # SyntaxError: invalud syntax
    
    [x if x in 'aeiou' else '*' for x in 'apple']
    # ['a', '*', '*', '*', 'e']
    ```
    
    **Note this uses a different language construct, a conditional expression, which
    itself is not part of the `comprehension syntax`. Whereas the if after the
    `for...in` is a part of list comprehensions and used to filter elements from
    the source iterables.**

- Double iteration
    Order of double iteration [... for x in ... for y in ...] is either natural
    or counter-intuitive. The rule of thumb is to follow an equivalent `for` 
    loop:
    ```python
    def foo(i):
        return i, i + 0.5 

    for i in range(3):
        for x in foo(i):
            yield str(x)
    ```

    This becomes:
    ```python
    [str(x) for i in range(3) for x in foo(i)]
    ```

- In-place Mutation and Other Side Effects
    Before using list comprehension, understand the difference between functions
    called for their side effects(mutating, or `in-place` functions) which
    usually return `None`, and functions that return an interesting value.

    Many functions(especially `pure` functions) simply take an object and return
    some objects. An `in-place` function modifies the existing object, which is
    called a `side effect`. Other examples include input and output operations
    such as printing.

    `list.sort()` sorts a list in-place(meaning that it modifies the original
    list) and returns the value None. Therefore, it won't work as expected in
    a list comprehension.

    ```python
    [x.sort() for x in [[2, 1], [3, 4], [0, 1]]]
    # [None, None, None]
    ```

    Instead, `sorted()` returns a sorted list rather than sorting in-place:
    ```python
    [sorted(x) for x in [[2, 1], [3, 4], [0, 1]]]
    # [1, 2], [3, 4], [0, 1]]
    ```

    Using comprehensions for side-effects is possible, such as I/O or in-place
    functions. Yet a for loop is usually more readable. While this works in
    Python 3:
    ```python
    [print(x) for x in (1, 2, 3)]

    # Instead use
    for x in (1, 2, 3):
        print(x)
    ```

    In some situations, side effect functions are suitable for list comprehension.
    `random.randrange()` has the side effect of changing the state of the random
    number generator, but it also returns an interesting value. Additionally,
    next() can be called on an iterator.

    The following random value generator is not pure, yet makes sense as the 
    random generator is reset every time the expression is evaluated.

    ```python
    from random import randrange
    [randrange(1, 7) for _ in range(10)]
    # [2, 3, 6, 2, 4, 3, 5, 5, 1, 3]
    ```

- Whitespace in list comprehensions
    More complicated list comprehensions can reach an undesired length, or become
    less readable. Although less common in examples, it is possible to break a
    list comprehension into multiple lines like so:
    ```python
    [
        x for x
        in 'foo'
        if x not in 'bar'
    ]
    ```


# 21.2 Conditional List Comprehensions
Given a `list comprehension` you can append one or more if conditions to filter
values.
```python
[<expression> for <element> in <iterable> if <condition>]
```
For each `<element>` in `<iterable>`; if `<condition>` evaluates to True, add
`<expression>`(usually a function of `<element>`) to the returned list.

For example, this can be used to extract only even numbers from a sequence of
integer:
```python
[x for x in range(10) if x % 2 == 0]
# Output: [0, 2, 4, 6, 8]
```

Note that this is quite different from the `... if ... else ...` conditional
expression(sometimes known as a ternary expression) that you can use for the
`<expression>` part of the list comprehension. Consider the following example:
```python
[x if x % 2 == 0 else None for x in range(10)]
# Output: [0, None, 2, None, 4, None, 6, None, 8, None]
```

Here the conditional expression isn't a filter, but rather an operator
determining the value to be used for the list items:
> \<value-if-condition-is-true\>  if  \<condition\>  else  \<value-if-condition-is-false\>

This becomes more obvious if you combine it with other operators:
```python
[2 * (x if x % 2 == 0 else -1) + 1 for x in range(10)]
# Output: [1, -1, 5, -1, 9, -1, 13, -1, 17, -1]
```

One can combine ternary expressions and if conditions. The ternary operator 
works on the filtered result:
```python
[x if x > 2 else '*' for x in range(10) if x % 2 == 0]
# Output: ['*', '*', 4, 6, 8]
```

The same couldn't have been achieved just by ternary operator only:
```python
[x if (x>2 and x%2==0) else '*' for x in range(10)]
# Output: ['*','*','*','*','4','*','6','*','8','*']
```


# 21.3 Avoid repetitive and expensive operations using conditionalclause
Consider the below list comprehension:
```python
def f(x):
    import time
    time.sleep(.1)
    return x**2

[f(x) for x in range(1000) if f(x) > 10]  # there are two f(x) in this list
# Output: [16, 25, 36, ...]
```

This results in **two** calls to f(x) for 1,000 values of x; one call for 
generating the value and the other for checking the if condition. If f(x) is a
particular expensive operation, this can have significant performance 
implications. Worse, if calling f() has side effect, it can have superising
results.

Instead, you should evaluate the expensive operation only once for each value
of x by generating an intermediate iterable(generator expression) as follows:
```python
[v for v in (f(x) for x in range(1000)) if v > 10]
# Output: [16, 25, 36, ...]

# Or, using the built-in map equivalent:
[v for v in map(f, range(1000)) if v > 10]
```

Another way that could result in a more readable code is to put the partial
result(v in the previous example) in an iterable(such as a list or a tuple) and
then iterate over it. Since `v` will be the only element in the iterable, the 
result is that we now have a reference to the output of our slow function only
once.

```python
[v for x in range(1000) for v in [f(x)] if v > 10]
# Output: [16, 25, 36, ...]
```

However, in practise, the logic of code can be more complicated and it's 
important to keep it readable. In general, a seperate generator function is
recommended over a complex one-liner:
```python
def process_prime_numbers(iterable):
    for x in iterable:
        if is_prime(x)
            yield f(x)

[x for x in process_prime_numbers(range(1000)) if x > 10]
```

Say you have to flatten a list
```python
l = [[1, 2, 3], [4, 5], [6], [7, 8, 9]]

# Some of the methods could be:
reduce(lambda x, y: x+y, l)

sum(l, [])

list(itertools.chain(*l))
```
However list comprehension would provide the best time complexity
```python
[item for sublist in l for item in sublist]
```


# 21.4 Dictionary Comprehensions
A `dictionary comprehension` is similar to a list comprehension except that it
produces a dictionary object instead of a list.
```python
{x: x * x for x in (1, 2, 3, 4)}
# Output: {1: 1, 2: 4, 3: 9, 4: 16}
```
which is just another way of writing:
```python
dict((x, x*x) for x in (1, 2, 3, 4))
```

As with a list comprehension, we can use a conditional statement inside the 
dict comprehension to produce only the dict elements meeting some criterion.
```python
{name: len(name) for name in ('Stack', 'Overflow', 'Exchange') if len(name) > 6}
```

Or, rewritten using a generator expression
```python
dict((name, len(name)) for name in ('Stack', 'Overflow', 'Exchange') if len(name) > 6)
```

### Starting with a dictionary and using dictionary comprehension as a key-value pair filter
```python
initial_dict = {'x': 1, 'y': 2}
{key: value for key, value in initial_dict.items() if key == 'x'}
# Output: {'x': 1}
```

### Switching key and value of dictionary(invert dictioary)

If you have a dict containing simple hashable values(duplicate values may have 
unexpected results):
```python
my_dict = {1: 'a', 2: 'b', 3: 'c'}
```
and you want to swap the keys and values you can take several approaches 
depending on your coding style:
- swapped = {v: k for k, v in my_dict.items()}
- swapped = dict((v, k) for k, v in my_dict.items())
- swapped = dict(zip(my_dict.values(), my_dict))
- swapped = dict(zip(my_dict.values(), my_dict.keys()))
- swapped = dict(map(reversed, my_dict.items()))
```python
print(swapped)
# Output: {'a': 1, 'b': 2, 'c': 3}
```

### Merging Dictionaries
Combine dictioaries and optionally override old values with a nested dictionary
comprehension.

```python
dict1 = {'w': 1, 'x': 2}
dict2 = {'x': 2, 'y': 2, 'z': 2}

{k: v for d in [dict1, dict2] for k, v in d.items()}
```

However, dictionary unpacking(PEP 448) may be a preferred.
```python
{**dict1, **dict2}
```


# 21.5 List Comprehensions with Nested Loops
`List Comprehensions` can use nested for loops. You can code any number of 
nested for loops within a list comprehension, and each for loop may have an
optional associated `if test`. When doing so, the order of the for constructs
is the same order as when writing a series of nested for statements. The 
general structure of list comprehensions looks like this:
```
[ expression for target1 in iterable1 [if condition1]
             for target2 in iterable2 [if condition2]...
             for targetN in iterableN [if conditionN] ]
```


For the sake of readability, however, you should consider using traditional for
loops. This is especially true when nesting is more than 2 levels deep, and/or
the logic of the comprehensions is too complex. Multiple nested loop list
comprehensions could be error prone or it gives unexpected result.


# 21.6 Generator Expressions
Generator expression are very simiar to list comprehensions. The main difference
is that it does not create a full set of results at once; it creates a generator
object which can then be iterated over.

For instance, see the difference in the following code:
```python
# list comprehension
[x**2 for x in range(10)]

# generator comprehension
(x**2 for x in range(10))
# Output: <generator object <genexpr> at 0x7f79b54cefc0
```

These are two very different objects:
- the list comprehension returns a list object whereas the generator comprehension
    return a generators.
- generator objects cannot be indexed and makes use of the next function to get
    items in order.

### Use cases
Generator expressions are lazily evaluated, which means that they generate and
return each value only when the generator is iterated. This is very useful when
iterating through large datesets, avoiding the need to create a duplicate of
the dataset in memory:
```python
for square in (x**2 for x in range(1000000)):
    # do something
```

Another common use case is to avoid iterating over an entire iterable if doning
so is not necessary. In this example, an item is retrived from a remote API
with each iteration of get_objects(). Thousands of objects may exist, must be
retrived one-by-one, and we only need to know if an object matching a pattern
exists. By using a generator expression, when we encounter an object matching
the pattern.


# 21.7 Set Comprehensions
Set comprehension is similar to list and dictionary comprehension, but it 
produces a set, which is an unordered collection of unique elements.
```python
# A set containing every value in range(5):
{x for x in range(5)}
# Output: {0, 1, 2, 3, 4}

# A set of even numbers between 1 and 10:
{x for x in range(1, 11) if x % 2 == 0}
# Output: {2, 4, 6, 8, 10}

# Unique alphabetic characters in a string of text:
text = "When in the Course of human events it becomes necessary for one people..."
{ch.lower() for ch in text if ch.isalpha()}
# Out: set(['a', 'c', 'b', 'e', 'f', 'i', 'h', 'm', 'l', 'o', 
#           'n', 'p', 's', 'r', 'u', 't', 'w', 'v', 'y']}
```

Keep in mind that sets are unordered. This means that the order of the results
in the set may differ from the one presented in the above examples.

Note: Set comprehension is available since python 2.7+, the `set()` function
can be used with a generator expression to produce the same result:

```python
set(x for x in range(5))
# Output: {0, 1, 2, 3, 4}
```


# 21.8 Refactoring filter and map to list comprehensions
The `filter` or `map` functions should often be replaced by `list comprehensions`
Guido Van Rossum describes this well in an `open letter in 2005`:
> filter(P, S) is almost always written clearer as `[x for x in S if P(x)]`, and
> this has the huge advantage that the most common usages involve predicates
> that are comparisons, e.g. `x==42`, and defining a lambda for that just 
> requires much more effort for the reader(plus the lambda is slower than the 
> list comprehension). Even more so for `map(F, S) which becomes 
> `[F(x) for x in S]`. Of course, in many cases you'd be able to use generator 
> expressions instead.

Taking what we have learned from the previous quote, we can break down these
filter and map expressions into their equivalent list comprehensions; also
removing the lambda functions from each-making the code more readable in the
process.

Readability becomes even more apparent when dealing with chaining functions.
```python
filtered = filter(lambda x: x % 2 == 0, range(10))
results = map(lambda x: 2*x, filtered)

# List comprehension
results = [2*x for x in range(10) if x % 2 == 0]
```


# 21.9 Comprehensions involving tuples
The for clause of a `list comprehension` can specify more than one variable.
```python
[x + y for x, y in [(1, 2), (3, 4), (5, 6)]]
# Output: [3, 7, 11]
[x + y for x, y in zip([1, 3, 5], [2, 4, 6])]
```

Note however, if the expression that begins the comprehension is a tuple then
it must be parenthesized:
```python
[x, y for x, y in [(1, 2), (3, 4), (5, 6)]]
# Syntax Error: invalid syntax

[(x, y) for x, y in [(1, 2), (3, 4), (5, 6)]]
# Output: [(1, 2), (3, 4), (5, 6)]
```


# 21.10 Counting Occurrences Using Comprehension
When we want to count the number of items in an iterable, that meet some 
conditions, we can use comprehension to produce an idiomatic syntax:

```python
# Count the numbers in `range(1000)` that are even and contain the digit `9`:
print(sum(
    1 for x in range(1000)
    if x % 2 == 0 and
    '9' in str(x)
))
```

Note: Here we are not collecting the 1s in a list(note the absence of square
brackets), but we are passing the ones direcyly to the sum function that is
summing them up. This is called a **generator expression**, which is similar
to a Comprehension.


# 21.11 Changing Types in a List
Quantitative data is often read in as strings that must be converted to numeric
types before processing. The types of all list items can be converted with
either a List Comprehension or the `map()` function.

```python
# Convert a list of strings to integers.
items = ['1', '2', '3', '4']
[int(item) for item in items]

map(float, items]
```


# 21.12 Nested List Comprehensions
Nested list comprehensions, unlike list comprehensions withe nested loops, are
List comprehensions within a list comprehension. The initial expression can be
any arbitrary expression, including another list comprehension.
```python
# List Comprehension with nested loop
[x + y for x in [1, 2, 3] for y in range(3, 6)]
# Output: [4, 5, 6, 5, 6, 7, 6,  7, 8]

# Nested list Comprehension
[[x + y for x in [1, 2, 3]] for y in [3, 4, 5]]
# Output: [[4, 5, 6], [5, 6, 7], [6, 7, 8]]
```

One example where a nested comprehension can be used to transpose a matrix.
```python
matrix = [[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]]

[row[i] for row in matrix] for i in range(len(matrix))]
```

Like nested for loops, there is no limit to how deep comprehensions can be nested.


# 21.13 Iterate two or more list simultaneously within list comprehension
For iterating more than two lists simultaneously within list comprehension, one
may use `zip()` as:
```python
list_1 = [1, 2, 3, 4, 5]
lsit_2 = ['a', 'b', 'c', 'd', 'e']
list_3 = ['6', '7', '8', '9', '10']

[(i, j) for i, j in zip(list_1, list_2)]

[(i, j, k) for i, j, k in zip(list_1, list_2, list_3)]
```


# Chapter 22: List Slicing(select parts of lists)
# 22.1 Using the third "step" argument
```python
lst = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']

list[::2]
# Output: ['a', 'c', 'e', 'g']


list[::3]
# Output: ['a', 'd', 'g']
```


# 22.2 Selecting a sublist from a list
```python
lst = ['a', 'b', 'c', 'd', 'e']

lst[2:4]
# Output: ['c', 'd']


lst[2:]
# Output: ['c', 'd', 'e']

lst[:4]
# Output: ['a', 'b', 'c', 'd']
```


# 22.3 Reversing a list with slicing
```python
a = [1, 2, 3, 4, 5]

# step through the list backwards (step=-1)
b = a[::-1]

# built-in list method to reverse 'a'
a.reverse()

if a == b:
    print(True)

print(b)

# Output:
# True
# [5, 4, 3, 2, 1]
```


# 22.4 Shifting a list using slicing
```python
def shift_list(array, s):
    """Shifts the elements of a list to the left or right'

    Args:
        array - the list to shift
        s - the amount to shift the list('+7': right-shift 7, '-3': left-shift 3)

    Returns:
        shifted_array - the shifted list
    """

    # calculate actual shift amount
    s %= len(array)

    # reverse the shift direction to be more intuitive
    s *= -1

    # shift array with list slicing
    shifted_array = array[s:] + array[:s]

    return shifted_array


my_array = [1, 2, 3 ,4, 5]

# negative numbers
shift_array(my_array, -7)
# Output: [3, 4, 5, 1, 2]

# no shift on numbers equal to the size of the array
shift_array(my_array, 5)
# Output: [1, 2, 3, 4, 5]


# positive numbers
shift_array(my_array, 7)
# Output: [3, 4, 5, 1, 2]
```


# Chapter 23: groupby()
| Parameter | Details                                            |
|-----------|----------------------------------------------------|
| iterable  | Any python iterable                                |
| key       | Function(criterial) on which to group the iterable |

In Python, the `itertools.groupby()` method allows developers to group values
of an iterable class based on a specified property into another iterable set of
values.


# 23.1 Example 1
```python
things = [("animal", "bear"), ("animal", "duck"), ("plant", "cactus"), ("vehicle", "harley"), \
          ("vehicle", "speed boat"), ("vehicle", "school bus")]
dic = {}
f = lambda x: x[0]
for key, group in groupby(sorted(things, key=f), f):
dic[key] = list(group)
print(dic)

# Output:
# {'animal':  [('animal', 'bear'), ('animal', 'duck')],
#  'plant':   [('plant', 'cactus')],
#  'vehicle': [('vehicle', 'harley'), ('vehicle', 'speed boat'),
#              ('vehicle', 'school bus')]}
```

The example below is essentially the same as the one above it. The only 
difference is that all tuples are changed to lists.

```python
things = [["animal", "bear"], ["animal", "duck"], ["plant", "cactus"], ["vehicle", "harley"], \
          ["vehicle", "speed boat"], ["vehicle", "school bus"]]
dic = {}
f = lambda x: x[0]
for key, group in groupby(sorted(things, key=f), f):
dic[key] = list(group)
print(dic)

# Output:
# {'animal':  [['animal', 'bear'], ['animal', 'duck']],
#  'plant':   [['plant', 'cactus']],
#  'vehicle': [['vehicle', 'harley'], ['vehicle', 'speed boat'],
#              ['vehicle', 'school bus']]}
```


# 23.2 Example 2
This example illustrates how the default key is chosen if we do not specify any
```python
c = groupby(['goat', 'dog', 'cow', 1, 1, 2, 3, 11, 10, ('persons', 'man', 'woman')])
dic = {}
for k, v in c:
    dic[k] = list(v)

print(dic)
# Outputs:
# {1: [1, 1],
#  2: [2],
#  3: [3],
#  ('persons', 'man', 'woman'): [('persons', 'man', 'woman')],
#  'cow': ['cow'],
#  'dog': ['dog'],
#  10: [10],
#  11: [11],
#  'goat': ['goat']}
```
Notice here that the tuple as a whole counts as one key in this list


# 23.3 Example 3
Notice in this example that mulato and camel don't show up in our result. Only
the last element with the specified key shows up. The last result for `c`
actually wipes out two previous results. But watch the new version where i
have the data sorted first on same key.

```python
list_things = ['goat', 'dog', 'donkey', 'mulato', 'cow', 'cat', ('persons', 'man', 'woman'), \
               'wombat', 'mongoose', 'malloo', 'camel']
c = groupby(list_things, key=lambda x: x[0])
dic = {}
for k, v in c:
    dic[k] = list(v)
print(dic)

# Results in
# {'c': ['camel'],
# 'd': ['dog', 'donkey'],
# 'g': ['goat'],
# 'm': ['mongoose', 'malloo'],
# 'persons': [('persons', 'man', 'woman')],
# 'w': ['wombat']}
```

Sorted Version
```python
list_things = ['goat', 'dog', 'donkey', 'mulato', 'cow', 'cat', ('persons', 'man', 'woman'), \
               'wombat', 'mongoose', 'malloo', 'camel']
sorted_list = sorted(list_things, key = lambda x: x[0])
print(sorted_list)
print()
c = groupby(sorted_list, key=lambda x: x[0])
dic = {}
for k, v in c:
    dic[k] = list(v)
print(dic)

Results in
# ['cow', 'cat', 'camel', 'dog', 'donkey', 'goat', 'mulato', 'mongoose', 'malloo', 
   ('persons', 'man', 'woman'), 'wombat']
# {'c': ['cow', 'cat', 'camel'],
# 'd': ['dog', 'donkey'],
# 'g': ['goat'],
# 'm': ['mulato', 'mongoose', 'malloo'],
# 'persons': [('persons', 'man', 'woman')],
# 'w': ['wombat']}
```


# Chapter 24: Linked Lists
A linked list is a collection of nodes, each made up of a reference and a value.
Nodes are strung together into a sequence using their references. Linked lists
can be used to implement more complex data structures like lists, stacks, queues,
and associative arrays.


# 24.1 Single linked list example
This example implemets a linked list with many of the same methods as that of
the built-in list object.
```python
class Node:
    def __init__(self, val):
        self.data = val
        self.next = None

    def get_data(self):
        return self.data

    def get_next(self):
        return self.next

    def set_data(self, val):
        self.data = val

    def set_next(self, val):
        self.next = val


class LinkedList:
    def __init__(self):
        self.head = None

    def is_empty(self):
        """Check if the list is empty"""
        return self.head is None

    def add(self, item):
        """Add the item to the list"""
        new_node = Node(item)
        new_node.set_next(self.head)
        self.head = new_node

    def size(self):
        """Return the length/size of the list"""
        count = 0
        current = self.head
        while current is not None:
            count += 1
            current = current.get_next()
        return count

    def search(self, item):
        """Search for item in list. If found, return True"""
        current = self.head
        found = False
        while current is not None and not found:
            if current.get_data() is item:
                return True
            else:
                current = current.get_next()
        return found


    def remove(self, item):
        """Remove item from list. If item is not found in list, raise ValueError"""
        current = self.head
        previous = None
        found = False
        while current is no None and not found:
            if current.get_data() is item:
                found = True
            else:
                previous = current
                current = current.get_next()
        if found:
            if previous is None:
                self.head = current.get_next()
            else:
                previous.set_next(current.get_next())
        else:
            raise ValueError
            print('Value not found')

    def insert(self, position, item):
        """
        Insert itme at position specified. If position specified is out of 
        bound, raise IndexError
        """
        if position > self.size() - 1:
            raise IndexError
            print('Index out of bounds')
        current = self.head
        previous = None
        pos = 0
        if position is 0:
            self.add(item)
        else:
            new_node = Node(item)
            while pos < position:
            pos += 1
            previous = current
            current = current.get_next()
        previous.set_next(new_node)
        new_node.set_next(current)

    def print_list(self):
        """Print the list"""
        current = self.head
        while current is not None:
            print(current.get_data())
            current = current.get_next()
```



# Chapter 25: Linked List Node

# 25.1 Write a simple Linked List Node in python
A linked list is either:
    - the empty list, represented by None, or
    - a node that contains a cargo object and a referrence to a linked list.

```python
class Node:
    def __init__(self, cargo=None, next=None):
        self.car = cargo
        self.next = next

    def __str__(self):
        return str(self.car)

    def display(lst):
        if lst:
            w("%s ' % lst)
            display(lst.cdr)
        else:
            w('nil\n')
```



# Chapter 26: Filter

# 26.1 Basic use of filter
To `filter` discards some elements of a sequence based on some criteria:
```python
names = ['Fred', 'Wilma', 'Barney']

def long_name(name):
    return len(name) > 5

# Python2.x
filter(long_name, names)
# Out: ['Barney']

[name for name in names if len(name) > 5] # equivalent list comprehension
# Out: ['Barney']


from itertools import ifilter
ifilter(long_name, names) # as generator(similar to Python3.x filter builtin)
# Out: <itertools.ifilter at 0x...>
list(ifilter(long_name, names)) # equivalent to filter with lists
# Out: ['Barney']

(name for name in names if len(name) > 5) # equivalent generator expression
# Out: <generator object <genexpr> at 0x...>


# Python3.x
filter(long_name, names) # return a generator
# Out: <filter at 0x...>
```


# 26.2 Filter without function
If the function parameter is None, then the identity function will be used.
```python
list(filter(None, [1, 0, 2, [], '', 'a'])) # discards 0, [] and ''
# Out: [1, 2, 'a']

[i for i in [1, 0, 2, [], '', 'a'] if i] # equivalent list comprehension
(i for i in [1, 0, 2, [], '', 'a'] if i) # equivalent generator expression
```


# 26.3 Filter as short-circuit check
`filter` (python3.x) and ifilter(python2.x) return a generator so they can be 
very handy when creating a short-circuit test like `or` or `and`
```python
# Python2.x
from itertools import ifilter
from future import filter

# To find the first element that is smaller than 100
car_shop = [('Toyota', 1000), ('rectangular_tire', 80), ('Porsche', 5000)]
def find_something_samller(name_value_tuple):
    print('Check {0}, {1}$'.format(*name_value_tuple))
    return name_value_tuple[1] < 100

next(filter(find_something_samller, car_shop))
# Print: Check Toyota, 1000$
#        Check rectangular_tire, 80$
# Out: ('rectangular_tire', 80)
```
**The next-function gives the next(in this case first) element of and is 
therefore the reason why it's short-circuit.**


# 26.4 Complementary function: filterfalse, ifilterfalse
There is a complementary function for `filter` in the itertools-module
```python
# Python2.x
from itertools import ifilterfalse
# Python 3.x
from itertools import filterfalse

# which works exactly like the generator `filter` but keeps only the elements
# that are `False`:

# Usage without function (None):
list(filterfalse(None, [1, 0, 2, [], '', 'a'])) # discards 1, 2 and 'a'
# Out: [0, [], '']

# Usage with function
names = ['Fred', 'Wilma', 'Barney']

def long_name(name)
    return len(name) > 5

list(filterfalse(long_name, names))
# Out: ['Fred', 'Wilma']

# Short-circuit usage with next:
car_shop = [('Toyota', 1000), ('rectangular_tire', 80), ('Porsche', 5000)]
def find_something_samller(name_value_tuple):
    print('Check {0}, {1}$'.format(*name_value_tuple))
    return name_value_tuple[1] < 100

next(filterfalse(find_something_samller, car_shop))
# Print: Check Toyota, 1000$
# Out: ('Toyota', 1000)

# Using an equivalent generator:
car_shop = [('Toyota', 1000), ('rectangular_tire', 80), ('Porsche', 5000)]
generator = (car for car in car_shop if not car[1] < 100)
next(generator)
```



# Chapter 27: Heapq

# 27.1 Largest and smallest item in a collection
To find the largest items in a collection, `heapq` module has a function called
`nlargest`, we pass it two arguments, the first one is the number of items that
we want to retrieve, the second one is the collection name:
```python
import heapq

numbers = [1, 4, 2, 100, 20, 50, 32, 200, 150, 8]
print(heapq.nlargest(4, numbers)) # [200, 150, 100, 50]

# Similarly, to find the smallest items in a collection, we use `nsmallest` 
# function:
print(heapq.nsmallest(4, numbers)) # [1, 2, 4, 8]
```

Both `nlargest` and `nsmallest` functions take an optional argument(key 
parameter) for complicated data structures. The following example shows
the use of `age` property to retrieve the oldest and the youngest people from
`people` list:
```python
people = [
    {'firstname': 'John', 'lastname': 'Doe', 'age': 30},
    {'firstname': 'Jane', 'lastname': 'Doe', 'age': 25},
    {'firstname': 'Janie', 'lastname': 'Doe', 'age': 10},
    {'firstname': 'Jane', 'lastname': 'Roe', 'age': 22},
    {'firstname': 'Johnny', 'lastname': 'Doe', 'age': 12},
    {'firstname': 'John', 'lastname': 'Roe', 'age': 45}
]

oldest = heapq.nlargest(1, people, key=lambda people: people['age'])
print(oldest)
# Out: [{'firstname': 'John', 'lastname': 'Roe', 'age': 45}]
youngest = heapq.nsmallest(1, people, key=lambda people: people['age'])
print(yougest)
```


# 27.2 Smallest item in a collection
The most interesting property of a heap is that its smallest element is alwayss
the first element: heap[0]
```python
import heapq

numbers = [10, 4, 2, 100, 20, 50, 32, 200, 150, 8]

heapq.heapify(numbers)
print(numbers)
# Out: [2, 4, 10, 100, 8, 50, 32, 200, 150, 20]

heapq.heappop(numbers) # Out: 2
print(numbers)
# Out: [4, 8, 10, 100, 20, 50, 32, 200, 150]

heapq.heappop(numbers) # Out: 4
print(numbers)
# Out: [8, 20, 10, 100, 150, 50, 32, 200]
```



# Chapter 28: Tuple
A tuple is an immutable list of value. Tuples are one of Python's Simplest and
most common collection types, and can be create with the comma operator(
value = 1, 2, 3).


# 28.1 Tuple
Syntactically, a tuple is a comma-separated list of values:
```python
t = 'a', 'b', 'c', 'd', 'e'
```

Although not necessary, it is common to enclose tuples in parentheses:
```python
t = ('a', 'b', 'c', 'd', 'e')
```

Create an empty tuple with the parentheses:
```python
t0 = ()
type(t0) # < type 'tuple'>
```

To create a tuple with single element, you have to include a final comma:
```python
t1 = ('a',)
type(t1) # < type 'tuple'>
```

Note that a single value in parentheses is not a tuple:
```python
t2 = ('a')
type(t2) # < type 'str'>
```

Another way to create a tuple is the built-in function `tuple`.
```python
t = tuple('lupins')
print(t) #('l', 'u', 'p', 'i', 'n', 's')
t = tuple(range(3))
print(t) #(0, 1, 2)
```


# 28.2 Tuples are immutable
One of the main differences between lists and tuples in Python is that tuples
are immutable, that is , one cannot add or modify items once the tuple is 
initialized. For example:
```python
t = (0, 1, 2)
t[0] = 2
# TypeError: 'tuple' object does not support item assignment
```

Similarly, tuples don't have .append and .extend methods as list does. Using
+= is possible, but it changes the binding of the variable, and not the tuple
itself:
```python
t = (1, 2)
q = t
t += (3, 4)'
print(t)
# (1, 2, 3, 4)
print(q)
# (1, 2)
```

Be careful when placing mutable objects, such as lists, inside tuples. This may
lead to very confusing outcomes when changing them. For example:
```python
t = (1, 2, 3, [1, 2, 3])
t[3] += [4, 5]
```
Will both raise an error and change the contents of the list within the tuple:
```
TypeError:
>>>t
(1, 2, 3, [1, 2, 3, 4, 5])
```
You can use the `+=` operator to "append" to a tuple-this works by creating a
new tuple with the new element you "appended" and assign it to it's current
variable; the old tuple is not changed, but replaced!


# 28.3 Packing and Unpacking Tuples
Tuples in Python are values separated by commas. Enclosing parentheses for
inputting tuples are optional, so the following two assignments are equivalent.
```python
a = 1, 2, 3
             # a is the tuple (1, 2, 3)
a = (1, 2, 3)
```
The assignment `a = 1, 2, 3` is also called **packing** because it packs values
together in a tuple.

Note that a one-value tuple is also a tuple. To tell Python that a variable is
tuple and not a single value you can use a trailing comma
```python
a = 1 
a = 1, # a is the tuple (1,)
```
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
