# Chapter 86 Recursion

### 86.1 The What, How, and When of Recursion

Recursion occurs when a function call causes that same function to be called
again before the original function call terminates. For example, consider the 
well-known mathematical expression `x!`(i.e. the factorial operation). The 
factorial operation is defined for all nonnegative integers as follows:
- If the number is 0, then the answer is 1.
- Otherwise, the answer is that number times the factorial of one less that 
    number.

In Python, a naive implementation of the factorial operation can be defined as
a function as follows:
```python
>>> def factorial(n):
...     if n == 0:
...         return 1
...     else:
...         return n * factorial(n-1)
...
>>> factorial(10)
3628800
>>> factorial(1)
1
>>> factorial(0)
1
>>> factorial(3)
6
>>> factorial(5)
120
```

Recursion functions can be difficult to grasp sometimes, so let's walk through 
this step-by-step. Consider the expression `factorial(3)`. This and all 
function calls create a new **environment**. An environment is basically just
a table that maps identifiers(e.g. n, factorial, print, etc.) to their 
corresponding values. At any point in time, you can access the current 
environment using `locals()`. In the first function call, the only local 
variable that gets defined is `n=3`. Therefore, print `locals()` would show
`{'n': 3}`. Since `n == 3`, the return value becomes `n * factorial(n-1)`.

At this next step is where things might get a little confusing. Looking at our
new expression, we already know what n is. However, we don't yet know what
factorial(n-1) is. First, n-1 evaluates to 2. Then, 2 is passed to factorial as
the value n. Since this is a new function call, a second environment is created
to store this new n. Let A be the first environment and B be the second 
environment. A still exists and equals `{'n': 3}`, however, B(which equals `
{'n': 2}`) is the current environment. Looking at the function body, the return
value is, again, `n * factorial(n-1)`. Without evaluating this expression, 
let's substitute it into the original return expression. By doing this, we're
mentally discarding B, so remember to substitute n accordingly(i.e. references
to B's n are replaced with `n - 1` which uses A's n).

The statement `if n == 0: return 1` is called a base case. This is because, it\
exhibits no recursion. A base case is absolutely required. Without one, you'll
run into infinite recursion. With that said, as long as you have at least one
base case, you can hae as many cases as you want. For example, we could have 
equivalently written `factorial` as follows:
```python
def factorial(n):
    if n == 0:
        return 1
    elif n == 1:
        return 1
    else:
        return n * factorial(n - 1)
```

You may also have multiple recursion cases, but we won't get into that since
it's relatively uncommon and is often difficult to mentally process.

You can also have "parallel" recursive function calls. For example, consider 
the `Fibonacci sequence` which is defined as follows:
- If the number is 0, then the answer is 0.
- If the number is 1, then the answer is 1.
- Otherwise, the answer is the sum of the previous two Fibonacci numbers.

We can define this as follows:
```python
>>> def fibonacci(n):
...     if n == 0 or n == 1:
...         return n
...     else:
...         return fibonacci(n-1) + fibonacci(n-2)
...
>>> fibonacci(3)
2
```

Now, let's cover a few more vocabulary terms:
- A `tail call` is simply a recursive function call which is the last operation
    to be performed before returning a value. To be clear, `return foo(n-1)` is
    a tail call, but `return foo(n-1) + 1` is not9since the addition is the 
    last operation).

- **Tail call optimization(TCO)** is a way to automatically reduce recursion in
    recursive functions.

- **Tail call elimination(TCE)** is the reduction of a tail call to an 
    expression that can be evaluated without recursion. TCE is a type of TCO.


Tail call optimization is helpful for a number ofreasons:
- The interpreter can minimize the amount of memory occupied by environments. 
    Since no computer has unlimited memory, excessive recursive function calls
    would lead to a `stack overflow`

- The interpreter can reduce the number of `stack frame` switches.


Python has no form of TCO implemented for `a number of a reasons`. Therefore, 
other  techniques are required to skirt this limitation. The method of choice
depends on the use case. With some intuition, the definitions of `factorial and
fibonacci` can relatively easily be converted to iterative code as follows:

```python
def factorial(n):
    product = 1
    while n > 1:
        product *= n
        n -= 1
    return product

def fib(n):
    a, b = 0, 1
    while n > 0:
        a, b = b, a + b
        n -= 1
    return a
```

This usually the most efficient way to manually eliminate recursion, but it can
become rather difficult for more complex functions.

Another useful tool is Python's `lru_cache` decorator which can be used to 
reduce the number of redundant calculations.

You now have an idea as to how to avoid recursion in Python, but when should 
you use recursion? The answer is "not often". All recursive functions can be
implemented iteratively. It's simply a matter of figuring out how to do so.
However, there are rare cases in which recursion is okay. Recursion is common
in Python when the expected inputs wouldn't cause a significant number of a 
recursive function calls.

If recursion is a topic that interests you, I implore you to study functional
languages such as Scheme or Haskell. In such languages, recursion is much more
useful.

Please note that the above example for the Fibonacci sequence, although good
at showing how to apply the definition in python and later use of the lru 
cache, has an inefficient running time since it makes 2 recursive calls for 
each non base case. The number of calls to the function grows exponentially to
n. Rather non-intuitively a more efficient implementation would use linear 
recursion:

```python
def fib(n):
    if n <= 1:
        return (n, 0)
    else:
        (a, b) = fib(n-1)
        return (a+b, a)
```
But that one has the issue of returning a pair of numbers. This emphasizes
that some functions really do not gain much from recursion.



### 86.2 Tree exploration with recursion
Say we have the following tree:
``` 
root
- A
  - AA
  - BB
- B
  - BA
  - BB
    - BBA
```

Now, if we wish to list all the names of the elements, we could do this with a
simple for-loop. We assume there is a function `get_name()` to return a string
of the name of a node, a function `get_children()` to return a list of all the
sub-nodes of a given mode in the tree, and a function `get_root(0` to get the 
root node.
```python
root = get_root(tree)
for node in get_children(root):
    print(get_name(node))
    for child in get_children(node):
        print(get_name(child))
        for grand_child in get_children(child):
            print(get_name(grand_child))
# print: A, AA, AB, B, BA, BB, BBA
```

This works well and fast, but what if the sub-nodes, got sub-nodes of its own?
And those sub-nodes might have more sub-nodes... What if you don't know 
beforehand how many there will be? A method to solve this is the use of 
recursion.

```python
def list_tree_name(node):
    for child in get_children(node):
        print(get_name(child))
        list_tree_names(node=child)


list_tree_name(node=get_root(tree))
# print: A, AA, AB, B, BA, BB, BBA
```

Perhaps you wish to not print, but return a flat list of all node names. This
cab be done by passing a rolling list as a parameter.

```python
def list_tree_names(node, lst=[]):
    for child in get_children(node):
        lst.append(get_name(child))
        list_tree_name(node=child, lst=lst)
    return lst


list_tree_name(node=get_root(tree))
# returns ['A', 'AA', 'AB', 'B', 'BA', 'BB', 'BBA']
```



### 86.3 Sum of numbers from 1 to n
If i wanted to find out the sum of numbers from 1 to n where n is a natural 
number, I can do `1+2+3+...+(several hours later) + n`. Alternatively, I could
write a for loop:
```python
n = 0
for i in range(1, n+1):
    n += i

# Or I could use a technique known as recursion:
def recursion(n):
    if n == 1:
        return 1
    return n + recursion(n-1)
```

Recursion has advantages over the above two methods. Recursion takes less time
than writing out `1+2+3` for a sum from 1 to 3. For `recursion(4)`, recursion
can be used to work backwards, whereas the `for` loop is working strictly 
forward. Sometimes the recursive solution is simpler than the iterative solution.
This is evident when implementing a reversal of a linked list.



### 86.4 Increasing the Maximum Recursion Depth
There is a limit to the depth of possible recursion, which depends on the 
Python implementation. When the limit is reached, a RuntimeError exception is
raised:
```python
>>> def cursing(depth):
...     try:
...         cursing(depth + 1)
...     except RuntimeError as RE:
...         print(f'I recursed {depth} times!')
...
>>> cursing(0)
I recursed 998 times!
>>> cursing(0)
I recursed 998 times!
>>> import sys
>>> sys.getrecursionlimit()
1000
>>> sys.setrecursionlimit(2000)
>>> cursing(0)
I recursed 1998 times!
```



### 86.5 Tail Recursion - Bad Practice
When the only thing returned from a function is a recursive call, it is refered
to as tail recursion. Here's an example countdown written using tail recursion:
```python
>>> def countdown(n):
...     if n == 0:
...         print('Blastoff')
...     else:
...         print(n)
...         countdown(n-1)
...
>>> countdown(5)
5
4
3
2
1
Blastoff
```
Any computation that can be made using iteration can also be made using 
recursion. Here is a version of `find_max_written` using tail recursion:
```python
>>> def find_max(seq, max_so_far):
...     if not seq:
...         return max_so_far
...     if max_so_far < seq[0]:
...         return find_max(seq[1:], seq[0])
...     else:
...         return find_max(seq[1:], max_so_far)
...
>>> find_max([2, 1, 89, 43, 123, 98], 0)
123
```

Tail recursion is considered a bad practice in Python, since the Python 
compiler does not handle optimization for tail recursive calls. The recursive
solution in cases like this use more system resources than the equivalent 
iterative solution.



### 86.6 Tail Recursion Optimization Through Stack Introspection
By default Python's recursion stack cannot exceed 1000 frames. This can be 
changed by setting the `sys.setrecursionlimit(15000)` which is faster however, 
this method consumes more memory. Instead, we can also solve the Tail Recursion
problem using stack introspection.
```python

```



# Chapter 87 Type Hints

### 87.1 Adding types to a function
Let's take an example of a function which receives two arguments and returns a
value indicating their sum:
```python
def two_sum(a, b):
    return a + b
```

By looking at this code, one can not safely and without doubt indicate the type
of the arguments for function `two_sum`. It works both when supplied with int 
value:
```python
print(two_sum(2, 1)) # result: 3
#and with strings:
print(two_sum("a", "b")) # result: "ab"
```
and with other values, such as list s, tuple s et cetera.

Due to this dynamic nature of python types, where many are applicable for a 
given operation, any type checker would not be able to reasonably assert 
whether a call for this function should be allowed or not.

To assist our type checker we can now provide type hints for it in the Function
definition indicating the type that we allow.

To indicate that we only want to allow `int` types we can change our funciton 
definition to look like:
```python
def two_sum(a:int, b:int):
    return a + b
```

Annotations follow the argument name and are separated by a : character.

Annotations follow the argument name and are separated by a : character.
Similarly, to indicate only str types are allowed, we'd change our function to specify it:
```python
def two_sum(a: str, b: str):
    return a + b
```

Apart from specifying the type of the arguments, one could also indicate the 
return value of a function call. This is done by adding the -> character 
followed by the type after the closing parenthesis in the argument list but 
before the : at the end of the function declaration:
```python
def two_sum(a: int, b: int) -> int:
    return a + b
```
Now we've indicated that the return value when calling `two_sum` should be of 
type int . Similarly we can deﬁne appropriate values for str , float , list , 
set and others. 

Although type hints are mostly used by type checkers and IDEs, 
sometimes you may need to retrieve them. This can be done using the 
`__annotations__` special attribute
