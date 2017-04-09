defmodule Babysitting.Helpers.StripeHelper do
  import Babysitting.Gettext
  alias Babysitting.Helpers.AppHelper

  @stripe_key Application.get_env(:babysitting, :stripe_key)

  @doc """
  If the current tenant is bordeaux, we charge the customer.
  In the future we will create a full system for every cities
  based on options (on/off payment system).
  """
  def maybe_charge_classified(classified, token, conn) do
    if AppHelper.is_current_tenant(:bordeaux, conn) do
      charge(classified, token)
    else
      {:ok, :charge}
    end
  end

  @doc """
  Charge the card (the card details are stored via the token in the stripe's server)
  """
  def charge(classified, token) do
    charged = HTTPoison.post("https://api.stripe.com/v1/charges", [], [], params: %{
      key: @stripe_key,
      amount: "250",
      currency: "eur",
      description: "Ajout annonce baby sitting bordeaux",
      source: token})

    case charged do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, :charge}
      _ ->
        {:error, :charge, Babysitting.Gettext.gettext("Ooops, the payment system returned an error.")}
    end
  end

end
