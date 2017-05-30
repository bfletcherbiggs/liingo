defmodule Liingoew.Query.ShipmentUnit do
  use Liingoew.Query, model: Liingoew.ShipmentUnit

  def for_order(order),
    do: from o in Liingoew.ShipmentUnit, where: o.order_id == ^order.id
end
