defmodule Bank do
  require Logger

  @doc ~S"""
  Parse a line of characters

  Example:

      iex> str = """
      iex>  _    
      iex> | ||_|
      iex> |_|  |
      iex> """
      " _  \n| ||_|\n|_|  |\n"
      iex> Bank.line(str)
      [0, 4]

  """
  def line(str) do
    Enum.reverse(_line(String.split(str, "\n"), []))
  end

  # Last three chars, so return the last state (ie, all the parsed characters so far: [0,3,4])
  defp _line([<< x1::utf8, x2::utf8, x3::utf8>>, << y1::utf8, y2::utf8, y3::utf8>>, << z1::utf8, z2::utf8, z3::utf8>>], state) do
    [parse(to_string([x1, x2, x3, ?\n, y1, y2, y3, ?\n, z1, z2, z3, ?\n])) | state]
  end
  defp _line([<< x1::utf8, x2::utf8, x3::utf8, tail_one::binary>>, << y1::utf8, y2::utf8, y3::utf8, tail_two::binary>>, << z1::utf8, z2::utf8, z3::utf8, tail_three::binary>>], state) do
    state_out = [parse(to_string([x1, x2, x3, ?\n, y1, y2, y3, ?\n, z1, z2, z3, ?\n])) | state]
    
    # We've got more characters, so carry on.
    _line([tail_one, tail_two, tail_three], state_out)
  end
  # As a result of the String.split, we get an extra blank element at the end of the three lines.
  defp _line([<< x1::utf8, x2::utf8, x3::utf8, tail_one::binary>>, << y1::utf8, y2::utf8, y3::utf8, tail_two::binary>>, << z1::utf8, z2::utf8, z3::utf8, tail_three::binary>>, _], state) do
    state_out = [parse(to_string([x1, x2, x3, ?\n, y1, y2, y3, ?\n, z1, z2, z3, ?\n])) | state]
    
    # We've got more characters, so carry on.
    _line([tail_one, tail_two, tail_three], state_out)
  end
    
  @doc ~S"""
  Parse a single digit.

  Example:
      iex> six = """
      iex>  _ 
      iex> |_
      iex> |_|
      iex> """
      " _ \n|_\n|_|\n"
      iex> Bank.parse(six)
      6
      iex> 

  """
  def parse("""
             _ 
            | |
            |_|
            """), do: 0


  def parse("""
               
             |
             |
            """), do: 1

  def parse("""
             _ 
             _|
            |_
            """), do: 2

  def parse("""
             _ 
             _|
             _|
            """), do: 3

  def parse("""
               
            |_|
              |
            """), do: 4

  def parse("""
             _ 
            |_
             _|
            """), do: 5

  def parse("""
             _ 
            |_
            |_|
            """), do: 6

  def parse("""
             _ 
              |
              |
            """), do: 7

  def parse("""
             _ 
            |_|
            |_|
            """), do: 8

  def parse("""
             _ 
            |_|
              |
            """), do: 9

end
