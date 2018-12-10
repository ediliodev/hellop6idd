class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :serial
      t.references :user, foreign_key: true
      t.datetime :fechaimpresion
      t.string :activo
      t.string :ganador
      t.string :pago

      t.timestamps
    end
  end
end
