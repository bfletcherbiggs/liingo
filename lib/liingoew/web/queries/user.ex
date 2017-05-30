defmodule Liingoew.Query.User do
  use Liingoew.Query, model: Liingoew.User

  def current_order(repo, user) do
    repo.one(
      from order in all_abandoned_orders(user),
      order_by: [desc: order.updated_at],
      limit: 1
    )
  end

  def all_abandoned_orders(%Liingoew.User{} = user) do
    from order in all_orders(user),
      where: not(order.state == "confirmation")
  end

  def all_orders(%Liingoew.User{id: id}) do
    from o in Liingoew.Order,
      where: o.user_id == ^id
  end

  def all_abandoned_orders(repo, user), do: repo.all(all_abandoned_orders(user))

end
