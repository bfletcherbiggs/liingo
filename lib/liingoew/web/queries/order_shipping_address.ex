defmodule Liingoew.Query.OrderShippingAddress do
  use Liingoew.Query, model: Liingoew.OrderShippingAddress

  def for_order(order),
    do: from o in Liingoew.OrderShippingAddress, where: o.order_id == ^order.id

end
