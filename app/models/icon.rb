class Icon < ActiveRecord::Base
  has_many :blog_items, :dependent => :nullify
  
  has_attached_file :image, :styles => {:thumb => '100x100>'}
end
