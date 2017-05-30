defmodule Liingoew.PaymentMethod do

  use Liingoew.Web, :model

  schema "payment_methods" do
    field :name, :string
    has_many :payments, Liingoew.Payment
    field :enabled, :boolean, default: false

    extensions()
  end

  @required_fields ~w(name)a
  @optional_fields ~w(enabled)a

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
