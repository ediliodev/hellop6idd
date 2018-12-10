class AddSucursalbtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sucursalbt, :string
  end
end
