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
