defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, [" ", ",", "-"], trim: true)
    |> Enum.map(&get_acronym/1)
    |> List.to_string()
  end

  defp get_acronym(phrase) do
    first = String.first(phrase)

    phrase =
      if first == String.upcase(first) do
        phrase
      else
        String.capitalize(phrase)
      end

    String.replace(phrase, ~r/[a-z]/, "")
  end
end
