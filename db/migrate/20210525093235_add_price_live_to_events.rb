class AddPriceLiveToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :price_live, :integer
    add_column :events, :quantity_live, :integer
    add_column :events, :quantity_online, :integer
  end
end
