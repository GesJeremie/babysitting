defmodule Babysitting.IfttttHelperTest do

  use Babysitting.ConnCase
  alias Babysitting.Helpers.Ifttt

  describe "send_event" do
    
    test "send the event" do
      {status, request} = Ifttt.send_event("test", "value1", "value2", "value3")

      assert status == :ok
      assert request.body == "Congratulations! You've fired the test event"
    end

  end
  
end
