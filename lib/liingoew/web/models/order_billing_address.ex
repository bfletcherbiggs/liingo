defmodule Liingoew.OrderBillingAddress do
  use Liingoew.Web, :model

  schema "order_billing_addresses" do
    belongs_to :order, Liingoew.Order
    belongs_to :address, Liingoew.Address

    timestamps()
    extensions()
  end

  @required_fields ~w()
  @optional_fields  ~w(order_id)
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:address, required: true)
  end
end
