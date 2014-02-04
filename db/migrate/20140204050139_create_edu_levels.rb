class CreateEduLevels < ActiveRecord::Migration
  def change
    create_table :edu_levels do |t|

      t.timestamps
    end
  end
end
