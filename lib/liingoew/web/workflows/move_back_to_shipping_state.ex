defmodule Liingoew.Workflow.MoveBackToShippingState do
  alias Ecto.Multi

  def run(repo, order), do: repo.transaction(steps(order))

  def steps(order) do
    Multi.new()
    |> Multi.delete_all(:delete_payments, Liingoew.Query.Payment.for_order(order))
    |> Multi.update(:update_state, Liingoew.Order.state_changeset(order, %{state: "shipping"}))
  end
end
