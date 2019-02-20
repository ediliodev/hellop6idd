class ChangeColumnToIntegerFromTicketsganadorest < ActiveRecord::Migration[5.0]
  def change
	change_column(:ticketsganadorests, :montoapostado, :integer)
	change_column(:ticketsganadorests, :montoacobrar, :integer)
  end
end
