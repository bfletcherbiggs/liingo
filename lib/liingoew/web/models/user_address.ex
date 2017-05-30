defmodule Liingoew.UserAddress do
  use Liingoew.Web, :model

  schema "user_addresses" do
    belongs_to :user, Liingoew.User
    belongs_to :address, Liingoew.Address

    timestamps()
    extensions()
  end

  @required_fields ~w()a
  @optional_fields ~w(user_id)a
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(), @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:address, required: true)
  end

end
