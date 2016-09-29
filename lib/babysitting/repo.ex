defmodule Babysitting.Repo do
  use Ecto.Repo, otp_app: :babysitting
  use Scrivener, page_size: 10
end
