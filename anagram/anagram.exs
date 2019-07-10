defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_down = String.downcase(base)
    base_sorted = normalize(base_down)

    Enum.filter(candidates, fn candid ->
      candid_down = String.downcase(candid)
      candid_down != base_down and normalize(candid_down) == base_sorted
    end)
  end

  defp normalize(word) do
    Enum.sort(String.to_charlist(word))
  end
end
