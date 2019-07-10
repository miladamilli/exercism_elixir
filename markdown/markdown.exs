defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """

  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> parse_lines()
    |> Enum.join()
  end

  defp parse_lines([line | _] = lines) do
    cond do
      String.starts_with?(line, "#") -> parse_header_md(lines)
      String.starts_with?(line, "*") -> parse_list_md(lines)
      true -> parse_paragraph_md(lines)
    end
  end

  defp parse_lines([]) do
    []
  end

  defp parse_header_md([line | lines]) do
    [enclose_with_header_tag(parse_header_md_level(line)) | parse_lines(lines)]
  end

  defp parse_header_md_level(header_line) do
    [tag | words] = String.split(header_line)
    {String.length(tag), Enum.join(words, " ")}
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp parse_list_md(lines) do
    ["<ul>" | parse_list_md_level(lines)]
  end

  defp parse_list_md_level(["* " <> line | lines]) do
    ["<li>", join_words_with_tags(line), "</li>" | parse_list_md_level(lines)]
  end

  defp parse_list_md_level(lines) do
    ["</ul>" | parse_lines(lines)]
  end

  defp parse_paragraph_md([line | lines]) do
    [enclose_with_paragraph_tag(line) | parse_lines(lines)]
  end

  defp enclose_with_paragraph_tag(line) do
    "<p>#{join_words_with_tags(line)}</p>"
  end

  defp join_words_with_tags(line) do
    line
    |> String.split()
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_prefix("_", "<em>")
    |> String.replace_suffix("_", "</em>")
  end
end
