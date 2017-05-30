defmodule Liingoew.TaxCalculator do

  def calculate_taxes(repo, order) do
    taxes = Liingoew.Query.Tax.all(repo)
    _tax_adjustments = Enum.map(taxes, fn (tax) ->
      Liingoew.Command.Adjustment.create_tax_adjustment!(repo, order, tax, 20.00)
    end)
  end

end
