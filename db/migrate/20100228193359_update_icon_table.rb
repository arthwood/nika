class UpdateIconTable < ActiveRecord::Migration
  def self.up
    remove_column :icons, :content_type
    remove_column :icons, :filename
    remove_column :icons, :size
    remove_column :icons, :parent_id
    remove_column :icons, :thumbnail
    remove_column :icons, :width
    remove_column :icons, :height
    
    add_column :icons, :image_file_name, :string, :null => false
    add_column :icons, :image_content_type, :string, :null => false
    add_column :icons, :image_file_size, :integer, :null => false
    add_column :icons, :image_updated_at, :datetime, :null => false
  end

  def self.down
    remove_column :icons, :image_file_name
    remove_column :icons, :image_content_type
    remove_column :icons, :image_file_size
    remove_column :icons, :image_updated_at
    
    add_column :icons, :content_type, :string
    add_column :icons, :filename, :string
    add_column :icons, :size, :integer
    add_column :icons, :parent_id, :integer
    add_column :icons, :thumbnail, :string
    add_column :icons, :width, :integer
    add_column :icons, :height, :integer
  end
end
