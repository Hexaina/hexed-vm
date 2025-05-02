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

## arithmatic oporators

### stadd/0
pops the top two values off the stack and pushes the sum
```{inst = "stadd"},```

### stsub/0
pops the top two values off the stack and pushes the differnce (first pop is the right of the equation)
```{inst = "stsub"},```

### stmul/0
pops the top two values off the stack and pushes the product
```{inst = "stmul"},```

### stdiv/0
pops the top two values off the stack and pushes the quotient (pushes a floating point number, first pop is the right of the equation)
```{inst = "stdiv"},```

### stmod/0
pops the top two values off the stack and pushes the remainder (first pop is the right of the equation)
```{inst = "stmod"},```

## boolian oporations

### stequal/0
pops the top two values off the stack and pushes true if they are equal, and false if they are not
```{inst = "stequal"},```

### stnotequal/0
pops the top two values off the stack and pushes false if they are equal, and true if they are not
```{inst = "stnotequal"},```

### stgreater/0
pops the top two values off the stack and pushes true if the first value is greater than the second, and false otherwise
```{inst = "stgreater"},```

### stless/0
pops the top two values off the stack and pushes true if the first value is less than the second, and false otherwise
```{inst = "stless"},```

### stnot/0
pops the top value off the stack and pushes true if its false, and pushes false if its true (there is curently no error message for not passing in non booleans for all boolean oporations)
```{inst = "stnot"},```

### stand/0
pops the top two values off the stack and pushes true if both are true, and pushes false otherwise
```{inst = "stand"},```

### stor/0
pops the top two values off the stack and pushes true if at least one is true, and pushes false otherwise
```{inst = "stor"},```

### stor/0
pops the top two values off the stack and pushes true if at least one is true, and pushes false otherwise
```{inst = "stor"},```

### stnand/0
pops the top two values off the stack and pushes false if both are true, and pushes true otherwise
```{inst = "stnand"},```

### stnor/0
pops the top two values off the stack and pushes flase if at least one is true, and pushes true otherwise
```{inst = "stnor"},```

### stxor/0
pops the top two values off the stack and pushes true if only one is true, and pushes flase otherwise
```{inst = "stxor"},```

### stxnor/0
pops the top two values off the stack and pushes false if only one is true, and pushes true otherwise
```{inst = "stxnor"},```

## stack manipulation

### ttswap/0
swaps the top two values of the stack
```{inst = "ttsawp"},```

### topdupe/1
dupelicates the top value of the stack equal to the input. passing 0 results in the top value being deleted
```{inst ="topdupe", args = int},```

## variables

# under construction