class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.text :item
      t.integer :quantity
      t.integer :price

      t.timestamps null: false
    end
  end
end
