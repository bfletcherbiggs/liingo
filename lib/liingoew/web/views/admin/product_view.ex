defmodule Liingoew.Web.Admin.ProductView do
  use Liingoew.Web, :view

  import Ecto.Query
  alias Liingoew.Repo
  alias Liingoew.Product
  alias Liingoew.ProductOptionType
  alias Liingoew.OptionType
  alias Liingoew.ProductCategory

  def link_to_product_option_types_fields do
    changeset = Product.changeset(%Product{product_option_types: [%ProductOptionType{}]})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    get_option_types = Repo.all(from o in OptionType, select: {o.name, o.id})
    fields = render_to_string(__MODULE__, "product_option_types.html", f: form, get_option_types: get_option_types)
    link "Add Option Type", to: "#", "data-template": fields, id: "add_product_option_type"
  end

  def link_to_product_category_fields(leaf_categories) do
    changeset = Product.changeset(%Product{product_categories: [%ProductCategory{}]})
    form = Phoenix.HTML.FormData.to_form(changeset, [])
    categories = leaf_categories
    fields = render_to_string(__MODULE__, "product_categories.html", f: form, categories: categories)
    link "Add Category", to: "#", "data-template": fields, id: "add_product_category"
  end

end
