defmodule Babysitting.DateHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.Date

  test "age/1" do
    assert "03/10/1991"
      |> Date.age
      |> is_integer
  end

end
