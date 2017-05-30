defmodule Liingoew.Command.Variant do
  use Liingoew.Command, model: Liingoew.Variant

  def insert_for_product(repo, product, params) do
    product
    |> Ecto.build_assoc(:variants)
    |> Liingoew.Variant.create_variant_changeset(product, params)
    |> repo.insert
  end

  def update_for_product(repo, variant, product, params) do
    Liingoew.Variant.update_variant_changeset(variant, product, params)
    |> repo.update
  end

end
