class Photo < ActiveRecord::Base

  attr_accessible :file, :profile_id

  has_attached_file :file, :styles => {:featured => "840x>", :browse => "460x460#", :avatar => "200x200#", :thumb => "60x60#"}
  #doubled for retina display.
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/




end
