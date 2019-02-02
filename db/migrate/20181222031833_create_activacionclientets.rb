class CreateActivacionclientets < ActiveRecord::Migration[5.0]
  def change
    create_table :activacionclientets do |t|
      t.string :email
      t.string :clienteid
      t.string :tipocliente

      t.timestamps
    end
  end
end
