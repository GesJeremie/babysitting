defmodule Babysitting.Avatar do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @acl :public_read

   def __storage, do: Arc.Storage.Local

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png"}
  end

  # Override the persisted filenames:
  def filename(version, _) do
    version
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "uploads/classifieds/avatars/#{uniq_id(scope.email)}"
  end

  defp uniq_id(string) do
    :md5
      |> :crypto.hash(string)
      |> Base.encode16
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
