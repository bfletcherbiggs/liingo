defmodule Liingoew.Web.Admin.SettingController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.Setting

  def edit(conn, %{"id" => slug}) do
    setting = Liingoew.Query.Setting.get_by!(Repo, slug: slug)
    changeset = Setting.changeset(setting)
    render(conn, "edit.html", setting: setting, changeset: changeset)
  end

  def update(conn, %{"id" => slug, "setting" => setting_params}) do
    setting = Liingoew.Query.Setting.get_by!(Repo, slug: slug)
    case Liingoew.Command.Setting.update(Repo, setting, setting_params) do
      {:ok, setting} ->
        changeset = Setting.changeset(setting)
        conn
        |> put_flash(:info, "Setting updated successfully.")
        |> render("edit.html", setting: setting, changeset: changeset)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong. Please try again.")
        |> render("edit.html", setting: setting, changeset: changeset)
    end
  end

  def shipping_method_settings(conn, _params) do
    shipping_methods = Liingoew.Query.ShippingMethod.all(Repo)
    render(conn, "shipping.html", shipping_methods: shipping_methods)
  end

  def update_shipping_method_settings(conn, %{"shipping_methods" => params}) do
    Liingoew.Command.ShippingMethod.make_active_enabled_and_disable_other(Repo, params)
    conn
    |> put_flash(:info, "Updated Shipping methods succesfully")
    |> redirect(to: admin_setting_path(conn, :shipping_method_settings))
  end

  def payment_method_settings(conn, _params) do
    payment_methods = Liingoew.Query.PaymentMethod.all(Repo)
    render(conn, "payment.html", payment_methods: payment_methods)
  end

  def update_payment_method_settings(conn, %{"payment_methods" => params}) do
    Liingoew.Command.PaymentMethod.make_active_enabled_and_disable_other(Repo, params)
    conn
    |> put_flash(:info, "Updated Payment methods succesfully")
    |> redirect(to: admin_setting_path(conn, :payment_method_settings))
  end

end
