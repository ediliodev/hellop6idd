class RemoveTicketFromJugadalot < ActiveRecord::Migration[5.0]
  def change
    remove_column :jugadalots, :ticket, :string
  end
end
