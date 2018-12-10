class CreateSorteots < ActiveRecord::Migration[5.0]
  def change
    create_table :sorteots do |t|
      t.string :nombre
      t.string :descripcion
      t.string :sigla
      t.references :horariosorteot, foreign_key: true
      t.references :loteriat, foreign_key: true
      t.string :activo
      t.string :abierto

      t.timestamps
    end
  end
end
