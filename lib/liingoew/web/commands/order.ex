defmodule Liingoew.Command.Order do
  use Liingoew.Command, model: Liingoew.Order

  def insert!(_repo, _params), do: raise "insert not allowed, please use other commands"
  def insert(_repo, _params),  do: raise "insert not allowed, please use other commands"
  def update(_repo, _params),  do: raise "please use the proper workflow for updating order"

  def create_empty_cart_for_guest!(repo),
    do: Liingoew.Order.cart_changeset(%Liingoew.Order{}, %{}) |> repo.insert!

  def create_empty_cart_for_user!(repo, user_id),
    do: Liingoew.Order.user_cart_changeset(%Liingoew.Order{}, %{user_id: user_id}) |> repo.insert!

  def update_with_order_settlement(repo, order, params) do
    Liingoew.Order.settlement_changeset(order, params)
    |> repo.update
  end

  def delete_addresses(repo, order) do
    repo.transaction(fn ->
      repo.delete_all(Liingoew.Query.Order.shipping_address(order))
      repo.delete_all(Liingoew.Query.Order.billing_address(order))
    end)
  end

  def delete_payment(repo, order) do
   repo.delete_all(Liingoew.Query.Order.payment(order))
  end

  def delete_tax_adjustments(repo, order) do
    repo.delete_all(Liingoew.Query.Order.tax_adjustments(order))
  end

  def delete_shipment_units(repo, order) do
    repo.delete_all(Liingoew.Query.Order.shipment_units(order))
  end

  def delete_shipment_adjustments(repo, order) do
    repo.delete_all(Liingoew.Query.Order.shipment_adjustments(order))
  end

  def delete_shipments(repo, order) do
    repo.delete_all(Liingoew.Query.Order.shipments(order))
  end

  def link_to_user!(repo, order, user_id) do
    repo.update!(Liingoew.Order.link_to_user_changeset(order, %{user_id: user_id}))
  end

  def mark_as_cancelled(repo, order) do
    repo.update(Liingoew.Order.cancellation_changeset(order))
  end

end
