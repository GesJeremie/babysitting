defmodule Babysitting.ClassifiedChangesetTest do
  use Babysitting.ConnCase
  alias Babysitting.Classified
  alias Babysitting.Changesets.ClassifiedChangeset
  import Babysitting.ConnCase
  import Babysitting.Factory

  describe "hash_password/1" do
    setup do
      changeset = Ecto.Changeset.cast(%Classified{}, %{password: "zombie"}, [:password])
      [changeset: changeset]
    end

    test "is crypted", context do
      changeset = ClassifiedChangeset.hash_password(context.changeset)

      assert changeset.changes.password != "zombie"
    end

  end

  describe "make_token/1" do

    setup do
      changeset = ClassifiedChangeset.default(%Classified{}, %{})
      [changeset: changeset]
    end

    test "generate unique token", context do

      stream =
        Stream.repeatedly(fn ->
          ClassifiedChangeset.make_token(context.changeset)
        end)

      tokens = stream |> Enum.take(1000)
      unique_tokens = Enum.uniq(tokens)

      assert length(tokens) == length(unique_tokens)
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
        |> ClassifiedChangeset.validate_unique_email

      assert changeset.valid? == true
    end

    test "changeset should not be valid" do
      changeset =
        %Classified{}
        |> Ecto.Changeset.cast(%{email: "zombie@zombie.com"}, [:email])
        |> ClassifiedChangeset.validate_unique_email

      assert changeset.valid? == false
    end

    test "handle id", context do
      changeset =
        %Classified{}
        |> Ecto.Changeset.cast(%{email: "zombie@zombie.com"}, [:email])
        |> ClassifiedChangeset.validate_unique_email(context.classified.id)

      assert changeset.valid? == true
    end

  end
end
