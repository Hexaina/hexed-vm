Stack = {}

function Push(x)
    table.insert(Stack, 1, x)
end
function Pop()
    return table.remove(Stack, 1)
end

Inst = {
    push = function(x) Push(x) end,
    print = function() print(Pop()) end,
    stadd = function() Push(Pop()+Pop()) end,
    aradd = function(x, y) Push(x+y) end,
    stsub = function() Push(Pop()-Pop()) end,
    arsub = function(x, y) Push(x-y) end,
    stmul = function() Push(Pop()*Pop()) end,
    armul = function(x, y) Push(x*y) end,
    stdiv = function() Push(Pop()/Pop()) end,
    ardiv = function(x, y) Push(x/y) end,
}

Program = {
    {inst = "push", args = "hello"},
    {inst = "print"}
}

for x = 1, #Program do
    local z = Program[x]
    local inst = z.inst

    if inst == "push" then
        Inst.push(z.args)
    elseif inst == "print" then
        Inst.print()
    elseif inst == "stadd" then
        Inst.stadd()
    elseif inst == "aradd" then
        Inst.aradd(z.args[1], z.args[2])
    elseif inst == "stsub" then
        Inst.stsub()
    elseif inst == "arsub" then
        Inst.aradd(z.args[1], z.args[2])
    

    end

end

