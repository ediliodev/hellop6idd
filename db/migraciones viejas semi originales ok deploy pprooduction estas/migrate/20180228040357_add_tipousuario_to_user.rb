class AddTipousuarioToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tipo_usuario, :string
  end
end
