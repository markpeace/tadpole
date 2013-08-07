class ChangeOrderToSteporderInSteps < ActiveRecord::Migration
  def change
	rename_column :steps, :order, :steporder
  end
end
