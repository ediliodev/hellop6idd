class AddSupervisortToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :supervisort, foreign_key: true
  end
end
