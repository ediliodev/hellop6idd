class CreateMensajepiedepaginats < ActiveRecord::Migration[5.0]
  def change
    create_table :mensajepiedepaginats do |t|
      t.string :tipodemensaje
      t.string :mensaje

      t.timestamps
    end
  end
end
