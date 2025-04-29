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
}

Program = {
    {inst = "push", args = 6},
    {inst = "push", args = 6},
    {inst = "stadd"},
    {inst = "print"},
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
    end

end

