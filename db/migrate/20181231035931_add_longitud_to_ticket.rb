class AddLongitudToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :longitud, :string
  end
end
