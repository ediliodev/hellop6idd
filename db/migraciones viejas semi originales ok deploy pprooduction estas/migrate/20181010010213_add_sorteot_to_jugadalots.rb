class AddSorteotToJugadalots < ActiveRecord::Migration[5.0]
  def change
    add_reference :jugadalots, :sorteot, foreign_key: true
  end
end
