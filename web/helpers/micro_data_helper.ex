defmodule Babysitting.Helpers.MicroDataHelper do
  alias Babysitting.Helpers.AppHelper

  @doc """
  Render micro data json ld for a classified
  """
  def classified(conn, classified) do
    json = Poison.encode! %{
      "@context" => "http://schema.org/",
      "@type" => "Service",
      "serviceType" => "Baby Sitting",
      "provider" => %{
        "@type" => "Person",
        "givenName" => classified.firstname,
        "familyName" => classified.lastname,
        "birthDate" => classified.birthday,
        "email" => classified.email,
        "telephone" => classified.phone
      },
      "areaServed" => %{
        "@type" => "City",
        "name" => AppHelper.current_tenant(conn).name
      },
      "description" => classified.description
    }

    Phoenix.HTML.raw ~s(<script type="application/ld+json">#{json}</script>)
  end
end
