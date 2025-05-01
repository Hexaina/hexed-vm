HLTS, or HexedvmLuaTableSyntax is currently the only way to write hexedVm instructions 
we will go over their structure and how to write it

## 1 - where to write HLTS
to write HLTS, you will need a copy of the hexedVm lua source
you will be writing HLTS in the "Program" table

## 2 - structure
the structure of all HLTS instructions is as follows
```{inst = "instruction", args = arguments},```
there are three types of instruction, instrucitons that take no arguments (/0), one argument (/1), or mulitple arguments (/2 or more)

### none
for instrucitons with no arguments, do not add the args value into the table
for example, stadd looks like this
```{inst = "stadd"},```

### one
for instructions with one argument, add the args value as a lua primitive
for example, varcopy
```{inst = "varcopy", args = "myVariable"},```

### multiple
for instructions with multiple arguments, add the args value as a table
put the arguments you want to pass into the table, seperated by commas
for example, setvar
```{inst = "setvar", args = {"name", value}},```

that will be it
for the instructions themselfs, go to "instruction guide (in HLTS).md"