defmodule Liingoew.Web.Admin.SettingView do
  use Liingoew.Web, :view

  def setting_name(%Phoenix.HTML.Form{data: %Liingoew.SettingPair{name: name}}) do
    Phoenix.Naming.humanize(name)
  end
end
