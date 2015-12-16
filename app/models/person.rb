class Person < ActiveRecord::Base
  validates_presence_of :name, :item, :quantity, :price

  def last_page
    num_pages 
  end
end
