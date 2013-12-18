class CreateUseruploads < ActiveRecord::Migration
  def change
    create_table :useruploads do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
