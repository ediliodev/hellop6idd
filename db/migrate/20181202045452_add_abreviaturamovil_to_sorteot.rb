class AddAbreviaturamovilToSorteot < ActiveRecord::Migration[5.0]
  def change
    add_column :sorteots, :abreviaturamovil, :string
  end
end
