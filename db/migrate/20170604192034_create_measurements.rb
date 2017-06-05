class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.float :temperature
      t.float :humidity
      t.integer :lightLevel
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
