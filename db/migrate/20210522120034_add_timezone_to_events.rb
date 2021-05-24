class AddTimezoneToEvents < ActiveRecord::Migration[6.0]
  def change
        add_column :events, :time_zone, :string, :limit => 255, :default => "UTC"
  end
end
