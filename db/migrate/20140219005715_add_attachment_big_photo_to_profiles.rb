class AddAttachmentBigPhotoToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :big_photo
    end
  end

  def self.down
    drop_attached_file :profiles, :big_photo
  end
end
