class AddAttachmentUploadToOpportunities < ActiveRecord::Migration
  def self.up
    change_table :opportunities do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :opportunities, :upload
  end
end
