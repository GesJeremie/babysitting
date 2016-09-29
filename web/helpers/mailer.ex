defmodule Babysitting.Mailer do
  use Bamboo.Mailer, otp_app: :babysitting
end

defmodule Babysitting.Email do
  import Bamboo.Email
  import Babysitting.Gettext

  def welcome(%{to: to, fullname: fullname, tenant: tenant}) do

    new_email to: to,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("Baby Sitting %{name} - Welcome", name: tenant.name),
               html_body: Phoenix.View.render_to_string(Babysitting.EmailView, "welcome.html", %{fullname: fullname, tenant: tenant})
  end

  def validated(%{classified: classified}) do
    new_email to: classified.email,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("Baby Sitting %{name} - Classified validated", name: classified.tenant.name),
               html_body: Phoenix.View.render_to_string(Babysitting.EmailView, "validated.html", %{name: classified.firstname})
  end

  def rejected(%{classified: classified}) do
    new_email to: classified.email,
               from: Application.get_env(:babysitting, :email_address),
               subject: gettext("Baby Sitting %{name} - Classified rejected", name: classified.tenant.name),
               html_body: Phoenix.View.render_to_string(Babysitting.EmailView, "rejected.html", %{name: classified.firstname})
  end

end
