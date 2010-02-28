class Structure < ActiveRecord::Migration
  def self.up
    create_table :roles, :force => true do |t|
      t.column :name, :string, :null => false
    end
    
    create_table :users, :force => true do |t|
      t.column :login,                     :string, :null => false
      t.column :role_id,                   :integer, :null => false
      t.column :email,                     :string, :null => false
      t.column :crypted_password,          :string, :limit => 40, :null => false
      t.column :salt,                      :string, :limit => 40, :null => false
      t.column :created_at,                :datetime, :null => false
      t.column :updated_at,                :datetime, :null => false
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :firstname,                 :string, :null => false
      t.column :lastname,                  :string, :null => false
      t.column :active,                    :boolean, :null => false
    end
  end

  def self.down
    drop_table :users
    drop_table :roles
  end
end
