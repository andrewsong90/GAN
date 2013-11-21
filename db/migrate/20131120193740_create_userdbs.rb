class CreateUserdbs < ActiveRecord::Migration
  def change
    create_table :userdbs do |t|

      t.timestamps
    end
  end
end
