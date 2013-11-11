class AddAttrToOpportunities < ActiveRecord::Migration
  def change
  	add_column :opportunities, :company, :string
  	add_column :opportunities, :time, :string
  	rename_column :opportunities, :content, :description
  end
end
