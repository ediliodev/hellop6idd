class AddUniqueIndexToSucursalt < ActiveRecord::Migration[5.0]
  
def change
   # add_index :sucursalts, [:consorciot_id, :sucursal], unique: true # creacion de primary Key compuesto. Ver link https://stackoverflow.com/questions/34424154/rails-validate-uniqueness-of-two-columns-together
  end

end
