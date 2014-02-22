class Rating < ActiveRecord::Base
  attr_accessible :is_mutual, :likes, :ratee_id, :rater_id

  belongs_to :rater,
  class_name: "User",
  foreign_key: :rater_id

  belongs_to :ratee,
  class_name: "User",
  foreign_key: :ratee_id

end
