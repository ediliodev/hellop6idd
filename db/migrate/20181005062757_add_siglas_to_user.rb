class AddSiglasToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :siglas, :string
  end
end
