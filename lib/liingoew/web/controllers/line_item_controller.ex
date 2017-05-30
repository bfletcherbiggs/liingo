defmodule Liingoew.Web.LineItemController do
  use Liingoew.Web, :controller

  alias Liingoew.CartManager

  plug :scrub_params, "line_item" when action in [:create]

  # TODO:
  # 1. Copy proper error message instead of the generic one.
  # 2. Reset cart if not in cart state.

  def create(conn, %{"line_item" => line_item_params}) do
    {:ok, order} = Liingoew.CheckoutManager.back(Repo, conn.assigns.current_order, "cart")
    case CartManager.add_to_cart(order, line_item_params) do
      {:ok, _line_item} ->
        conn
        |> put_flash(:success, "Added product succcesfully")
        |> redirect(to: cart_path(conn, :show))
      {:error, changeset} ->
        product = Liingoew.Repo.get!(Liingoew.Product, line_item_params["product_id"])
        conn
        |> put_flash(:error, extract_error_message(changeset))
        |> redirect(to: product_path(conn, :show, product))
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item = Repo.get!(Liingoew.LineItem, id)
    Liingoew.Repo.delete!(line_item)
    conn
    |> put_flash(:success, "Removed product succesfully")
    |> redirect(to: cart_path(conn, :show))
  end

  defp extract_error_message(%Ecto.Changeset{errors: errors}) do
    Enum.map(errors, fn ({key, value}) -> to_string(key) <> " " <> Liingoew.Web.ErrorHelpers.translate_error(value) end)
    |> Enum.reduce("", fn(error_message, acc) -> acc <> error_message <> ". " end)
  end

end
