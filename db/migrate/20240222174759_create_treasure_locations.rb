class CreateTreasureLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :treasure_locations do |t|
      t.string :name
      t.decimal :latitude, precision: 15, scale: 10
      t.decimal :longitude, precision: 15, scale: 10
      t.boolean :active

      t.timestamps
    end
  end
end
