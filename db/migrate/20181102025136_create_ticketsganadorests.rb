class CreateTicketsganadorests < ActiveRecord::Migration[5.0]
  def change
    create_table :ticketsganadorests do |t|
      t.references :ticket, foreign_key: true
      t.string :jugada
      t.integer :montoapostado
      t.integer :montoacobrar

      t.timestamps
    end
  end
end
