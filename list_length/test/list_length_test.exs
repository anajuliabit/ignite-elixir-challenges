defmodule ListLengthTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list length" do
      assert ListLength.call([1,2,3]) == 3
    end
  end
end
