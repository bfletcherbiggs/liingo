defmodule Liingoew.Query.Adjustment do
  use Liingoew.Query, model: Liingoew.Adjustment

  def for_order(%Liingoew.Order{id: order_id}) do
    from p in Liingoew.Adjustment,
    where: p.order_id == ^order_id
  end

  def for_order(repo, order), do: repo.all(for_order order)

  def tax_adjustments_for_order(order),
    do: from o in for_order(order), where: not(is_nil(o.tax_id))

  def shipment_adjustments_for_order(order),
    do: from o in for_order(order), where: not(is_nil(o.shipment_id))

end
