class AddBooleansToEvents < ActiveRecord::Migration[6.0]
  def change
     add_column :events, :in_person, :boolean
  end
end
