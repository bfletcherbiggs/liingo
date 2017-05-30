defmodule Liingoew.Workflow.MoveStockBackFromLineItem do
  alias Ecto.Multi

  def run(repo, variant, restock_quantity), do: repo.transaction(steps(variant, restock_quantity))

  def steps(variant, quantity) do
    changeset = Liingoew.Variant.restocking_changeset(variant, %{restock_count: quantity})
    Multi.new()
    |> Multi.update(:variant_restock, changeset)
  end
end
