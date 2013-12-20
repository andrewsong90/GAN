class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.belongs_to :opportunity	
      t.string :name
      t.string :position
      t.string :company
      t.timestamps
    end
  end
end
