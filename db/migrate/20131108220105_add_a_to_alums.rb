class AddAToAlums < ActiveRecord::Migration
  def self.up
  	add_column :alums, :a, :string
  end

  def self.down
  	remove_column :alums, :a
  end
end
