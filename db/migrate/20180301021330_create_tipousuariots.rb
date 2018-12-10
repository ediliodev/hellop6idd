class CreateTipousuariots < ActiveRecord::Migration[5.0]
  def change
    create_table :tipousuariots do |t|
      t.string :tipo_usuario
      t.string :descripcion

      t.timestamps
    end
  end
end
