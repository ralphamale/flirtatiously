# == Schema Information
#
# Table name: profile_views
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  viewee_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProfileView < ActiveRecord::Base
  #display last online date. from updated_at

  attr_accessible :viewee_id, :viewer_id



end
