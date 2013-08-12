class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :user_id
      t.text :label
      t.integer :grams

      t.timestamps
    end
  end
end
