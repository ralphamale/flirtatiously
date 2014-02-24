# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  category   :string(255)
#  text       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  attr_accessible :category, :text
  validates :text, presence: true

  has_many :answer_choices, dependent: :destroy,
  foreign_key: :question_id

  has_many :responses, dependent: :destroy,
  foreign_key: :question_id

  has_many :acceptable_responses, dependent: :destroy,
  foreign_key: :question_id

  def self.get_responses(user_id)
    return Question.joins("INNER JOIN answer_choices ON questions.id = answer_choices.question_id INNER JOIN responses ON answer_choices.id = responses.answer_choice_id").select("questions.id AS question_id, questions.text AS question_text, answer_choices.id AS answer_id, answer_choices.text AS answer_text").where("responses.user_id = ?", user_id)
  end

  def self.get_acceptable_responses(user_id)
    return Question.joins("JOIN answer_choices ON questions.id = answer_choices.question_id INNER JOIN acceptable_responses ON acceptable_responses.answer_choice_id = answer_choices.id").select("questions.id AS question_id, acceptable_responses.answer_choice_id AS answer_id, acceptable_responses.importance AS importance").where("acceptable_responses.user_id = ?", user_id)

  end

  def self.get_random_unanswered(current_user)

    unanswered_questions = Question.pluck(:id) - current_user.answered_questions.pluck(:id)
    random_id = unanswered_questions.sample
    @random_question = (random_id.nil?) ? nil : Question.find(random_id)
    @random_question
  end
end

