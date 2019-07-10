defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([_ | t], acc) do
    do_count(t, acc + 1)
  end

  defp do_count([], acc) do
    acc
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([h | t], acc) do
    do_reverse(t, [h | acc])
  end

  defp do_reverse([], acc) do
    acc
  end

  @spec map(list, (any -> any)) :: list
  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  def map([], _) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([h | t], f) do
    if f.(h), do: [h | filter(t, f)], else: filter(t, f)
  end

  def filter([], _) do
    []
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _) do
    acc
  end

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b) do
    b
  end

  def append(a, []) do
    a
  end

  def append([h | t], b) do
    [h | append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  def concat([h | t]) do
    append(h, concat(t))
  end
end
