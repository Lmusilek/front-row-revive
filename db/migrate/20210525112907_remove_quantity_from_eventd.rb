class RemoveQuantityFromEventd < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :quantity_online
    remove_column :events, :quantity_live

  end
end
