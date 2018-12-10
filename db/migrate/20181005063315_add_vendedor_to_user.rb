class AddVendedorToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vendedor, :string
  end
end
