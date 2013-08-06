class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :user_id
      t.integer :brew_id
      t.string :title
      t.integer :days
      t.integer :order
      t.date :date
      t.boolean :completed, :default=>false
      t.boolean :update_inventory

      t.timestamps
    end
  end
end
