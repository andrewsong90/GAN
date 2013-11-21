class AddAttributestouserdb < ActiveRecord::Migration
  def self.up
  	add_column :userdbs, :fname, :string
  	add_column :userdbs, :lname, :string
  	add_column :userdbs, :parent_email, :string
  	add_column :userdbs, :classyear, :integer
  end

  def self.down
  	remove_column :userdbs, :fname
  	remove_column :userdbs, :lname
  	remove_column :userdbs, :parent_email
  	remove_column :userdbs, :classyear
  end
end
