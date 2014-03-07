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

  describe "Validations" do
    it { should validate_presence_of(:importance) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer_choice) }
    it "should only allow one answer choice ID per user"
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:answer_choice) }
    it { should belong_to(:question) }
  end

  pending "should not allow you to submit the same answer choice twice."


end
