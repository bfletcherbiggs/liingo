defmodule Liingoew.Workflow.AuthorizePayment do
  alias Ecto.Multi

  def run(repo, order_changeset), do: repo.transaction(steps(repo, order_changeset))

  def steps(repo, order_changeset) do
    Multi.new()
    |> Multi.run(:transaction_id, &(process_payment(&1, repo, order_changeset)))
  end

  defp process_payment(_changes, repo, order_changeset) do
    case order_changeset.valid? do
      true ->
        params                = order_changeset.params
        payment_params        = params["payment"] || params.payment
        payment_method_id     = payment_params["payment_method_id"] || payment_params[:payment_method_id]
        payment_method        = Liingoew.Query.PaymentMethod.get!(repo, payment_method_id) |> Map.get(:name)
        payment_method_params = params["payment_method"] || params[:payment_method] || %{}

        case Liingoew.Gateway.authorize_payment(order_changeset.data, payment_method, payment_method_params) do
          {:ok, transaction_id}   -> {:ok, transaction_id}
          {:error, error_message} -> {:error, Ecto.Changeset.add_error(order_changeset, :payment, error_message)}
        end
      false ->
        {:error, order_changeset}
    end
  end
end
