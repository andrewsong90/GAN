class CreateOpportunityTimes < ActiveRecord::Migration
  def change
    create_table :opportunity_times do |t|
      t.string :types
      t.string :date
      t.belongs_to :opportunity

      t.timestamps
    end
  end
end
