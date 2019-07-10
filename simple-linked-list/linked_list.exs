defmodule LinkedList do
  @opaque t :: tuple()
  @error_empty {:error, :empty_list}

  @empty_list nil

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    @empty_list
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(@empty_list) do
    0
  end

  def length(list) do
    1 + LinkedList.length(t(list))
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    list == @empty_list
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(@empty_list) do
    @error_empty
  end

  def peek(list) do
    {:ok, h(list)}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(@empty_list) do
    @error_empty
  end

  def tail(list) do
    {:ok, t(list)}
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}

  def pop(@empty_list) do
    @error_empty
  end

  def pop(list) do
    {:ok, h(list), t(list)}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    do_from_list(list, @empty_list)
    |> reverse()
  end

  def do_from_list([], list) do
    list
  end

  def do_from_list([h | t], list) do
    do_from_list(t, push(list, h))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()

  def to_list(@empty_list) do
    []
  end

  def to_list(list) do
    [h(list) | to_list(t(list))]
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    do_reverse(list, @empty_list)
  end

  def do_reverse(@empty_list, acc_list) do
    acc_list
  end

  def do_reverse(list, acc_list) do
    do_reverse(t(list), push(acc_list, h(list)))
  end

  defp h({value, _}) do
    value
  end

  defp t({_, tail}) do
    tail
  end
end
