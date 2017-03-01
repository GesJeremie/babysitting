defmodule Babysitting.Helpers.MicroDataHelper do
  alias Babysitting.Helpers.AppHelper

  @doc """
  Render micro data json ld for a classified
  """
  def classified(conn, classified) do
    Phoenix.HTML.raw ~s(
      <script type="application/ld+json">
        {
          "@context": "http://schema.org/",
          "@type": "Service",
          "serviceType": "Baby Sitting",
          "provider": {
            "@type": "Person",
            "givenName": "#{Phoenix.HTML.escape_javascript(classified.firstname)}",
            "familyName": "#{Phoenix.HTML.escape_javascript(classified.lastname)}",
            "birthDate": "#{Phoenix.HTML.escape_javascript(classified.birthday)}",
            "email": "#{Phoenix.HTML.escape_javascript(classified.email)}",
            "telephone": "#{Phoenix.HTML.escape_javascript(classified.phone)}"
          },
          "areaServed": {
            "@type": "City",
            "name": "#{AppHelper.current_tenant(conn).name}"
          },
          "description": "#{Phoenix.HTML.escape_javascript(classified.description)}"
        }
      </script>)
  end
end
