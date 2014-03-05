# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  question_id :integer
#  text        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerChoice < ActiveRecord::Base
  attr_accessible :question_id, :text
  validates :text, presence: true
  validates :question, presence: true

  belongs_to :question,
  inverse_of: :answer_choices,
  foreign_key: :question_id

  has_many :acceptable_responses,
  dependent: :destroy,
  inverse_of: :answer_choice,
  class_name: "Response",
  foreign_key: :answer_choice_id

  has_many :personal_responses,
  dependent: :destroy,
  inverse_of: :answer_choice,
  class_name: "Response",
  foreign_key: :answer_choice_id

end
