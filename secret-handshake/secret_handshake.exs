defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise, only_operators: true
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    list = [
      {0b0001, "wink"},
      {0b0010, "double blink"},
      {0b0100, "close your eyes"},
      {0b1000, "jump"}
    ]

    handshake = Enum.reduce(list, [], &handshake(&1, &2, code))
    if (code &&& 0b10000) == 0, do: Enum.reverse(handshake), else: handshake
  end

  def handshake({chifre, word}, acc, code) do
    if (code &&& chifre) > 0, do: [word | acc], else: acc
  end
end
