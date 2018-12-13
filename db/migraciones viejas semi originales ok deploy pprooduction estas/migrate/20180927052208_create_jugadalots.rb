class CreateJugadalots < ActiveRecord::Migration[5.0]
  def change
    create_table :jugadalots do |t|
      t.string :ticket
      t.integer :n1
      t.integer :n2
      t.integer :n3
      t.integer :monto
      t.string :qpt
      t.string :sorteo

      t.timestamps
    end
  end
end
