defmodule Babysitting.ContactTest do
  use Babysitting.ModelCase

  alias Babysitting.Contact

  @valid_attrs %{email: "some content", message: "some content", tenant_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Contact.changeset(%Contact{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Contact.changeset(%Contact{}, @invalid_attrs)
    refute changeset.valid?
  end
end
