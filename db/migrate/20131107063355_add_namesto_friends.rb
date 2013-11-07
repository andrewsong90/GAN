class AddNamestoFriends < ActiveRecord::Migration
  def self.up
  	add_column :friends, :fname, :string
  	add_column :friends, :lname, :string
  end

  def self.down
  	remove_column :friends, :fname
  	remove_column :friends, :lname
  end
end
