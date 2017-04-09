defmodule Babysitting.TenantView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  @doc """
  Check if the current tenant is bordeaux
  """
  def is_tenant_bordeaux(conn) do
    AppHelper.is_current_tenant(:bordeaux, conn)
  end

end
