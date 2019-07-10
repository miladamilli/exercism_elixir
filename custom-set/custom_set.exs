defmodule CustomSet do
  @opaque t :: %__MODULE__{elems: map}
  defstruct elems: %{}
  @spec new(Enum.t()) :: t
  def new([]) do
    %CustomSet{}
  end

  def new(enumerable) do
    %CustomSet{elems: Enum.into(enumerable, %{}, fn x -> {x, true} end)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set == %CustomSet{}
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    Map.has_key?(custom_set.elems, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.elems, fn {x, _} -> Map.has_key?(custom_set_2.elems, x) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    not Enum.any?(custom_set_1.elems, fn {x, _} -> Map.has_key?(custom_set_2.elems, x) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1 == custom_set_2
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %CustomSet{elems: Map.put(custom_set.elems, element, true)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    new = Enum.filter(custom_set_1.elems, fn {x, _} -> Map.has_key?(custom_set_2.elems, x) end)
    %CustomSet{elems: Enum.into(new, %{})}
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    new = Enum.reject(custom_set_1.elems, fn {x, _} -> Map.has_key?(custom_set_2.elems, x) end)
    %CustomSet{elems: Enum.into(new, %{})}
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    %CustomSet{elems: Map.merge(custom_set_1.elems, custom_set_2.elems)}
  end
end
