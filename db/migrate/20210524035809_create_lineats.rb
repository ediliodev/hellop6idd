class CreateLineats < ActiveRecord::Migration[5.0]
  def change
    create_table :lineats do |t|
      t.string :coliseo
      t.string :bloque
      t.string :pelea
      t.string :azul
      t.string :blanco
      t.string :mla
      t.string :mlb
      t.string :tiempoml
      t.string :oua
      t.string :oub
      t.string :status
      t.string :resultado
      t.string :tiempofinalizado

      t.timestamps
    end
  end
end
