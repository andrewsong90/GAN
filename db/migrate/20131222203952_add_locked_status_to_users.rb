class AddLockedStatusToUsers < ActiveRecord::Migration
  
  def self.up
  	add_column :users, :locked, :boolean

  	User.update_all(:locked => false)
  end

  def self.down
  	remove_column :users, :locked
  end
end
