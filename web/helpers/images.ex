defmodule Babysitting.Helpers.Images do

  def avatar_url(classified, :thumb) do
    Babysitting.Avatar.url({classified.avatar, classified}, :thumb) |> String.replace_leading("priv/static", "")
  end

end
