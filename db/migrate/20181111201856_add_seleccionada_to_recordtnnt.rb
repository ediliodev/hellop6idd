class AddSeleccionadaToRecordtnnt < ActiveRecord::Migration[5.0]
  def change
    add_column :recordtnnts, :seleccionada, :string
  end
end
