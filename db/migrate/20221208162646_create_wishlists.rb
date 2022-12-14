class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.string :name
      t.text :description
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
