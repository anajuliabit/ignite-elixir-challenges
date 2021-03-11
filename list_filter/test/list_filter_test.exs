defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "return the count of odd numbers" do
      assert ListFilter.call(["1", "2", "banana", "5"]) === 2
    end
  end
end
