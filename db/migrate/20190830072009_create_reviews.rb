class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
        t.integer :user_id, foreign_key: true
        t.integer :property_id, foreign_key: true
        t.integer :reservation_id, foreign_key: true
        t.integer :rating
        t.text    :comment
        
        t.timestamps
      end
      add_index :reviews, [:user_id, :created_at]
      add_index :reviews, [:property_id, :created_at]
      add_index :reviews, [:reservation_id, :created_at]
  end
end
