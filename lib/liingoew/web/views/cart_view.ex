defmodule Liingoew.Web.CartView do
  use Liingoew.Web, :view

  def cart_empty?(%Liingoew.Order{line_items: []}), do: true
  def cart_empty?(%Liingoew.Order{} = _order), do: false
end
