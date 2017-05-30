defmodule Liingoew.Web.CategoryController do
  use Liingoew.Web, :controller

  alias Liingoew.SearchProduct

  def associated_products(conn, %{"category_id" => id}) do
    category =
      Liingoew.Query.Category.get!(Repo, id)
      |> Repo.preload([products: Liingoew.Query.Product.products_with_master_variant])

    products = category.products
    categories = Liingoew.Query.Category.with_associated_products(Repo)

    search_changeset = SearchProduct.changeset(%SearchProduct{})
    search_action = product_path(conn, :index)

    render conn, "products.html",
      categories: categories,
      products: products,
      search_action: search_action,
      search_changeset: search_changeset
  end

end
