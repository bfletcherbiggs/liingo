defmodule Liingoew.Gateway do
  def authorize_payment(order, method_name, params) do
    apply(payment_module(method_name), :authorize, [order, params[method_name]])
  end

  def refund_payment(payment) do
    do_refund_payment(payment, selected_payment_method(payment.payment_method_id))
  end

  defp selected_payment_method(selected_payment_id) do
    Liingoew.Repo.get!(Liingoew.PaymentMethod, selected_payment_id) |> Map.get(:name)
  end

  def capture_payment(payment) do
    do_capture_payment(payment, selected_payment_method(payment.payment_method_id))
  end

  defp do_capture_payment(payment, method_name) do
    apply(payment_module(method_name), :capture, [payment.transaction_id])
  end

  defp do_refund_payment(payment, method_name) do
    apply(payment_module(method_name), :refund, [payment.transaction_id, payment.amount])
  end

  def payment_module(method_name) do
    Module.concat(Liingoew.Gateway, (Macro.camelize method_name))
  end
end
