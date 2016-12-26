defmodule Babysitting.DateHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.DateHelper

  describe "age/1" do

    test "return integer" do
      assert DateHelper.age("03/10/1991") |> is_integer
    end

  end


end
