class CreateMenuadmticketsganadoresxfechats < ActiveRecord::Migration[5.0]
  def change
    create_table :menuadmticketsganadoresxfechats do |t|
      t.string :sucursal
      t.date :desde
      t.date :hasta

      t.timestamps
    end
  end
end
