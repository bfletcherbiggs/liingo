defmodule Liingoew.Query.Shipment do
  use Liingoew.Query, model: Liingoew.Shipment

  def for_order(order) do
    from o in Liingoew.Shipment,
      join: p in assoc(o, :shipment_unit),
      where: p.order_id == ^order.id
  end
end
