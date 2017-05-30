defmodule Liingoew.Workflow.CheckVariantAvailability do
  alias Ecto.Multi

  def steps(variant, quantity, changeset) do
    Multi.new()
    |> Multi.run(:availability, &(ensure_variant_available(&1, variant, quantity, changeset)))
  end

  defp ensure_variant_available(changes, variant, quantity, changeset) when is_binary(quantity),
    do: ensure_variant_available(changes, variant, String.to_integer(quantity), changeset)

  defp ensure_variant_available(_changes, variant, quantity, changeset) do
    case Liingoew.Variant.availability_status(variant, quantity) do
      :ok ->
        {:ok, true}
      :discontinued ->
        {:error, Ecto.Changeset.add_error(changeset, :variant, "has been discontinued")}
      :out_of_stock ->
        {:error, Ecto.Changeset.add_error(changeset, :variant, "out of stock")}
      {:insufficient_quantity, available} ->
        {:error, Ecto.Changeset.add_error(changeset, :quantity, "only #{ available } available")}
    end
  end

end
