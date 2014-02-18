# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  liker_id   :integer
#  likee_id   :integer
#  is_mutual  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base
  attr_accessible :is_mutual, :likee_id, :liker_id



  belongs_to :liker,
  class_name: "User",
  foreign_key: :liker_id

  belongs_to :likee,
  class_name: "User",
  foreign_key: :likee_id

end
