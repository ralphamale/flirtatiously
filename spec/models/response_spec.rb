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
  it { should belong_to(:user) }
  it { should belong_to(:answer_choice) }


end
