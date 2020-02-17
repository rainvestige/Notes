# Variable Assinment
```
a_name = an_object # "a_name" is now a name for the reference to the object 
                     "an_object"
```

#
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


