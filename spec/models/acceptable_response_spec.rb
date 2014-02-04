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
  pending "add some examples to (or delete) #{__FILE__}"
end
