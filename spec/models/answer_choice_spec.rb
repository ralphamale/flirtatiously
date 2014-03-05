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

require 'spec_helper'

describe AnswerChoice do
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:question) }

  it { should belong_to(:question) }
  it { should have_many(:acceptable_responses) }
  it { should have_many(:personal_responses) }

end
