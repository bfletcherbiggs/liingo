defmodule Liingoew.Query.ShippingMethod do
  use Liingoew.Query, model: Liingoew.ShippingMethod

  def enabled_shipping_methods do
    from shipp in Liingoew.ShippingMethod,
    where: shipp.enabled
  end

  def enabled_shipping_methods(repo), do: repo.all(enabled_shipping_methods())

end
