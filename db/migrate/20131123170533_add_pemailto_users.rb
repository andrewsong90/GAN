class AddPemailtoUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :parent_email, :string
  end

  def self.down
  	remove_column :users, :parent_email
  end
end
