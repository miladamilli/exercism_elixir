defmodule Bowling do
  defstruct state: :playing, total: 0, count: 1, frame: :first, strike: {1, 1}, previous: 0
  @frames 10
  @pins 10
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    %Bowling{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(_, roll) when roll < 0 do
    {:error, "Negative roll is invalid"}
  end

  def roll(_, roll) when roll > @pins do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(%Bowling{frame: :second, previous: previous}, roll)
      when previous + roll > @pins do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(%Bowling{state: :finished}, _roll) do
    {:error, "Cannot roll after game is over"}
  end

  def roll(%Bowling{total: total, strike: {s1, _s2}} = game, roll) do
    %Bowling{
      state: state(game, roll),
      total: total + roll * s1,
      count: count_up(game, roll),
      frame: next_frame(game, roll),
      strike: strike(game, roll),
      previous: roll
    }
  end

  defp state(%Bowling{state: state, count: count, frame: frame, previous: previous}, roll) do
    cond do
      count == @frames && frame == :second && previous + roll == @pins -> :bonus_spare
      state == :bonus_spare -> :finished
      count == @frames && frame == :second -> :finished
      count == @frames && roll == @pins -> :bonus_strike
      state == :bonus_strike -> :bonus_strike2
      state == :bonus_strike2 -> :finished
      true -> :playing
    end
  end

  defp count_up(%Bowling{count: count, frame: frame}, roll) do
    if frame == :first && roll != @pins, do: count, else: count + 1
  end

  defp next_frame(%Bowling{frame: frame}, roll) do
    if frame == :first && roll != @pins, do: :second, else: :first
  end

  defp strike(%Bowling{count: count, frame: frame, strike: {_s1, s2}, previous: previous}, roll) do
    cond do
      count < @frames && frame == :first && roll == @pins -> {s2 + 1, 2}
      count < @frames && frame == :second && previous + roll == @pins -> {s2 + 1, 1}
      true -> {s2, 1}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(%Bowling{state: :finished, total: total}) do
    total
  end

  def score(_) do
    {:error, "Score cannot be taken until the end of the game"}
  end
end
