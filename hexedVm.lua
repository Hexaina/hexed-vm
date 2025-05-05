local filename = arg[1] or "program.hxlt.lua"
Program = dofile(filename)

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
    sub = function() local x = Pop(); local y = Pop(); Push(y-x) end,
    mul = function() Push(Pop()*Pop()) end,
    div = function() local x = Pop(); local y = Pop(); Push(y/x) end,
    mod = function() local x = Pop(); local y = Pop(); Push(y%x) end,
    stequal = function() 
        local x = Pop(); 
        local y = Pop(); 
        if y == x then Push(true) else Push(false) end
    end,
    stnotequal = function() 
        local x = Pop(); 
        local y = Pop(); 
        if y ~= x then Push(true) else Push(false) end
    end,
    stgreater = function() 
        local x = Pop(); 
        local y = Pop(); 
        if y > x then Push(true) else Push(false) end
    end,
    stless = function() 
        local x = Pop(); 
        local y = Pop(); 
        if y < x then Push(true) else Push(false) end
    end,
    stand = function() Push(Pop() and Pop()) end,
    stor = function() Push(Pop() or Pop()) end,
    stnot = function() Push(not Pop()) end,
    stnand = function() Push(not Pop() and Pop()) end,
    stnor = function() Push(not Pop() or Pop()) end,
    stxor = function() local x = Pop(); local y = Pop(); Push((x and not y) or (not x and y)) end,
    stxnor = function() local x = Pop(); local y = Pop(); Push((x and y) or (not x and not y)) end,
    ttswap = function() Push(table.remove(Stack, 2)) end,
    stdupe = function(i) local x = Pop(); for n = 0, i do Push(x) end end,
    stclear = function() Stack = {} end,
    popvar = function(name) Mem[name] = Pop() end,
    setvar = function(m) local name = m[1]; local val = m[2]; Mem[name] = val end,
    varcopy = function(name) Push(Mem[name]) end,
    delvar = function(name) Mem[name] = nil end,
    pushvector = function(m)
        local arr = {type = "vector", contents = m}
        Push(arr)
    end,
    addvector = function()
        local arr1 = Pop()
        local arr2 = Pop()
        if arr1.type == "vector" and arr2.type == "vector" then
            local con1 = arr1.contents
            local con2 = arr2.contents
            local length = 0
            if #con1 >= #con2 then length = #con1 else length = #con2 end
            local arr = {}
            for i = 1, length do
                local x = con1[i] + con2[i]
                table.insert(arr, x)
            end
            local fin = {type = "vector", contents = arr}
            Push(fin)
        else
            error("addvector expects two vectors")
        end
    end,
    stvectorindex = function() local index = Pop(); local arr = Pop(); Push(arr); Push(arr.contents[index]) end,
    pushmap = function(m)
        for k, _ in pairs(m) do
            if type(k) == "number" then
                error("Map keys must be non-numeric")
            end
        end
        local arr = {type = "map", contents = m}
        Push(arr)
    end,
    stmapget = function() local name = Pop(); local map = Pop(); Push(map); Push(map.contents[name]) end,
    stmapset = function() local name = Pop(); local val = Pop(); local map = Pop(); map.contents[name] = val; Push(map); end,
    proccall = function(name)
        
        local code = Mem[name]
        --func is {code}
        for x = 1, #code do
            
            Inst[code[x].inst](code[x].args)
        
        end

    end,
    stexe = function()
        local code = Pop()
        
        for x = 1, #code do
            Inst[code[x].inst](code[x].args)
        end
    end,
    stnewthread = function(name) local code = Pop(); Mem[name] = coroutine.create(function()
        for x = 1, #code do
            Inst[code[x].inst](code[x].args)
        end
    end) end,
    threadpause = function() coroutine.yield() end,
    threadresume = function(name) coroutine.resume(Mem[name]) end,
    loopfor = function(m)
        local i = m[2]
        local name = m[1]
        Mem[name] = i
        local max = m[3]
        local inc = m[4]
        local code = m[5]

        for i = i, max, inc do
            Mem[m[1]] = i
            for x = 1, #code do
                Inst[code[x].inst](code[x].args)
            end
        end
        Mem[name] = nil
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
    stwhile = function(code)
        
        local bool = Pop()
        while bool do
            for x = 1, #code do
                Inst[code[x].inst](code[x].args)
            end
            bool = Pop()
        end
    end
}

function Switch(v, x)

    Inst[v](Program[x].args)

end

for x = 1, #Program do

    Switch(Program[x].inst, x)

end
