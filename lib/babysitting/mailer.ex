defmodule Babysitting.Mailer do
  use Bamboo.Mailer, otp_app: :babysitting
end

defmodule Babysitting.Email do
  import Bamboo.Email
  import Babysitting.Gettext

  def welcome(%{to: to, fullname: fullname, tenant: tenant}) do

    make("welcome.html", %{
      to: to,
      subject: gettext("Baby Sitting %{name} - Welcome", name: tenant.name),
      data: %{fullname: fullname, tenant: tenant}
    })

  end

  def validated(%{classified: classified}) do
    
    make("validated.html", %{
      to: classified.email,
      subject: gettext("Baby Sitting %{name} - Classified validated", name: classified.tenant.name),
      data: %{name: classified.firstname}
    })

  end

  def rejected(%{classified: classified}) do

    make("rejected.html", %{
      to: classified.email,
      subject: gettext("Baby Sitting %{name} - Classified rejected", name: classified.tenant.name),
      data: %{name: classified.firstname}
    })

  end

  def new_admin(%{classified: classified, conn: conn}) do
    
    make("new_admin.html", %{
      to: Application.get_env(:babysitting, :email_address),
      subject: gettext("New classified waiting for validation"),
      data: %{classified: classified, conn: conn}
    })

  end

  ##
  # Make email
  ##
  defp make(template, %{to: to, subject: subject, data: data}) do

    data = Map.put(data, :template, template)

    new_email
    |> to(to)
    |> from(Application.get_env(:babysitting, :email_address))
    |> subject(subject)
    |> html_body(Phoenix.View.render_to_string(Babysitting.EmailView, "base.html", data))
  
  end

end
