defmodule Babysitting.OfferHitTest do
  use Babysitting.ModelCase

  alias Babysitting.OfferHit

  @valid_attrs %{ip: "some content", offer_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OfferHit.changeset(%OfferHit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OfferHit.changeset(%OfferHit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
