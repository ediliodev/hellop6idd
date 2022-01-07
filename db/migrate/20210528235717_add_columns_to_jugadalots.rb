class AddColumnsToJugadalots < ActiveRecord::Migration[5.0]
  def change
    add_column :jugadalots, :pelea, :string
    add_column :jugadalots, :apuestacinta, :string
    add_column :jugadalots, :ml, :string
    add_column :jugadalots, :posiblepago, :string
    add_column :jugadalots, :acierto, :string
    add_column :jugadalots, :resultado, :string
    add_column :jugadalots, :pagoreal, :string
  end
end
