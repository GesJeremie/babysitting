defmodule Babysitting.Helpers.Ifttt do

  @doc """
  Send an event to the API Maker of IFTTT.
  """
  def send_event(event, value1 \\ "", value2 \\ "", value3 \\ "") do

    key = Application.get_env(:babysitting, :ifttt_key)

    # I know. When I will see that again, I would be good enough in elixir
    # to avoid it.
    value1 = URI.encode(value1)
    value2= URI.encode(value2)
    value3 = URI.encode(value3)

    request = "https://maker.ifttt.com/trigger/#{event}/with/key/#{key}?value1=#{value1}&value2=#{value2}&value3=#{value3}"

    HTTPoison.get request
  end
end