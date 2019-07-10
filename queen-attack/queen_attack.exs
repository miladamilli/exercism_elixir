defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3}) do
    if black == white do
      raise ArgumentError
    end

    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board =
      for y <- 0..7 do
        line =
          for x <- 0..7 do
            cond do
              {y, x} == queens.white() -> "W "
              {y, x} == queens.black() -> "B "
              true -> "_ "
            end
          end

        String.trim(List.to_string(line)) <> "\n"
      end

    String.trim(List.to_string(board))
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    {w1, w2} = queens.white
    {b1, b2} = queens.black

    if abs(w1 - b1) == abs(w2 - b2) or w1 == b1 or w2 == b2 do
      true
    else
      false
    end
  end
end
