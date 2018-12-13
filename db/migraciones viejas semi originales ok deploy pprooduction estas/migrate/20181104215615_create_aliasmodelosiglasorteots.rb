class CreateAliasmodelosiglasorteots < ActiveRecord::Migration[5.0]
  def change
    create_table :aliasmodelosiglasorteots do |t|
      t.string :nombre
      t.string :siglasorteo
      t.string :modeloventaq
      t.string :modelocontrolq
      t.string :modeloventap
      t.string :modelocontrolp
      t.string :modeloventat
      t.string :modelocontrolt
      t.string :modeloventasp
      t.string :modelocontrolsp

      t.timestamps
    end
  end
end
