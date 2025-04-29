defmodule Stack do

    defstruct items: []

    def return(item), do: %Stack{items: [item]}

    def bind(%Stack{items: [item | rest]} = stack, func) do
        %Stack{items: [func.(item) | rest]}
    end

    def push(%Stack{items: items}, item) do
        %Stack{items: [item | items]}
    end

    def pop(%Stack{items: [item | rest]}) do
        {item, %Stack{items: rest}}
    end

end

defmodule Inst do

    def push(val) do
        Stack.push(val)
    end

    def pop() do
        Stack.pop()
    end

    def print(val) do
        IO.puts(val)
    end

end

program = [ %{inst: :push, args: 6}, %{inst: :print, args: Stack.pop()}]

Enum.map(program, fn x ->
    case x.inst do
        :push -> Inst.push(x.args)
        :print -> Inst.print(x.args)
    end
end)
