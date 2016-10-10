defmodule Babysitting.ClassifiedControllerTest do
  use Babysitting.ConnCase
  alias Babysitting.Classified
  import Babysitting.Factory

  describe "new/2" do
    test "display form", %{conn: conn} do
      conn = get conn, app_classified_path(conn, :new)
      assert html_response(conn, 200)
    end
  end

  describe "create/2" do
    test "does not create resource when form invalid", %{conn: conn} do
      conn = post conn, app_classified_path(conn, :create), classified: %{}

      assert html_response(conn, 200) =~ "<form"
      assert Repo.all(Classified) |> length == 0
    end

    test "create resource when form valid", %{conn: conn} do
      params = %{
        firstname: FakerElixir.Name.first_name,
        lastname: FakerElixir.Name.last_name,
        birthday: "03/10/1991",
        description: FakerElixir.Lorem.characters(300),
        avatar: %Plug.Upload{path: "test/fixtures/avatar.jpeg", filename: "avatar.jpeg"},
        email: FakerElixir.Internet.email(:popular),
        phone: FakerElixir.Helper.numerify("##########"),
        password: "awesomepassword",
        password_confirmation: "awesomepassword"
      }

      conn = post conn, app_classified_path(conn, :create), classified: params

      IO.inspect params
      IO.inspect conn

    end

    

  end

end
