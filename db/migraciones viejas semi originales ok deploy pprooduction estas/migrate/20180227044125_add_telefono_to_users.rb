class AddTelefonoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :telefono, :string
  end
end
