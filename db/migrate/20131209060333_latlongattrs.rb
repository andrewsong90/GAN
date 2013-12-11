class Latlongattrs < ActiveRecord::Migration
  def self.up
  	add_column :opportunities, :latitude, :float
  	add_column :opportunities, :longitude, :float
  end

  def self.down
  	remove_column :opportunities, :latitude
  	remove_column :opportunities, :longitude
  end
end
