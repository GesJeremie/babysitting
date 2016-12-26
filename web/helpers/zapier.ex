defmodule Babysitting.Helpers.Zapier do

  def send_hook(url, params) do
    HTTPoison.get url, [], params: params
  end

  def post_new_classified_on_facebook(params) do
    send_hook("https://hooks.zapier.com/hooks/catch/1878141/tci861/", params)
  end

end
