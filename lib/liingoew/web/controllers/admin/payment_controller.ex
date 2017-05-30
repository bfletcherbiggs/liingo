defmodule Liingoew.Web.Admin.PaymentController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.Repo
  alias Liingoew.Payment
  alias Liingoew.Order

  def show(conn, %{"id" => _payment_id, "order_id" => order_id}) do
    {order, payment} = load_order_and_payment(order_id)
    render(conn, "show.html", payment: payment, order: order)
  end

  def refund(conn, %{"payment_id" => _payment_id, "order_id" => order_id}) do
    {order, payment} = load_order_and_payment(order_id)
    case Liingoew.Gateway.refund_payment(payment) do
      {:ok} ->
        payment = Payment.refund_changeset(payment) |> Repo.update!
        conn
        |> put_flash(:success, "Successfully refunded the amount")
        |> redirect(to: admin_order_payment_path(conn, :show, order, payment))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to refund")
        |> redirect(to: admin_order_payment_path(conn, :show, order, payment))
    end
  end

  def capture(conn, %{"payment_id" => _payment_id, "order_id" => order_id}) do
    {order, payment} = load_order_and_payment(order_id)
    case Liingoew.Gateway.capture_payment(payment) do
      {:ok} ->
        payment = Payment.capture_changeset(payment) |> Repo.update!
        conn
        |> put_flash(:success, "Successfully captured the amount")
        |> redirect(to: admin_order_payment_path(conn, :show, order, payment))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Failed to capture the amount")
        |> redirect(to: admin_order_payment_path(conn, :show, order, payment))
    end
  end

  defp load_order_and_payment(order_id) do
    order = Repo.get!(Order, order_id) |> Repo.preload([payment: :payment_method])
    payment = order.payment
    {order, payment}
  end
end
