defmodule Bob do
  def hey(input) do
    cond do
      contains_letter?(input) and upcase?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"

      question?(input) ->
        "Sure."

      contains_letter?(input) and upcase?(input) ->
        "Whoa, chill out!"

      String.trim(input) == "" ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end

  defp contains_letter?(input), do: String.upcase(input) != String.downcase(input)
  defp question?(input), do: String.last(input) == "?"
  defp upcase?(input), do: String.upcase(input) == input
end
