class AddNombreToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nombre, :string
  end
end
