defmodule Babysitting.EmailView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  def tenant_url(domain, path) when is_binary(domain) do
    "http://#{domain}#{path}"
  end

  def tenant_url(conn, path) do
    domain = AppHelper.current_tenant(conn).domain
    "http://#{domain}#{path}"
  end

  def click(title, url) do
    Phoenix.HTML.raw """
    <table border="0" cellpadding="0" cellspacing="0" class="btn btn-primary" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; box-sizing: border-box;" width="100%">
      <tbody>
        <tr>
          <td align="left" style="font-family: sans-serif; font-size: 14px; vertical-align: top; padding-bottom: 15px;" valign="top">
            <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: auto;">
              <tbody>
                <tr>
                  <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; background-color: #3498db; border-radius: 5px; text-align: center;" valign="top" bgcolor="#3498db" align="center">
                  <a href="#{url}" target="_blank" style="display: inline-block; color: #ffffff; background-color: #3498db; border: solid 1px #3498db; border-radius: 5px; box-sizing: border-box; cursor: pointer; text-decoration: none; font-size: 14px; font-weight: bold; margin: 0; padding: 12px 25px; text-transform: capitalize; border-color: #3498db;">#{title}</a>
                </td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
    </tbody>
    </table>
    """
  end

  def paragraph(content) do
    Phoenix.HTML.raw """
    <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">#{content}</p>
    """
  end
end
