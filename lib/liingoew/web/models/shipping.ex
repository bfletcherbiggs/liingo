defmodule Liingoew.Shipping do
  use Liingoew.Web, :model

  schema "shippings" do
    belongs_to :order, Liingoew.Order
    belongs_to :shipping_method, Liingoew.ShippingMethod
    has_one :adjustment, Liingoew.Adjustment
    field :shipping_state, :string, default: "shipment_created"

    timestamps()
    extensions()
  end

  #@shipping_states ~w(shipment_created pending shipped received return_initiated picked_up return_received)

  @required_fields ~w(shipping_method_id)a
  @optional_fields ~w()a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def applicable_shipping_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:adjustment)
    |> foreign_key_constraint(:shipping_method_id)
  end

end
