defmodule Liingoew.ShippingCalculator.Random do
  use Liingoew.ShippingCalculator.Base

  def shipping_rate(_order) do
    :rand.seed(:exs1024)
    Decimal.new(:rand.uniform(200))
  end
end
