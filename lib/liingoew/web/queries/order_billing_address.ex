defmodule Liingoew.Query.OrderBillingAddress do
  use Liingoew.Query, model: Liingoew.OrderBillingAddress

  def for_order(order),
    do: from o in Liingoew.OrderBillingAddress, where: o.order_id == ^order.id
end
