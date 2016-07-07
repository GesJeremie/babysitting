defmodule Babysitting.Helpers.Mailer do
  
  import Babysitting.Gettext

  use Mailgun.Client,
      domain: Application.get_env(:babysitting, :mailgun_domain),
      key: Application.get_env(:babysitting, :mailgun_key)

  def send_welcome(email_address) do

    send_email to: email_address,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("welcome"),
               html: Phoenix.View.render_to_string(Babysitting.EmailView, "welcome.html", %{})
  end

end
