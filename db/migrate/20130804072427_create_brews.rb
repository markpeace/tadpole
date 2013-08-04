class CreateBrews < ActiveRecord::Migration
  def change
    create_table :brews do |t|
      t.integer :user_id
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
