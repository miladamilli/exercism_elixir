defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  @doc """
  Given a codon, return the corresponding protein
  """

  @map %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_rna(String.t()) :: {atom, list(String.t())}

  def of_rna(rna) do
    do_of_rna(rna, [])
  end

  defp do_of_rna("", result) do
    {:ok, Enum.reverse(result)}
  end

  defp do_of_rna(rna, result) do
    {codon, rest} = String.split_at(rna, 3)

    case of_codon(codon) do
      {:ok, "STOP"} -> do_of_rna("", result)
      {:ok, protein} -> do_of_rna(rest, [protein | result])
      {:error, _} -> {:error, "invalid RNA"}
    end
  end

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = Map.get(@map, codon)

    case protein do
      nil -> {:error, "invalid codon"}
      _ -> {:ok, protein}
    end
  end
end
