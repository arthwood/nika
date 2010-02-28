class PhotoSet < ActiveRecord::Base
  has_many :photos
  
  def self.options
    find(:all).map {|i|
      [i.name, i.id]
    }
  end
end