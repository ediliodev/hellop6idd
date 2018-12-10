class AddActivoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activo, :boolean
  end
end
