class Contact < ActiveRecord::Migration
  def self.up
  	add_column :contacts, :title, :string
  	add_column :contacts, :from_email, :string
  	add_column :contacts, :content, :text
  end

  def self.down
  	remove_column :contacts, :title
  	remove_column :contacts, :from_email
  	remove_column :contacts, :content
  end
end
