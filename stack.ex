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
