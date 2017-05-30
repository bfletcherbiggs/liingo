defmodule Liingoew.Query.Payment do
  use Liingoew.Query, model: Liingoew.Payment

  def for_order(%Liingoew.Order{id: order_id}) do
    from p in Liingoew.Payment,
    where: p.order_id == ^order_id
  end

end
