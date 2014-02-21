class AddSponsortstoUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :sponsor_fname, :string
  	add_column :users, :sponsor_lname, :string
  	add_column :users, :sponsor_email, :string
  end

  def self.down
  	remove_column :users, :sponsor_email
  	remove_column :users, :sponsor_fname
  	remove_column :users, :sponsor_lname
  end
end
