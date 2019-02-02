class AddLatitudToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :latitud, :string
  end
end
