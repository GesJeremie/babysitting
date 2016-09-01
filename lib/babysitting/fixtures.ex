defmodule Babysitting.Fixtures do

  import Ecto

  alias FakerElixir, as: Faker
  alias Babysitting.Classified
  
  def fixture(:classified) do
    %Classified{
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
