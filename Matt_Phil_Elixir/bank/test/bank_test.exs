defmodule BankTest do
  use ExUnit.Case

  test "zero" do
    str = """
           _ 
          | |
          |_|
          """
    assert Bank.parse(str) == 0
  end

  test "zero four" do
    str = """
           _    
          | ||_|
          |_|  |
          """

    assert Bank.line(str) == [0,4]
  end
    
  test "zero four seven nine" do
    str = """
           _     _  _ 
          | ||_|  ||_|
          |_|  |  |  |
          """

    assert Bank.line(str) == [0,4,7,9]
  end
end
