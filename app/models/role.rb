class Role < ActiveRecord::Base
  ADMIN = {:id => 1, :name => 'admin'}
  FRIEND = {:id => 2, :name => 'friend'}
  USER = {:id => 3, :name => 'user'}
  
  ROLES = [ADMIN, FRIEND, USER]
  
  def self.options
    find(:all).map {|i|
      [i.name, i.id]
    }
  end
end
