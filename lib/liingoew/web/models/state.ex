defmodule Liingoew.State do
  use Liingoew.Web, :model

  schema "states" do
    field :abbr, :string
    field :name, :string

    belongs_to :country, Liingoew.Country

    has_many :zone_members, {"state_zone_members", Liingoew.ZoneMember}, foreign_key: :zoneable_id
    has_many :zones, through: [:zone_members, :zone]

    timestamps()
    extensions()
  end

  @required_fields ~w(name abbr country_id)a
  @optional_fields ~w()a

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:country_id)
  end
end
