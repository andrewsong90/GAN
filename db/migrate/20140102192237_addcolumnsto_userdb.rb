class AddcolumnstoUserdb < ActiveRecord::Migration
  def self.up
  	add_column :userdbs, :parent_email_2, :string
  	rename_column :userdbs, :parent_email, :parent_email_1
  end

  def self.down
  	remove_column :userdbs, :parent_email_2
  	rename_column :userdbs, :parent_email_1, :parent_email
  end
end
