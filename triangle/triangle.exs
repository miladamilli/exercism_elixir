defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene
  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}

  def kind(a, b, c) when false in [a > 0, b > 0, c > 0] do
    {:error, "all side lengths must be positive"}
  end

  def kind(a, b, c) when false in [a + b > c, b + c > a, a + c > b] do
    {:error, "side lengths violate triangle inequality"}
  end

  def kind(a, b, c) do
    case length(Enum.uniq([a, b, c])) do
      1 -> {:ok, :equilateral}
      2 -> {:ok, :isosceles}
      _ -> {:ok, :scalene}
    end
  end
end
