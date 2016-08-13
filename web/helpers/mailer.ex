defmodule Babysitting.Helpers.Mailer do

  import Babysitting.Gettext

  use Mailgun.Client,
      domain: Application.get_env(:babysitting, :mailgun_domain),
      key: Application.get_env(:babysitting, :mailgun_key)

  def send_welcome(%{to: to, fullname: fullname, tenant: tenant}) do

    send_email to: to,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("Baby Sitting %{name} - Welcome", name: tenant.name),
               html: Phoenix.View.render_to_string(Babysitting.EmailView, "welcome.html", %{fullname: fullname, tenant: tenant})
  end

  def send_validated(%{classified: classified}) do
    send_email to: classified.email,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("Baby Sitting %{name} - Classified validated", name: classified.tenant.name),
               html: Phoenix.View.render_to_string(Babysitting.EmailView, "validated.html", %{name: classified.firstname})
  end
end
