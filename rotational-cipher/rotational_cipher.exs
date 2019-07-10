defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  @chars_count ?z - ?a + 1
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> shifting(x, rem(shift, @chars_count)) end)
    |> List.to_string()
  end

  defp shifting(char, shift) when char in ?a..?z, do: new_char(char, shift, ?z)
  defp shifting(char, shift) when char in ?A..?Z, do: new_char(char, shift, ?Z)
  defp shifting(char, _shift), do: char

  defp new_char(char, shift, last_char) do
    new_char = char + shift

    if new_char <= last_char do
      new_char
    else
      new_char - @chars_count
    end
  end
end
