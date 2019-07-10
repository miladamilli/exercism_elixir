defmodule ScaleGenerator do
  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """

  @step %{"m" => 1, "M" => 2, "A" => 3}

  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    Enum.at(get_tonic(scale, tonic), Map.get(@step, step))
  end

  defp get_tonic([note | rest], tonic) when note == tonic do
    [note | rest]
  end

  defp get_tonic([_ | rest], tonic) do
    get_tonic(rest, tonic)
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """

  @scale ~w(C C# D D# E F F# G G# A A# B)

  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    _chromatic_scale(@scale, String.upcase(tonic), [])
  end

  defp _chromatic_scale([], _, _) do
    []
  end

  defp _chromatic_scale([note | rest], tonic, tail) when note == tonic do
    [note | rest] ++ Enum.reverse(tail) ++ [note]
  end

  defp _chromatic_scale([note | rest], tonic, tail) do
    _chromatic_scale(rest, tonic, [note | tail])
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """

  @flat_scale ~w(C Db D Eb E F Gb G Ab A Bb B)

  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    _chromatic_scale(@flat_scale, tonic, [])
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @flat_tonics ["F", "Bb", "Eb", "Ab", "Db", "Gb", "d", "g", "c", "f", "bb", "eb"]

  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    if tonic in @flat_tonics do
      flat_chromatic_scale(String.capitalize(tonic))
    else
      chromatic_scale(tonic)
    end
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    scale = find_chromatic_scale(tonic)

    pattern = String.graphemes(pattern)
    _scale(pattern, scale)
  end

  defp _scale([], [tone | _]) do
    [tone]
  end

  defp _scale([step | rest], [tone | scale]) do
    step = Map.get(@step, step)
    {scale_begin, scale_end} = Enum.split(scale, step - 1)

    [tone | _scale(rest, scale_end ++ scale_begin)]
  end
end
