class AddPagadoporToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :pagadopor, :string
  end
end
