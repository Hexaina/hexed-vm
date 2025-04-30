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
    stread = function() Push(io.stdin:read()) end,
    add = function() Push(Pop()+Pop()) end,
    sub = function() Push(Pop()-Pop()) end,
    mul = function() Push(Pop()*Pop()) end,
    div = function() Push(Pop()/Pop()) end,
    mod = function() Push(Pop()%Pop()) end,
    stequal = function() 
        local x = Pop(); 
        local y = Pop(); 
        if x == y then Push(true) else Push(false) end
    end,
    stnotequal = function() 
        local x = Pop(); 
        local y = Pop(); 
        if x ~= y then Push(true) else Push(false) end
    end,
    stgreater = function() 
        local x = Pop(); 
        local y = Pop(); 
        if x > y then Push(true) else Push(false) end
    end,
    stless = function() 
        local x = Pop(); 
        local y = Pop(); 
        if x < y then Push(true) else Push(false) end
    end,
    stand = function() Push(Pop() and Pop()) end,
    stor = function() Push(Pop() or Pop()) end,
    stnot = function() Push(not Pop()) end,
    stnand = function() Push(not Pop() and Pop()) end,
    stnor = function() Push(not Pop() or Pop()) end,
    stxor = function() local x = Pop(); local y = Pop(); Push((x and not y) or (not x and y)) end,
    stxnor = function() local x = Pop(); local y = Pop(); Push((x and y) or (not x and not y)) end,
    ttswap = function() Push(table.remove(Stack, 2)) end,
    topdupe = function(i) local x = Pop(); for n = 0, i do Push(x) end end,
    popvar = function(name) Mem[name] = Pop() end,
    setvar = function(m) local name = m[1]; local val = m[2]; Mem[name] = val end,
    varcopy = function(name) Push(Mem[name]) end,
    delvar = function(name) table.remove(Mem[name]) end,
    call = function(name)
        
        local proc = Mem[name]
        --func is {code}
        for x = 1, #proc do
            
            Inst[proc[x].inst](proc[x].args)
        
        end
    end,
    stexe = function()
        local code = Pop()
        
        for x = 1, #code do
            Inst[code[x].inst](code[x].args)
        end
    end,
    loopfor = function(m)
        local i = m[2]
        Mem[m[1]] = i
        local max = m[3]
        local inc = m[4]
        local code = m[5]

        for i = i, max, inc do
            for x = 1, #code do
                Inst[code[x].inst](code[x].args)
            end
            Mem[m[1]] = i
        end
    end,
    stif = function(code)
        local bool = Pop()
        if bool then
            for x = 1, #code do
                Inst[code[x].inst](code[x].args)
            end
        end
    end,
    stifelse = function(code)
        local bool = Pop()
        local trcode = code[1]
        local flcode = code[2]
        if bool then
            for x = 1, #trcode do
                Inst[trcode[x].inst](trcode[x].args)
            end
        else
            for x = 1, #flcode do
                Inst[flcode[x].inst](flcode[x].args)
            end
        end
    end,
}

Program = {
    
    {inst = "push", args = false},
    {inst = "stifelse", args =  {{
        {inst = "push", args = "hello"},
        {inst = "print"},
    }, {
        {inst = "push", args = "bye"},
        {inst = "print"},
    }}},

}

function Switch(v, x)

    Inst[v](Program[x].args)

end

for x = 1, #Program do

    Switch(Program[x].inst, x)

end

