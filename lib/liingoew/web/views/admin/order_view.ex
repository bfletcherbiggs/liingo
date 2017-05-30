defmodule Liingoew.Web.Admin.OrderView do
  use Liingoew.Web, :view

  alias Liingoew.Admin.VariantView

  def only_master_variant?(%Liingoew.Product{variants: [_]}), do: true
  def only_master_variant?(%Liingoew.Product{variants: [_|_]}), do: false

  def out_of_stock?(%Liingoew.Variant{} = variant), do: Liingoew.Variant.available_quantity(variant) == 0

  def product_variant_options(%Liingoew.Product{} = product) do
    Enum.map(product.variants, fn
      (%Liingoew.Variant{is_master: true}) -> "" # Do not add master variant to product list
      (variant) ->
        content_tag(:option, value: variant.id, disabled: out_of_stock?(variant)) do
        # TODO maybe autogenerate sku if one is not provided
          (VariantView.variant_options_text(variant))
          <> if out_of_stock?(variant) do
            "(Out of stock)"
          else
            ""
          end
        end
    end)
  end

  def master_variant_id(%Liingoew.Product{variants: [master_variant]}), do: master_variant.id

  def shipment_items(shipment_unit) do
    Enum.reduce(shipment_unit.line_items, "", &("#{&2}" <> line_item_display_name(&1) <> ", "))
  end

  def line_item_display_name(line_item) do
    ## Assuming everything pre-loaded
    variant = line_item.variant
    product = variant.product
    product.name <> VariantView.variant_options_text(variant)
  end
end
