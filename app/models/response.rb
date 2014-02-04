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
  
  belongs_to :question,
  foreign_key: :question_id
  
  belongs_to :answer_choice,
  foreign_key: :answer_choice_id
  
  belongs_to :user,
  foreign_key: :user_id
  
  
  
end
