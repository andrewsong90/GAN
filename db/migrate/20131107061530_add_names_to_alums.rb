class AddNamesToAlums < ActiveRecord::Migration
  def self.up
  	add_column :alums, :fname, :string
  	add_column :alums, :lname, :string
  end

  def self.down
  	remove_column :alums, :fname
  	remove_column :alums, :lname
  end
end
