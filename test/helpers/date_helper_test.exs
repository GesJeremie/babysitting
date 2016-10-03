defmodule Babysitting.DateHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.Date

  describe "age/1" do

    test "return integer" do
      assert Date.age("03/10/1991") |> is_integer
    end

  end

  
end
