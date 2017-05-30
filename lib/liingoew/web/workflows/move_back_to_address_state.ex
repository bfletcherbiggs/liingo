defmodule Liingoew.Workflow.MoveBackToAddressState do
  alias Ecto.Multi

  def run(repo, order),
    do: repo.transaction(steps(order))

  def steps(order) do
    Multi.new()
    |> Multi.delete_all(:delete_payment, Liingoew.Query.Payment.for_order(order))
    |> Multi.delete_all(:delete_tax_adjustments, Liingoew.Query.Adjustment.tax_adjustments_for_order(order))
    |> Multi.delete_all(:delete_shipment_adjustments, Liingoew.Query.Adjustment.shipment_adjustments_for_order(order))
    |> Multi.delete_all(:delete_shipment_units, Liingoew.Query.ShipmentUnit.for_order(order))
    |> Multi.update(:update_state, Liingoew.Order.state_changeset(order, %{state: "address"}))
  end

end
