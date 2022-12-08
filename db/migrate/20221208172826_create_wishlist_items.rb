class CreateWishlistItems < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlist_items do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :wishlist_id, null: false, foreign_key: true
      t.boolean :actual, default: false
      t.timestamps
    end
  end
end
