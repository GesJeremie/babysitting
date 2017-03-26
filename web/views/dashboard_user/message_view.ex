defmodule Babysitting.DashboardUser.MessageView do
  import Babysitting.ClassifiedView, only: [fullname: 1, phone: 1]
  use Babysitting.Web, :view

  def inserted_at(%{:inserted_at => inserted_at}) do
    Babysitting.Helpers.DateHelper.humanize(inserted_at)
  end

  def mailto(email) do
    Phoenix.HTML.raw("<a class=\"link link--mailto\" href=\"mailto:#{email}\">#{email}</a>")
  end

end
