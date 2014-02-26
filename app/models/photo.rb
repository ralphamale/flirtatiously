class Photo < ActiveRecord::Base

  attr_accessible :file, :profile_id
  # default_url: ActionController::Base.helpers.asset_path('blank_person_:style.png'),
  has_attached_file :file, default_url: ActionController::Base.helpers.asset_path("img_placeholder.png"), :styles => {:featured => "840x>", :browse => "460x460#", :avatar => "200x200#", :thumb => "60x60#"}
  #doubled for retina display.
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  belongs_to :profile





end
