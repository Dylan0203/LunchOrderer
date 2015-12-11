class AddRemarkPeople < ActiveRecord::Migration
  def change
    add_column :people, :remark, :text
  end
end
