## basic instrustions

### push/1
pushes the argument onto the stack
```{inst = "push", args = 6},``` (this pushes number 6 onto the stack)

### print/0
pops the top value of the stack and prints it out
```
{inst = "push", args = "hello world"},
{inst = "print"},
```
this program prints "hello world"

### stread/0
reads a line from the standard input and pushes that value onto the stack
```
{inst = "stread"},
{inst = "print"}",
```
this is a cat program, it reads an input and repeats it

# Under construction