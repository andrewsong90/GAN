class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|

      t.timestamps
      t.belongs_to :user
    end
  end
end
