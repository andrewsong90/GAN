class AddRegisteredToUsers < ActiveRecord::Migration
  def self.up
  	add_column :userdbs, :registered, :boolean
  end

  def self.down
  	remove_column :userdbs, :registered
  end
end
