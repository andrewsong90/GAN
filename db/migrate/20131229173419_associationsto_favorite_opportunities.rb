class AssociationstoFavoriteOpportunities < ActiveRecord::Migration
  def self.up
  	add_column :favorite_opportunities, :opportunity_id, :integer
  	add_column :favorite_opportunities, :user_id, :integer
  end

  def self.down
  	remove_column :favorite_opportunities, :opportunity_id
  	remove_column :favorite_opportunities, :user_id
  end
end
