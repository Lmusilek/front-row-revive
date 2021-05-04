class AddLiveEventToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :online, :boolean
  end
end
