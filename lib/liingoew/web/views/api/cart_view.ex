defmodule Liingoew.Web.Api.CartView do
  use Liingoew.Web, :view
  def render("cart.json",  %{order: order, summary: "true", conn: conn}) do
    %{
      items_in_cart: Liingoew.CartManager.count_items_in_cart(order),
      id: order.id,
      line_items: line_items(order, conn),
      total: order.product_total
    }
  end

  def render("cart.json", %{order: order}) do
    %{order_id: order.id}
  end

  defp line_items(order, conn) do
    Enum.map(order.line_items, fn(ln_item) ->
      %{name:     ln_item.variant.product.name <> Liingoew.ProductView.variant_name(ln_item.variant),
        quantity: ln_item.quantity,
        total:    ln_item.total,
        path:     product_path(conn, :show, ln_item.variant.product)}
    end)
  end
end
