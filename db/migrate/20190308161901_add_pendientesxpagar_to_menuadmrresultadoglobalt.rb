class AddPendientesxpagarToMenuadmrresultadoglobalt < ActiveRecord::Migration[5.0]
  def change
    add_column :menuadmrresultadoglobalts, :pendientexpagar, :integer
  end
end
