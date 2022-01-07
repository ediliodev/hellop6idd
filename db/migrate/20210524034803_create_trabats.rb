class CreateTrabats < ActiveRecord::Migration[5.0]
  def change
    create_table :trabats do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
