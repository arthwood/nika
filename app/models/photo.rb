class Photo < ActiveRecord::Base
  belongs_to :photo_set
  
  has_attached_file :image, :styles => {:medium => '200x200>', :thumb => '100x100>'}
end
