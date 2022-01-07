class CreateLineatprints < ActiveRecord::Migration[5.0]
  def change
    create_table :lineatprints do |t|
      t.string :coliseo
      t.string :bloque
      t.string :pelea
      t.string :azul
      t.string :mla
      t.string :blanco
      t.string :mlb
      t.string :time
      t.string :under
      t.string :over
      t.string :status
      t.string :ganador
      t.string :tfinal

      t.timestamps
    end
  end
end
