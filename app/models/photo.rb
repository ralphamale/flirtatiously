# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  profile_id        :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  attr_accessible :file, :profile_id

  has_attached_file :file, default_url: ActionController::Base.helpers.asset_path("img_placeholder.png"), :styles => {:featured => "840x>", :browse => "460x460#", :avatar => "200x200#", :thumb => "60x60#"}

  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  belongs_to :profile

end
