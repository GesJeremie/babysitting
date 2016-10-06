defmodule Babysitting.ClassifiedTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
  import Babysitting.Factory
  alias Babysitting.Classified

  describe "hash_password/1" do
    setup do
      changeset = Ecto.Changeset.cast(%Classified{}, %{password: "zombie"}, [:password])
      [changeset: changeset]  
    end

    test "is crypted", context do
      changeset = Classified.hash_password(context.changeset)

      assert changeset.changes.password != "zombie"
    end

  end

  describe "make_token/1" do

    setup do
      changeset = Classified.changeset(%Classified{}, %{})
      [changeset: changeset]  
    end

    test "generate unique token", context do

      stream = 
        Stream.repeatedly(fn -> 
          Classified.make_token(context.changeset)
        end)

      tokens = stream |> Enum.take(1000)
      unique_tokens = Enum.uniq(tokens)

      assert length(tokens) == length(unique_tokens)
    end

  end


  describe "of_current_tenant/2" do

    setup do
      # Create tenant
      tenant = insert(:tenant)

      # Create 2 classifieds for this tenant
      insert_list(2, :classified, %{tenant: tenant})
      
      # Create other classfieds attached to other tenants
      insert_list(30, :classified)

      # Build the connection for our first tenant
      conn = 
        build_conn()
        |> with_host(tenant.domain)
        |> with_tenant

      [conn: conn]
    end
    
    test "return the right classifieds", context do
      classifieds = 
        Classified 
        |> Classified.of_current_tenant(context.conn)
        |> Repo.all

      assert classifieds |> length == 2
    end
    
  end

  describe "simple queries" do
    
    setup do
      insert_list(4, :classified, %{valid: true})
      insert_list(3, :classified, %{valid: false})
      insert_list(5, :classified, %{valid: nil})

      :ok
    end

    test "invalid/1" do
      classifieds = Classified |> Classified.invalid |> Repo.all
      assert length(classifieds) == 3
    end

    test "valid/1" do
      classifieds = Classified |> Classified.valid |> Repo.all
      assert length(classifieds) == 4
    end

    test "waiting/1" do
      classifieds = Classified |> Classified.waiting |> Repo.all
      assert length(classifieds) == 5
    end

    test "sort_by_recent/1" do
      classifieds = Classified |> Classified.sort_by_recent |> Repo.all
      
      first = classifieds |> Enum.at(0)
      second = classifieds |> Enum.at(1)

      assert first.id < second.id
    end

    test "exists/1" do
      exists = Classified |> Repo.all |> Classified.exists?
      assert exists |> is_boolean
    end

    test "where/3" do
      classifieds = Classified |> Classified.where(:valid, true) |> Repo.all
      assert classifieds |> length == 4
    end

  end


  describe "validate_unique_email/2" do

    setup do
      classified = insert(:classified, %{email: "zombie@zombie.com"})
      [classified: classified]
    end

    test "changeset should be valid" do
      changeset =
        %Classified{}
        |> Ecto.Changeset.cast(%{email: "test@example.com"}, [:email])
        |> Classified.validate_unique_email
      
      assert changeset.valid? == true
    end

    test "changeset should not be valid" do
      changeset =
        %Classified{}
        |> Ecto.Changeset.cast(%{email: "zombie@zombie.com"}, [:email])
        |> Classified.validate_unique_email
      
      assert changeset.valid? == false
    end

    test "handle id", context do
      IO.inspect context.classified.id
      
      changeset = 
        %Classified{}
        |> Ecto.Changeset.cast(%{email: "zombie@zombie.com"}, [:email])
        |> Classified.validate_unique_email(context.classified.id)

      assert changeset.valid? == true
    end

  end
end

