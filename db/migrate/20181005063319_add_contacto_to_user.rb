class AddContactoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contacto, :string
  end
end
