defmodule Clock do
  defstruct hour: 0, minute: 0

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: hour, minute: minute}) do
      normalize(hour) <> ":" <> normalize(minute)
    end

    defp normalize(number) do
      number
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end
  end

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    {hour, minute} = parse_clock(hour, minute)
    %Clock{hour: hour, minute: minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    %{hour: hour, minute: minute} = %Clock{hour: hour, minute: minute}
    new(hour, minute + add_minute)
  end

  defp parse_clock(hour, minute) when minute < 0,
    do: parse_clock(hour + div(minute, 60) - 1, 60 + rem(minute, 60))

  defp parse_clock(hour, minute) when minute >= 60,
    do: parse_clock(hour + div(minute, 60), rem(minute, 60))

  defp parse_clock(hour, minute) when hour < 0, do: parse_clock(24 + rem(hour, 24), minute)

  defp parse_clock(hour, minute), do: {rem(hour, 24), minute}
end
