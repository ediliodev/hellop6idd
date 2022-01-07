class AddColumnsToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :parlay, :string
    add_column :tickets, :pagoreal, :string
  end
end
