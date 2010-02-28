class AddIconIdToBlogItems < ActiveRecord::Migration
  def self.up
    add_column :blog_items, :icon_id, :integer
  end

  def self.down
    remove_column :blog_items, :icon_id
  end
end
