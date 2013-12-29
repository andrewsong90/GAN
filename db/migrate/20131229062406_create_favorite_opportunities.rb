class CreateFavoriteOpportunities < ActiveRecord::Migration
  def change
    create_table :favorite_opportunities do |t|

      t.timestamps
    end
  end
end
