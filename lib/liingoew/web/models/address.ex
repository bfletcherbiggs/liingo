defmodule Liingoew.Address do
  use Liingoew.Web, :model

  schema "addresses" do
    field :address_line_1, :string
    field :address_line_2, :string

    belongs_to :state, Liingoew.State
    belongs_to :country, Liingoew.Country

    has_one :user_address, Liingoew.UserAddress
    has_one :user, through: [:user_address, :user]

    has_many :order_billing_addresses, Liingoew.OrderBillingAddress
    has_many :billing_orders, through: [:order_billing_addresses, :order]

    has_many :order_shipping_addresses, Liingoew.OrderShippingAddress
    has_many :shipping_order, through: [:order_shipping_addresses, :order]

    timestamps()
    extensions()
  end

  @required_fields ~w(address_line_1 address_line_2 country_id state_id)a
  @optional_fields ~w()a

  # currently called by order's build assoc
  # ensure all other keys are set
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:address_line_1, min: 10)
    |> validate_length(:address_line_2, min: 10)
    |> foreign_key_constraint(:state_id)
    |> foreign_key_constraint(:country_id)
  end

  def registered_user_changeset(model, params \\ :empty) do
    changeset(model, params)
    |> cast_assoc(:user_address, required: true)
  end

end
