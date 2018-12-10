class CreateConsorciots < ActiveRecord::Migration[5.0]
  def change
    create_table :consorciots do |t|
      t.string :nombre
      t.string :abreviatura
      t.string :telefono

      t.timestamps
    end
  end
end


#20171124004026
#20181005050925_create_consorciots.rb