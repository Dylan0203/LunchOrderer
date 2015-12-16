class AddDateAndDaytimeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :date, :date
    add_column :people, :datetime, :datetime
  end
end
