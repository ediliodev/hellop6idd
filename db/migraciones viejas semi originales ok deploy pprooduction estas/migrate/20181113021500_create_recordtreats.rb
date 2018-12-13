class CreateRecordtreats < ActiveRecord::Migration[5.0]
  def change
    create_table :recordtreats do |t|
      t.references :ticket, foreign_key: true
      t.integer :n1
      t.integer :n2
      t.integer :n3
      t.string :siglas
      t.integer :monto
      t.string :seleccionada

      t.timestamps
    end
  end
end
