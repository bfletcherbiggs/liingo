defmodule Liingoew.Web.Admin.CheckoutController do
  use Liingoew.Web, :admin_controller

  plug :go_back_to_cart_if_empty when action in [:checkout, :next, :back]

  alias Liingoew.CheckoutManager
  alias Liingoew.Order

  def checkout(conn, _params) do
    order = Repo.get!(Order, conn.params["order_id"])
    changeset = CheckoutManager.next_changeset(Repo, order)
    data = CheckoutManager.view_data(Repo, order)
    render(conn, "checkout.html", order: order, changeset: changeset, data: data)
  end

  def next(conn, %{"order" => order_params}) do
    order = Repo.get!(Order, conn.params["order_id"])
    case CheckoutManager.next(Repo, order, order_params) do
      {:error, updated_changeset} ->
        data = CheckoutManager.view_data(Repo, order)
        render(conn, "checkout.html", order: order, changeset: updated_changeset, data: data)
      {:ok, %Liingoew.Order{state: "payment"} = updated_order} ->
        confirmed_order = Liingoew.Query.Order.get!(Repo, updated_order.id)
        redirect(conn, to: admin_order_path(conn, :show, confirmed_order))
      {:ok, updated_order} ->
        data = CheckoutManager.view_data(Repo, updated_order)
        render(conn, "checkout.html", order: updated_order, changeset: CheckoutManager.next_changeset(Repo, updated_order), data: data)
    end
  end

  def back(conn, _params) do
    order = Liingoew.Query.Order.get!(Repo, conn.params["order_id"])
    case CheckoutManager.back(Repo, order) do
      {:ok, _updated_order} ->
        redirect(conn, to: admin_order_checkout_path(conn, :checkout, order))
    end
  end

  def go_back_to_cart_if_empty(conn, _params) do
    order = Liingoew.Query.Order.get!(Repo, conn.params["order_id"]) |> Repo.preload([:line_items])
    if Liingoew.Order.cart_empty? order do
      conn
      |> put_flash(:error, "please add some products to cart before continuing")
      |> redirect(to: admin_cart_path(conn, :edit, order))
      |> halt
    else
      conn
    end
  end

end
