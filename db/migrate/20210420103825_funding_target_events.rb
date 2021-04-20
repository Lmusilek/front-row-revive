class FundingTargetEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :funding, :integer
  end
end
