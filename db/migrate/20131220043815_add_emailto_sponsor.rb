class AddEmailtoSponsor < ActiveRecord::Migration
  def self.up
  	add_column :sponsors, :email, :string
  end

  def self.down
  	remove_column :sponsors, :email
  end
end
