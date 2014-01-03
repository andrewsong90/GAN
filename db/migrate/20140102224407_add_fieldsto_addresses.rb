class AddFieldstoAddresses < ActiveRecord::Migration
  def self.up
  	add_column :addresses, :address_1, :string
  	add_column :addresses, :address_2, :string
  	add_column :addresses, :city, :string
  	add_column :addresses, :state, :string
  	add_column :addresses, :country, :string
  end

  def self.down
  	remove_column :addresses, :address_1
  	remove_column :addresses, :address_2
  	remove_column :addresses, :city
  	remove_column :addresses, :state
  	remove_column :addresses, :country
  end
end
