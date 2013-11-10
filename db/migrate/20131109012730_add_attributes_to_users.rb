class AddAttributesToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :fname, :string
  	add_column :users, :lname, :string
  	add_column :users, :classyear, :integer
  end

  def self.down
  	remove_column :users, :fname
  	remove_column :users, :lname
  	remove_column :users, :classyear
  end
end
