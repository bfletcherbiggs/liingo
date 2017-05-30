defmodule Liingoew.Command.Adjustment do
  use Liingoew.Command, model: Liingoew.Adjustment

  def create_tax_adjustment!(repo, order, tax, calculated_amount) do
    order
    |> Ecto.build_assoc(:adjustments)
    |> Liingoew.Adjustment.changeset(%{amount: calculated_amount, tax_id: tax.id})
    |> repo.insert!
  end
end
