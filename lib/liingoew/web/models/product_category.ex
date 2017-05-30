defmodule Liingoew.ProductCategory do
  use Liingoew.Web, :model

  schema "product_categories" do
    belongs_to :product, Liingoew.Product
    belongs_to :category, Liingoew.Category

    field :delete, :boolean, virtual: true, default: false

    timestamps()
    extensions()
  end

  @required_fields ~w(product_id category_id)a
  @optional_fields ~w()a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def from_product_changeset(model, params \\ %{}) do
    cast(model, params, ~w(category_id), ~w(delete))
    |> set_delete_action
    |> unique_constraint(:category_id, name: :unique_product_category)
  end

  def set_delete_action(changeset) do
    if get_change(changeset, :delete) do
      %{changeset| action: :delete}
    else
      changeset
    end
  end

end
