class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.references :user, foreign_key: true
      t.string :home_type
      t.string :guest_count
      t.string :bedroom_count
      t.string :bathroom_count
      t.string :room_type
      t.string :title
      t.string :description
      t.string :location
      t.float :price
      t.boolean :has_tv, default: false
      t.boolean :has_heater, default: false
      t.boolean :has_aircon, default: false
      t.boolean :has_kitchen, default: false
      t.boolean :has_wifi, default: false
      t.boolean :complete, default: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
