# == Schema Information
#
# Table name: acceptable_responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  importance       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_id      :integer
#

class AcceptableResponse < ActiveRecord::Base
  attr_accessible :answer_choice_id, :importance, :user_id, :question_id, :answer_choice_ids
  validates :importance, presence: true
  validates :answer_choice_id, uniqueness: { scope: :user_id,
    message: "should not let you register answer choice id twice" }

  belongs_to :answer_choice,
  foreign_key: :answer_choice_id

  belongs_to :user, inverse_of: :acceptable_responses,
  foreign_key: :user_id

  belongs_to :question,
  foreign_key: :question_id

end
