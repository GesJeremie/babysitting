defmodule Babysitting.FormatHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.Format

  describe "word_limit" do

    test "return binary" do
      assert Format.word_limit("hello") |> is_binary
    end

    test "shouldn't limit" do
      assert Format.word_limit("hello", 1) == "hello"
    end

    test "should limit" do
      assert Format.word_limit("hello you", 1) == "hello ..."
    end

    test "separator" do
      assert Format.word_limit("life is short", 2, " !") == "life is !"
    end

  end

  describe "fullname/2" do

    test "return binary" do
      assert Format.fullname("jeremie", "ges") |> is_binary
    end

    test "format correctly" do
      assert Format.fullname("jeremie", "ges") == "Jeremie Ges"
    end

  end

  describe "boolean/1" do

    test "return binary" do
      assert Format.boolean(true) |> is_binary
    end

  end
  
end
