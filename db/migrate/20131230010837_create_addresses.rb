class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.belongs_to :user
      t.timestamps
    end
  end
end
