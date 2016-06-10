defmodule Babysitting.OfferTest do
  use Babysitting.ModelCase

  alias Babysitting.Offer

  @valid_attrs %{avatar: "some content", day_birthday: 42, description: "some content", firstname: "some content", lastname: "some content", month_birthday: "some content", phone: "some content", search: "some content", status: "some content", tenant_id: 42, token: "some content", year_birthday: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Offer.changeset(%Offer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Offer.changeset(%Offer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
