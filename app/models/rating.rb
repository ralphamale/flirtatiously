# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  rater_id   :integer
#  ratee_id   :integer
#  likes      :boolean
#  is_mutual  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :is_mutual, :likes, :ratee_id, :rater_id

  belongs_to :rater,
  class_name: "User",
  foreign_key: :rater_id

  belongs_to :ratee,
  class_name: "User",
  foreign_key: :ratee_id

  def self.status(current_user_id, other_id)
    rating = Rating.where(:rater_id => current_user_id).where(:ratee_id => other_id).first

    return nil if rating.nil?

    (rating.is_mutual)? true : false
  end
end
