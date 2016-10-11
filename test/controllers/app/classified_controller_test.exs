defmodule Babysitting.ClassifiedControllerTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
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

      # Check if picture uploaded
      assert path_avatars(params.email) |> File.exists?
      assert path_avatars(params.email) |> File.ls |> elem(1) |> length == 2

      # Check classified added
      classifieds = Repo.all(Classified)
      assert classifieds |> length == 1

      # Check properties created
      classified = classifieds |> Enum.at(0)
      assert is_nil(classified.valid)
      assert not is_nil(classified.token)
      assert not is_nil(classified.search)

      # Check redirect to /thankyou
      assert redirected?(conn)

      # Clean file uploads
      path_avatars(params.email) |> File.rm_rf

    end
  end

  describe "show/2" do

    test "render classified of current tenant" do
      tenant = insert(:tenant)
      classified = insert(:classified, %{tenant: tenant})

      conn = build_conn() |> with_host(tenant.domain)
      conn = get conn, app_classified_path(conn, :show, classified.id)

      assert html_response(conn, 200)
    end

    test "don't render classified of other tenant" do
      tenant = insert(:tenant)
      classified = insert(:classified)

      conn = build_conn() |> with_host(tenant.domain)

      assert_error_sent :not_found, fn ->
        get conn, app_classified_path(conn, :show, classified.id)
      end

    end

    

  end

  defp path_avatars(email) do
    hash_email = :md5 |> :crypto.hash(email) |> Base.encode16
    "uploads/classifieds/avatars/#{hash_email}"
  end

end
