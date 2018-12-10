class CreateLoteriats < ActiveRecord::Migration[5.0]
  def change
    create_table :loteriats do |t|
      t.string :nombre
      t.string :descripcion
      t.references :paist, foreign_key: true

      t.timestamps
    end
  end
end
