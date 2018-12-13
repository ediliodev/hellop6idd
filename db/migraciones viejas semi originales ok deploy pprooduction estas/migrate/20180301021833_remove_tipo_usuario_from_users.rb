class RemoveTipoUsuarioFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :tipo_usuario, :string
  end
end
