class CreateImpresionts < ActiveRecord::Migration[5.0]
  def change
    create_table :impresionts do |t|
      t.references :ticket, foreign_key: true
      t.text :jugadas

      t.timestamps
    end
  end
end
