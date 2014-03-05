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

require 'spec_helper'

describe AcceptableResponse do
  it { should belong_to(:user) }
  it { should belong_to(:answer_choice) }
  it { should belong_to(:question) }

  it { should validate_uniqueness_of(:answer_choice_id).scoped_to(:user_id).with_message('Cannot submit answer choice twice') }
  it { should validate_presence_of(:importance) }


  it "should have importance"

  it "should not allow you to submit the same answer choice twice."


end
