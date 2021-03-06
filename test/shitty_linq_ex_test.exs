defmodule ShittyLinqExTest do
  use ExUnit.Case, async: true
  doctest ShittyLinqEx

  describe "all/2" do
    test "empty list should return true" do
      assert ShittyLinqEx.all([], fn _ -> true end) == true
    end

    test "should return false" do
      assert ShittyLinqEx.all(
               ["Barley", "Boots", "Whiskers"],
               fn pet -> String.first(pet) == "B" end
             ) == false
    end

    test "should return true" do
      assert ShittyLinqEx.all(
               [1, 3, 5, 7, 9],
               fn number -> rem(number, 2) == 1 end
             ) == true
    end
  end

  describe "reverse/1" do
    test "empty list" do
      assert ShittyLinqEx.reverse([]) == []
    end

    test "reverse of empty list" do
      assert ShittyLinqEx.reverse([]) == []
    end

    test "normal list" do
      assert ShittyLinqEx.reverse([1, 3, 5, 7]) == [7, 5, 3, 1]
    end

    test "big list" do
      assert ShittyLinqEx.reverse(Enum.to_list(1..1_000_000)) == Enum.to_list(1_000_000..1)
    end
  end

  describe "take/2" do
    test "returns a list with count elements" do
      assert ShittyLinqEx.take([2, 3, 5, 7], 2) == [2, 3]
    end

    test "returns all elements if count is greater than source" do
      assert ShittyLinqEx.take(["A", "B", "C", "D"], 6) == ["A", "B", "C", "D"]
    end

    test "returns empty list if count 0" do
      assert ShittyLinqEx.take([2, 3, 5, 7], 0) == []
    end

    test "returns empty list if source is empty" do
      assert ShittyLinqEx.take([], 2) == []
    end

    test "returns nil if source is nil" do
      assert ShittyLinqEx.take(nil, 3) == nil
    end

    test "returns empty list if source is negativa" do
      assert ShittyLinqEx.take([2, 3, 5, 7], -6) == []
    end
  end

  describe "first/1" do
    test "empty list" do
      assert ShittyLinqEx.first([]) == nil
    end

    test "normal list with same type" do
      assert ShittyLinqEx.first([1, 2, 3]) == 1
    end

    test "normal list with jumbled type" do
      assert ShittyLinqEx.first(["A", 1, :A]) == "A"
    end

    test "big list" do
      assert ShittyLinqEx.first(Enum.to_list(1..1_000_000)) == 1
    end

    test "nil value" do
      assert ShittyLinqEx.first(nil) == nil
    end

    test "normal list with predicate matching any value" do
      assert ShittyLinqEx.first([4, 2, 3], &>/2, 1) == 4
    end

    test "normal list with predicate not matching any value" do
      assert ShittyLinqEx.first([4, 2, 3], &>/2, 5) == nil
    end

    test "normal list with invalid value" do
      assert ShittyLinqEx.first([4, 2, 3], &>/2, "a") == nil
    end
  end

  describe "repeat/2" do
    test "string value" do
      assert ShittyLinqEx.repeat("Hi", 3) == ["Hi", "Hi", "Hi"]
    end

    test "normal list with strings" do
      assert ShittyLinqEx.repeat(["hello", "there"], 2) == [
               ["hello", "there"],
               ["hello", "there"]
             ]
    end

    test "with map" do
      assert ShittyLinqEx.repeat(%{"this" => "is", "a" => "map"}, 2) == [
               %{"this" => "is", "a" => "map"},
               %{"this" => "is", "a" => "map"}
             ]
    end

    test "with atom" do
      assert ShittyLinqEx.repeat(:atom, 3) === [:atom, :atom, :atom]
    end

    test "with tuple" do
      assert ShittyLinqEx.repeat({"string", :atom}, 3) === [
               {"string", :atom},
               {"string", :atom},
               {"string", :atom}
             ]
    end

    test "with count equal 0" do
      assert_raise RuntimeError, "Count must be 1 or more", fn ->
        ShittyLinqEx.repeat("anything", 0)
      end
    end

    test "with negative count " do
      assert_raise RuntimeError, "Count must be 1 or more", fn ->
        ShittyLinqEx.repeat("anything", -3)
      end
    end
  end

  describe "repeat/1" do
    test "with number" do
      assert ShittyLinqEx.repeat(1) == 1
    end

    test "with string" do
      assert ShittyLinqEx.repeat("hello") == "hello"
    end

    test "with tuple" do
      assert ShittyLinqEx.repeat({"tuple"}) == {"tuple"}
    end
  end
end
