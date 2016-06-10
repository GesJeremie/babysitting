defmodule Babysitting.OfferContactTest do
  use Babysitting.ModelCase

  alias Babysitting.OfferContact

  @valid_attrs %{email: "some content", message: "some content", offer_id: 42, phone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OfferContact.changeset(%OfferContact{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OfferContact.changeset(%OfferContact{}, @invalid_attrs)
    refute changeset.valid?
  end
end
