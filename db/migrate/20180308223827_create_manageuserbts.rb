class CreateManageuserbts < ActiveRecord::Migration[5.0]
  def change
    create_table :manageuserbts do |t|
      t.string :email
      t.string :password
      t.boolean :activo?

      t.timestamps
    end
  end
end
