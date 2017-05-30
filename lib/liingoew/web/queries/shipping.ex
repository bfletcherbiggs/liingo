defmodule Liingoew.Query.Shipping do
  use Liingoew.Query, model: Liingoew.Shipping

  def for_order(%Liingoew.Order{id: order_id}) do
    from p in Liingoew.Shipping,
    where: p.order_id == ^order_id
  end

  def for_order(repo, order), do: repo.all(for_order(order))

end
