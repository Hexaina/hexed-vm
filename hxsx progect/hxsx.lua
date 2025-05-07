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
    for index, token in ipairs(tokens) do
        local tab = {inst = token}
        table.insert(out, tab)
    end

    return out
end

function comp(inp)
    return parse(tokenise(inp))
end

things = comp("[push 'hi'][print]")
for x, thing in ipairs(things) do
    for z, thingx in ipairs(thing) do
        print(thingx)
    end
end