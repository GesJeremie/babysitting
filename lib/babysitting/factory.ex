defmodule Babysitting.Factory do
  use ExMachina.Ecto, repo: Babysitting.Repo
  alias Babysitting.{Tenant, Classified}
  alias FakerElixir, as: Faker

  def tenant_factory do
    %Tenant{
      name: Faker.Address.city,
      domain: Faker.Internet.url,
      facebook: Faker.Helper.letterify("https://www.facebook.com/babysitting#######"),
      slug: Faker.Helper.pick(["paris", "bordeaux", "london", "barcelona", "nantes", "marseille"]),
      locale: Faker.Helper.pick(["fr_FR", "en_GB", "fr_FR", "fr_FR"])
    }
  end

  def classified_factory do
    %Classified{
      tenant: build(:tenant),
      email: Faker.Helper.unique!(:emails, fn -> Faker.Internet.email end),
      password: Faker.Crypto.md5,
      firstname: Faker.Name.first_name,
      lastname: Faker.Name.last_name,
      phone: Faker.Phone.cell,
      birthday: Faker.Helper.numerify("03/10/19##"),
      description: Faker.Lorem.sentences(3..6),
      token: UUID.uuid1(),
      search: "",
      status: Faker.Boolean.boolean,
      valid: Faker.Boolean.boolean
    }
  end

end
