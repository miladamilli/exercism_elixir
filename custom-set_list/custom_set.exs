defmodule CustomSet do
  @opaque t :: %__MODULE__{elems: list}
  defstruct elems: []
  @spec new(Enum.t()) :: t
  def new([]) do
    %CustomSet{}
  end

  def new(enumerable) do
    %CustomSet{elems: normalize(enumerable, [])}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.elems == []
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    element in custom_set.elems
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    parse_subset(custom_set_1.elems, custom_set_2.elems)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    parse_disjoint(custom_set_1.elems, custom_set_2.elems)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    parse_equal(custom_set_1.elems, custom_set_2.elems)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    new([element | custom_set.elems])
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    parse_intersection(custom_set_1.elems, custom_set_2.elems, [])
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    parse_difference(custom_set_1.elems, custom_set_2.elems, [])
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    new(custom_set_1.elems ++ custom_set_2.elems)
  end

  defp normalize([], acc), do: acc

  defp normalize([e | enumerable], acc) do
    if e in acc do
      normalize(enumerable, acc)
    else
      normalize(enumerable, [e | acc])
    end
  end

  defp parse_subset([], _custom_set_2), do: true

  defp parse_subset([c | custom_set_1], custom_set_2) do
    with true <- c in custom_set_2 do
      parse_subset(custom_set_1, custom_set_2)
    end
  end

  defp parse_disjoint([], _custom_set_2), do: true

  defp parse_disjoint([c | custom_set_1], custom_set_2) do
    with true <- c not in custom_set_2 do
      parse_disjoint(custom_set_1, custom_set_2)
    end
  end

  defp parse_equal([], []), do: true

  defp parse_equal([c | custom_set_1], custom_set_2) do
    with true <- c in custom_set_2 do
      parse_equal(custom_set_1, custom_set_2 -- [c])
    end
  end

  defp parse_equal(_, _), do: false

  defp parse_intersection([], _custom_set_2, acc), do: new(acc)

  defp parse_intersection([c | custom_set_1], custom_set_2, acc) do
    if c in custom_set_2 do
      parse_intersection(custom_set_1, custom_set_2 -- [c], [c | acc])
    else
      parse_intersection(custom_set_1, custom_set_2, acc)
    end
  end

  defp parse_difference([], _custom_set_2, acc), do: new(acc)

  defp parse_difference([c | custom_set_1], custom_set_2, acc) do
    if c in custom_set_2 do
      parse_difference(custom_set_1, custom_set_2 -- [c], acc)
    else
      parse_difference(custom_set_1, custom_set_2, [c | acc])
    end
  end
end
