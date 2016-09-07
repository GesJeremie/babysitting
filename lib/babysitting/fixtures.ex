defmodule Babysitting.Fixtures do

  import Ecto

  alias FakerElixir, as: Faker
  alias Babysitting.{Classified, Tenant, Contact, Repo}

  @doc """
  Create tenant with fake data
  """
  def fixture(:tenant) do
    Repo.insert! %Tenant{
      name: Faker.Address.city,
      domain: Faker.Internet.url,
      slug: Faker.Helper.pick(["paris", "bordeaux", "london", "barcelona", "nantes", "marseille"]),
      locale: Faker.Helper.pick(["fr_FR", "en_GB", "fr_FR", "fr_FR"])
    }
  end

  @doc """
  Create tenant paris
  """
  def fixture(:tenant, :paris) do
    Repo.insert! %Tenant{
      :name => "Paris",
      :domain => "www.babysittingparis.dev",
      :slug => "paris",
      :facebook => "https://www.facebook.com/parisBabySitting/",
      :locale => "fr_FR"
    }
  end

  @doc """
  Create tenant bordeaux
  """
  def fixture(:tenant, :bordeaux) do
    Repo.insert! %Tenant{
      :name => "Bordeaux",
      :domain => "www.babysittingbordeaux.dev",
      :slug => "bordeaux",
      :facebook =>"https://www.facebook.com/babySittingBordeaux",
      :locale => "fr_FR"
    }
  end

  @doc """
  Create tenant london
  """
  def fixture(:tenant, :london) do
    Repo.insert! %Tenant{
      :name => "London",
      :domain => "www.babysittinglondon.co.uk.dev",
      :slug => "london",
      :facebook =>"https://www.facebook.com/Baby-Sitting-London-552729038239860",
      :locale => "en_GB"
    }
  end

  @doc """
  Create classified
  """
  def fixture(:classified, assoc \\ []) do

    tenant = assoc[:tenant] || fixture(:tenant)

    Repo.insert! %Classified{
      tenant_id: tenant.id,
      email: Faker.Internet.email,
      password: Faker.Crypto.md5,
      firstname: Faker.Name.first_name,
      lastname: Faker.Name.last_name,
      phone: Faker.Phone.cell,
      birthday: Faker.Date.birthday,
      description: Faker.Lorem.sentences(3..6),
      token: UUID.uuid1(),
      search: "",
      status: Faker.Boolean.boolean,
      valid: Faker.Boolean.boolean
    }
  end

end
