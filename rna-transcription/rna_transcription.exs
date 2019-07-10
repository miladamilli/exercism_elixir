defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &do_to_rna/1)
  end

  defp do_to_rna(char) do
    case char do
      ?A -> ?U
      ?C -> ?G
      ?T -> ?A
      ?G -> ?C
    end
  end
end
