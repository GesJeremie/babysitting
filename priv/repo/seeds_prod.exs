# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Babysitting.Repo.insert!(%Babysitting.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Babysitting.Factory

# Let's create the base tenants
tenant_paris = insert(:tenant_paris)
tenant_bordeaux = insert(:tenant_bordeaux)
tenant_london = insert(:tenant_london)

# Let's fill the classifieds of the older version
