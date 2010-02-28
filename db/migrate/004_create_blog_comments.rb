class CreateBlogComments < ActiveRecord::Migration
  def self.up
    create_table :blog_comments do |t|
      t.column :blog_item_id,              :integer, :null => false
      t.column :user_id,                   :integer, :null => false
      t.column :body,                      :text, :null => false
      t.column :created_at,                :datetime, :null => false
      t.column :updated_at,                :datetime, :null => false
      t.column :active,                    :boolean, :null => false
    end
  end

  def self.down
    drop_table :blog_comments
  end
end
