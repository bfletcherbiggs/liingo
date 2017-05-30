defmodule Liingoew.Adjustment do
  use Liingoew.Web, :model

  schema "adjustments" do
    belongs_to :shipment, Liingoew.Shipment
    belongs_to :tax,      Liingoew.Tax
    belongs_to :order,    Liingoew.Order

    field :amount, :decimal

    timestamps()
    extensions()
  end

  @required_fields ~w(amount)a
  @optional_fields ~w(shipment_id tax_id order_id)a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

end
