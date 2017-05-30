defmodule Liingoew.Query.PaymentMethod do
  use Liingoew.Query, model: Liingoew.PaymentMethod

  def enabled_payment_methods do
    from pay in Liingoew.PaymentMethod,
    where: pay.enabled
  end

  def enabled_payment_methods(repo), do: repo.all(enabled_payment_methods())
end
