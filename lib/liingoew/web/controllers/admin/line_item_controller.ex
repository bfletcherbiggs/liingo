defmodule Liingoew.Web.Admin.LineItemController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.LineItem
  alias Liingoew.CartManager

  plug :scrub_params, "line_item" when action in [:create]

  def create(conn, %{"line_item" => line_item_params}) do
    case CartManager.add_to_cart(conn.params["order_id"], line_item_params) do
      {:ok, line_item} ->
        conn
        |> put_status(201)
        |> render("line_item.json", line_item: line_item)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item = Repo.get!(LineItem, id)
    Repo.delete!(line_item)
    conn
    |> put_status(:no_content)
    |> json(nil)
  end

  def update_fullfillment(conn, %{"order_id" => _id, "line_item_id" => line_item_id}) do
    line_item = Repo.get!(LineItem, line_item_id) |> Repo.preload([:variant, :order])
    case Liingoew.Workflow.CancelLineItemFullfillment.run(Repo, line_item) do
      {:ok, _line_item} ->
        conn
        |> put_status(:no_content)
        |> json(nil)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end
end
