class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.belongs_to :user	
      t.timestamps
    end
  end
end
