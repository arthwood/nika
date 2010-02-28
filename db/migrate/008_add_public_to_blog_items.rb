class AddPublicToBlogItems < ActiveRecord::Migration
  def self.up
    add_column :blog_items, :public, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :blog_items, :public
  end
end
