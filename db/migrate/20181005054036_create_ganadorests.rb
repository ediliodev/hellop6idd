class CreateGanadorests < ActiveRecord::Migration[5.0]
  def change
    create_table :ganadorests do |t|
      t.references :sorteot, foreign_key: true
      t.datetime :fecha
      t.integer :primero
      t.integer :segundo
      t.integer :tercero

      t.timestamps
    end
  end
end
