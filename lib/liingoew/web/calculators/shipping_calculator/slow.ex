defmodule Liingoew.ShippingCalculator.Slow do
  use Liingoew.ShippingCalculator.Base, shipping_rate: 2

  def applicable?(_shipping_unit) do
    false
  end
end
