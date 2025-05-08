function tokenise(input)
    local tokens = {}
    -- This pattern captures words, brackets, and content within brackets
    for token in string.gmatch(input, "%S+") do
        if token:sub(1, 1) == "[" and token:sub(-1, -1) == "]" then
            -- If the token is a complete bracketed expression, add it as is
            table.insert(tokens, token)
        else
            -- Split the token into parts if it contains brackets
            local start_idx, end_idx = token:find("[%[%]]")
            if start_idx then
                -- If there's a bracket, split the token
                local before_bracket = token:sub(1, start_idx - 1)
                local bracket_content = token:sub(start_idx, end_idx)
                local after_bracket = token:sub(end_idx + 1)

                -- Add parts to tokens
                if #before_bracket > 0 then
                    table.insert(tokens, before_bracket)
                end
                table.insert(tokens, bracket_content)
                if #after_bracket > 0 then
                    table.insert(tokens, after_bracket)
                end
            else
                -- Otherwise, just add the token
                table.insert(tokens, token)
            end
        end
    end
    return tokens
end

function parse(tokens)
    local out = {}
    local temp = {}
    local inex = false
    local first = true
    for index, token in ipairs(tokens) do
        if token == "[" then
            inex = true
        elseif token == "]" then
            inex = false
            table.insert(out, temp)
            temp = {}
        else
            if first == true then 
                temp.inst = token
            else
                if #temp < 2 then
                    temp.args = token
                else
                    local args = {temp.args}
                    local tokentable = {token}
                    table.insert(args, tokentable)
                    temp.args = args
                end
            end
        end
    end
    return out
end

function comp(inp)
    return parse(tokenise(inp))
end



-- Function to convert a table to a string representation
local function tableToString(tbl)
    local result = "{\n"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result .. string.format("  [%q] = ", k) -- Quote string keys
        else
            result = result .. string.format("  [%d] = ", k) -- Numeric keys
        end

        if type(v) == "table" then
            result = result .. tableToString(v) -- Recursive call for nested tables
        elseif type(v) == "string" then
            result = result .. string.format("%q", v) -- Quote string values
        else
            result = result .. tostring(v) -- Convert other types to string
        end

        result = result .. ",\n"
    end
    result = result .. "}"
    return result
end
-- Function to write the table to a Lua file
local function writeTableToFile(filename, tbl)
    local file = io.open(filename, "w") -- Open the file in write mode
    if not file then
        error("Could not open file for writing: " .. filename)
    end

    -- Write the table to the file
    file:write("return " .. tableToString(tbl))
    file:close()
end

filename = arg[1]
local file = io.open(filename, "r")
if not file then
    print("Could not open file")
    return
end

Program = file:read("*all")

Program = comp(Program)

writeTableToFile("out.hxlt.lua", Program)