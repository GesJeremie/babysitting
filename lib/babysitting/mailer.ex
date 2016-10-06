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

  def new_classified_admin(%{classified: classified, conn: conn}) do
    
    make("new_classified_admin.html", %{
      to: Application.get_env(:babysitting, :email_address),
      subject: gettext("Baby Sitting %{name} - New classified waiting for validation", name: classified.tenant.name),
      data: %{classified: classified, conn: conn}
    })

  end

  def new_contact(%{conn: conn, contact: contact}) do

    make("new_contact.html", %{
      to: contact.classified.email,
      subject: gettext("Baby Sitting %{name} - New contact request", name: contact.classified.tenant.name),
      data: %{contact: contact, conn: conn}
    })

  end

  def new_contact_admin(%{conn: conn, contact: contact}) do

    make("new_contact_admin.html", %{
      to: Application.get_env(:babysitting, :email_address),
      subject: gettext("Baby Sitting %{name} - A family just sent a message to a baby sitter", name: contact.classified.tenant.name),
      data: %{contact: contact, conn: conn}
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
