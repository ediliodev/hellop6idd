class AddNombreToAliasmodelosiglasorteot < ActiveRecord::Migration[5.0]
  def change
    add_column :aliasmodelosiglasorteots, :nombre, :string
  end
end
