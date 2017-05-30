defmodule Liingoew.Web.Admin.UserView do
  use Liingoew.Web, :view

  def render("pending_orders.json", %{orders: orders}) do
    Enum.map(orders, fn (%Liingoew.Order{} = order)->
      %{edit_cart_link: admin_cart_path(Liingoew.Endpoint, :edit, order),
        state: order.state,
        created_on: order.inserted_at,
        continue_checkout_link: admin_order_checkout_path(Liingoew.Endpoint, :checkout, order)}
    end)
  end

end
