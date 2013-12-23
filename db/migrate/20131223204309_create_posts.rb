class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :admin
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
