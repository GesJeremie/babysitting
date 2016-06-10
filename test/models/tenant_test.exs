defmodule Babysitting.TenantTest do
  use Babysitting.ModelCase

  alias Babysitting.Tenant

  @valid_attrs %{domain: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tenant.changeset(%Tenant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tenant.changeset(%Tenant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
