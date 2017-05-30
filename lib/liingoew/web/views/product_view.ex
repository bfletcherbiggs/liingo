defmodule Liingoew.Web.ProductView do
  use Liingoew.Web, :view

  defdelegate only_master_variant?(product), to: Liingoew.Admin.CartView

  def product_variant_options(%Liingoew.Product{} = product) do
    Enum.map(product.variants, fn(variant) ->
      {variant_name(variant), variant.id}
    end)
  end

  defp out_of_stock?(variant) do
    Liingoew.Variant.available_quantity(variant) == 0
  end

  def variant_name(variant) do
    Liingoew.Admin.VariantView.variant_options_text(variant)
    <> if out_of_stock?(variant) do
      " (out of stock)"
    else
      ""
    end
  end

end
