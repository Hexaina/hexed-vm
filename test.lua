Stack = {}

Mem = {}

function Push(x)
    table.insert(Stack, 1, x)
end
function Pop()
    return table.remove(Stack, 1)
end

Inst = {
    push = function(x) Push(x) end,
    print = function() print(Pop()) end,
    add = function() Push(Pop()+Pop()) end,
    sub = function() Push(Pop()-Pop()) end,
    mul = function() Push(Pop()*Pop()) end,
    div = function() Push(Pop()/Pop()) end,
    ttswap = function() Push(table.remove(Stack, 2)) end,
    topdupe = function(i) local x = Pop(); for n = 0, i do Push(x) end end,
    popvar = function(name) Mem[name] = Pop() end,
    setvar = function(m) local name = m[1]; local val = m[2]; Mem[name] = val end,
    varcopy = function(name) Push(Mem[name]) end,





}

Program = {
    {inst = "setvar", args = {"x", "hi"}},
    {inst = "varcopy", args = "x"},
    {inst = "print"},
}

function Switch(v, x)

    Inst[v](Program[x].args)

end

for x = 1, #Program do

    Switch(Program[x].inst, x)

end

