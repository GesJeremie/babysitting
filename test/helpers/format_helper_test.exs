defmodule Babysitting.FormatHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.FormatHelper

  describe "word_limit" do

    test "return binary" do
      assert FormatHelper.word_limit("hello") |> is_binary
    end

    test "shouldn't limit" do
      assert FormatHelper.word_limit("hello", 1) == "hello"
    end

    test "should limit" do
      assert FormatHelper.word_limit("hello you", 1) == "hello ..."
    end

    test "separator" do
      assert FormatHelper.word_limit("life is short", 2, " !") == "life is !"
    end

  end

  describe "fullname/2" do

    test "return binary" do
      assert FormatHelper.fullname("jeremie", "ges") |> is_binary
    end

    test "format correctly" do
      assert FormatHelper.fullname("jeremie", "ges") == "Jeremie Ges"
    end

  end

  describe "boolean/1" do

    test "return binary" do
      assert FormatHelper.boolean(true) |> is_binary
    end

  end

end
