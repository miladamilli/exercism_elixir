defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @directions [:north, :east, :south, :west]
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(direction, {x, y}) when is_integer(x) and is_integer(y) do
    {direction, {x, y}}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    do_simulate(robot, String.to_charlist(instructions))
  end

  defp do_simulate({direction, {x, y}}, [?A | rest]) do
    new_position =
      case direction do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end

    do_simulate({direction, new_position}, rest)
  end

  defp do_simulate({direction, position}, [i | rest]) when i in [?R, ?L] do
    index = Enum.find_index(@directions, fn x -> x == direction end)

    new_direction =
      case i do
        ?R -> Enum.at(@directions, rem(index + 1, 4))
        ?L -> Enum.at(@directions, index - 1)
      end

    do_simulate({new_direction, position}, rest)
  end

  defp do_simulate(robot, []) do
    robot
  end

  defp do_simulate(_, _) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_, position}) do
    position
  end
end
