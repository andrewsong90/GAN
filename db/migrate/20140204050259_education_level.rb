class EducationLevel < ActiveRecord::Migration
  def self.up
  	add_column :edu_levels, :education, :string
  end

  def self.down
  	remove_column :edu_levels, :education
  end
end
