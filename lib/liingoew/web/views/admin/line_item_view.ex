defmodule Liingoew.Web.Admin.LineItemView do
  use Liingoew.Web, :view

  alias Liingoew.Admin.VariantView

  def render("line_item.json", %{line_item: line_item}) do
    line_item = Liingoew.Repo.get!(Liingoew.LineItem, line_item.id) |> Liingoew.Repo.preload([variant: [:product, [option_values: :option_type]]])
    if line_item.variant.is_master do
      %{id: line_item.id,
        quantity: line_item.quantity,
        variant: %{
          display_name: "#{line_item.variant.product.name}",
          id: line_item.variant.id}}
    else
      %{id: line_item.id,
        quantity: line_item.quantity,
        variant: %{
          display_name: "#{line_item.variant.product.name} #{VariantView.variant_options_text(line_item.variant)}",
          id: line_item.variant.id}}
    end
  end

  def render("error.json", %{changeset: changeset}) do
    render_changeset_error_json(changeset)
  end
end
