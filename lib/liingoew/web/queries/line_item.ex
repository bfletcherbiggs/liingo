defmodule Liingoew.Query.LineItem do
  use Liingoew.Query, model: Liingoew.LineItem

  def in_order_query(%Liingoew.Order{id: order_id}, query \\ Liingoew.LineItem) do
    from c in query, where: c.order_id == ^order_id
  end

  def in_order(repo, order, query \\ Liingoew.LineItem), do: repo.all(in_order_query(order, query))

  def with_variant_query(%Liingoew.Variant{id: variant_id}, query \\ Liingoew.LineItem) do
    from c in query, where: c.variant_id == ^variant_id
  end

  def with_variant(repo, variant, query \\ Liingoew.LineItem), do: repo.all(with_variant_query(variant, query))

  def in_order_with_variant(order, variant),
    do: with_variant_query(variant, in_order_query(order))

  def in_order_with_variant(repo, order, variant),
    do: repo.one(in_order_with_variant(order, variant))
end
