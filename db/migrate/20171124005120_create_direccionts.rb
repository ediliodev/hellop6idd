class CreateDireccionts < ActiveRecord::Migration[5.0]
  def change
    create_table :direccionts do |t|
      t.string :direccion
      t.string :sector
      t.references :cuidadt, foreign_key: true

      t.timestamps
    end
  end
end
