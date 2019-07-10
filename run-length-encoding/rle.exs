defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(fn x -> x end)
    |> Enum.map(fn x -> count(x) end)
    |> List.to_string()
  end

  defp count(x) do
    case length(x) do
      1 -> hd(x)
      _ -> ["#{length(x)}", hd(x)]
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    String.to_charlist(string)
    |> read_char("", [])
  end

  defp read_char([], _, string) do
    List.to_string(string)
  end

  defp read_char([a | rest], acc, string) do
    if a in Enum.to_list(48..57) do
      read_char(rest, acc <> <<a>>, string)
    else
      if acc == "" do
        read_char(rest, "", string ++ [a])
      else
        read_char(
          rest,
          "",
          string ++ [List.duplicate(a, String.to_integer(acc))]
        )
      end
    end
  end
end
