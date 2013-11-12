class AddMessagesToApplications < ActiveRecord::Migration
  def self.up
  	add_column :applications, :message, :text
  end

  def self.down
  	remove_column :applications, :message
  end
end
