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

# Chapter 14:

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
