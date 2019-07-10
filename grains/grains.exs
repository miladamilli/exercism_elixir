defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number in 1..64, do: {:ok, do_square(number)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  defp do_square(1), do: 1
  defp do_square(number), do: 2 * do_square(number - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: {:ok, do_total(64)}
  def do_total(1), do: 1
  def do_total(field), do: do_square(field) + do_total(field - 1)
end
