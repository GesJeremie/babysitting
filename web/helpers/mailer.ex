defmodule Babysitting.Mailer do

  use Mailgun.Client,
      domain: Application.get_env(:babysitting, :mailgun_domain),
      key: Application.get_env(:babysitting, :mailgun_key)

  def send_welcome_email(email_address) do

    send_email to: email_address,
               from: "us@example.com",
               subject: "Welcome!",
               text: "Welcome to HelloPhoenix!"
  end

end
