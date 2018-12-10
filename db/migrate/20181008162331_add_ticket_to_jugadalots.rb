class AddTicketToJugadalots < ActiveRecord::Migration[5.0]
  def change
    add_reference :jugadalots, :ticket, foreign_key: true
  end
end
