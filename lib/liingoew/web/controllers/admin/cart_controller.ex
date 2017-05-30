defmodule Liingoew.Web.Admin.CartController do
  use Liingoew.Web, :admin_controller

  def new(conn, _params) do
    users = Liingoew.Repo.all(Liingoew.User)
    cart_changeset = Liingoew.Order.cart_changeset(%Liingoew.Order{}, %{})
    render(conn, "new.html", users: users, cart_changeset: cart_changeset)
  end

  # use guest checkout unless user id provided.
  def create(conn, %{"order" => %{"user_id" => ""}}) do
    order = Liingoew.Command.Order.create_empty_cart_for_guest!(Repo)
    conn
    |> redirect(to: admin_cart_path(conn, :edit, order))
  end

  def create(conn, %{"order" => %{"user_id" => user_id}}) do
    order = Liingoew.Command.Order.create_empty_cart_for_user!(Repo, user_id)
    conn
    |> redirect(to: admin_cart_path(conn, :edit, order))
  end

  def edit(conn, %{"id" => id}) do
    {:ok, order} = Repo.get!(Liingoew.Order, id) |> Liingoew.CheckoutManager.back("cart")
    products  =
      Liingoew.Query.Product.all(Repo)
      |> Repo.preload([variants: [option_values: :option_type]])

    line_items =
      Liingoew.Query.LineItem.in_order(Repo, order)
      |> Repo.preload([variant: [:product, [option_values: :option_type]]])

    render(conn, "edit.html", order: order, products: products, line_items: line_items)
  end

end
