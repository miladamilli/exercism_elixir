defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean
  def chain?([]) do
    true
  end

  def chain?([{first, last} | dominoes]) do
    chain?(first, last, dominoes, [])
  end

  defp chain?(first, last, [], []) do
    first == last
  end

  defp chain?(_first, _last, [], _unused) do
    false
  end

  defp chain?(first, last, [stone | dominoes], unused) do
    if check_chain(first, last, stone, dominoes ++ unused) do
      true
    else
      chain?(first, last, dominoes, [stone | unused])
    end
  end

  defp check_chain(first, last, {left, right} = _stone, dominoes) do
    cond do
      last == left -> chain?(first, right, dominoes, [])
      last == right -> chain?(first, left, dominoes, [])
      true -> false
    end
  end
end
