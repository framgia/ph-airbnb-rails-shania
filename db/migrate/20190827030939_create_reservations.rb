class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id, foreign_key: true
      t.integer :property_id, foreign_key: true
      t.date    :start_date
      t.date    :end_date
      t.boolean :reserved, default: false

      t.timestamps
    end
    add_index :reservations, [:user_id, :created_at]
    add_index :reservations, [:property_id, :created_at]
  end
end
