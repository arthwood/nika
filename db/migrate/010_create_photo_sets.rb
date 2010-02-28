class CreatePhotoSets < ActiveRecord::Migration
  def self.up
    create_table :photo_sets do |t|
      t.column :name, :string
      t.column :description, :text
    end
    
    add_index :photo_sets, :name, :name => 'unique_name', :unique => true
  end

  def self.down
    drop_table :photo_sets
  end
end
