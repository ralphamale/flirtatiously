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

require 'spec_helper'

describe Question do
  it { should validate_presence_of(:text) }
  it { should have_many(:answer_choices) }
  it { should have_many(:responses) }
  it { should have_many(:acceptable_responses) }


end
