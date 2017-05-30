defmodule Liingoew.Web.LayoutView do
  use Liingoew.Web, :view

  def js_view_name(view_module, view_template) do
    IO.puts(view_module_name(view_module) <> "." <> view_template_name(view_template))
    view_module_name(view_module) <> "." <> view_template_name(view_template)
  end

  defp view_module_name(module_name) do
    module_name
    |> Phoenix.Naming.resource_name
    |> Phoenix.Naming.camelize
  end

  defp view_template_name(template_name) do
    String.replace_suffix(template_name, ".html", "")
  end

  def js_script_tag do
    if Mix.env == :prod do
      ~s(<script src="/js/app.js"></script>)
    else
      ~s(<script src="http://localhost:8080/js/app.js"></script>)
    end
  end

  def css_link_tag do
    if Mix.env == :prod do
      ~s(<link rel="stylesheet" type="text/css" href="/css/app.css" media="screen,projection" />)
    else
      ""
    end
  end

end
