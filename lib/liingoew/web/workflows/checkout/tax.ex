defmodule Liingoew.Workflow.Checkout.Tax do
  alias Ecto.Multi

  def run(repo, order, params),
    do: repo.transaction(steps(repo, order, params))

  def order_with_preloads(repo, order) do
    order
    |> repo.preload([adjustments: [:tax, shipment: :shipping_method]])
  end

  def changeset_for_step(order, params \\ %{}) do
    Liingoew.Order.tax_changeset(order, params)
  end

  def steps(repo, order, params) do
    order = order_with_preloads(repo, order)
    changeset = changeset_for_step(order, params)
    Multi.new()
    |> Multi.append(pre_transition(repo, changeset))
    |> Multi.update(:order, changeset)
    |> Multi.run(:post, &(post_transition(repo, &1.order)))
  end

  def view_data(_, _),
    do: %{}

  def pre_transition(_repo, _order_changeset) do
    Multi.new()
  end

  def post_transition(repo, order) do
    Multi.new()
    |> Multi.append(Liingoew.Workflow.SettleAdjustmentAndProductPaymentForOrder.steps(repo, order))
    |> repo.transaction()
  end
end
