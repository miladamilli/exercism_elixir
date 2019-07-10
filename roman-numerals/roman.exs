defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @roman %{4 => {"M", nil, nil}, 3 => {"C", "D", "M"}, 2 => {"X", "L", "C"}, 1 => {"I", "V", "X"}}

  @spec numerals(pos_integer) :: String.t()
  def numerals(number) when number < 4000 do
    number
    |> Integer.digits()
    |> do_numerals()
    |> List.to_string()
  end

  def numerals(_number), do: "The Romans can't count this high!"

  defp do_numerals([]), do: []

  defp do_numerals([n | rest] = number) do
    [roman(n, @roman[length(number)]) | do_numerals(rest)]
  end

  defp roman(0, _), do: []
  defp roman(n, {n1, _n2, _n3}) when n in 1..3, do: List.duplicate(n1, n)
  defp roman(4, {n1, n2, _n3}), do: [n1 | n2]
  defp roman(n, {n1, n2, _n3}) when n in 5..8, do: [n2 | List.duplicate(n1, rem(n, 5))]
  defp roman(9, {n1, _n2, n3}), do: [n1 | n3]

end
