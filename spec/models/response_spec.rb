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

require 'spec_helper'

describe Response do
  describe "Validations" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer_choice) }
    it { should validate_presence_of(:user) }
  end

  describe "Associations" do
    it { should belong_to(:question) }
    it { should belong_to(:user) }
    it { should belong_to(:answer_choice) }
  end

end
