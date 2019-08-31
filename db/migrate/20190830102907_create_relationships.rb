class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :guest_id
      t.integer :host_id

      t.timestamps
    end
    add_index :relationships, :guest_id
    add_index :relationships, :host_id
    add_index :relationships, [:guest_id, :host_id], unique: true
  end
end
