class AddAttachmentUploadToApplications < ActiveRecord::Migration
  def self.up
    change_table :applications do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :applications, :upload
  end
end
