# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_id      :integer
#

class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :user_id, :question_id
  validates :question_id, uniqueness: {
    scope: :user_id,
    message: "Can only answer question once"
  }

  validates :question, presence: true
  validates :answer_choice, presence: true
  validates :user, presence: true

  belongs_to :question,
  inverse_of: :responses,
  foreign_key: :question_id

  belongs_to :answer_choice,
  inverse_of: :personal_responses,
  foreign_key: :answer_choice_id

  belongs_to :user,
  inverse_of: :responses,
  foreign_key: :user_id

end
