class AddBrewedToBrews < ActiveRecord::Migration
  def change
    add_column :brews, :brewed, :boolean, :default=>false
  end
end
