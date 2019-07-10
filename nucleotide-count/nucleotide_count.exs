defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer

  def count(strand, nucleotide) do
    Map.get(count_nucleotides(strand), nucleotide) || 0
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map

  def histogram(strand) do
    default = Enum.into(@nucleotides, %{}, fn n -> {n, 0} end)
    Map.merge(default, count_nucleotides(strand))
  end

  defp count_nucleotides(strand) do
    strand
    |> Enum.group_by(fn x -> x end)
    |> Enum.into(%{}, fn {x, y} -> {x, length(y)} end)
  end
end
