# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Liingoew.Repo.insert!(%Liingoew.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Seed.LoadCountry.seed!
Seed.CreateZone.seed!
Liingoew.Repo.insert!(%Liingoew.User{name: "Admin", email: "admin@vinsol.com", encrypted_password: Comeonin.Bcrypt.hashpwsalt("vinsol"), is_admin: true})
Seed.LoadSettings.seed!
Seed.CreateShippingMethod.seed!
Seed.CreateTax.seed!
Seed.CreatePaymentMethod.seed!
Seed.LoadProducts.seed!
