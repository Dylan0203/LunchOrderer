class Person < ActiveRecord::Base
  validates_presence_of :name, :item, :quantity, :price
end
