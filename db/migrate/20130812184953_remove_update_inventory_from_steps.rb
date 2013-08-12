class RemoveUpdateInventoryFromSteps < ActiveRecord::Migration
  def up
    remove_column :steps, :update_inventory
  end

  def down
    add_column :steps, :update_inventory, :boolean
  end

end
