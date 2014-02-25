class Photo < ActiveRecord::Base

  attr_accessible :file, :profile_id

  has_attached_file :file, :styles => {:featured => "420", :browse => "230x230#", :avatar => "100x100#", :thumb => "30x30#"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/




end
