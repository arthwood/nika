class InitialData < ActiveRecord::Migration
  def self.up
    Role.create(Role::ROLES)
    User.create(ADMIN)
  end

  def self.down
    User.destroy_all
    Role.destroy_all
  end
end
