class CreateHorariosorteots < ActiveRecord::Migration[5.0]
  def change
    create_table :horariosorteots do |t|
      t.string :nombre
      t.datetime :lunes
      t.datetime :martes
      t.datetime :miercoles
      t.datetime :jueves
      t.datetime :viernes
      t.datetime :sabado
      t.datetime :domingo

      t.timestamps
    end
  end
end
