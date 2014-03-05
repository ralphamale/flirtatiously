# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  rater_id   :integer
#  ratee_id   :integer
#  likes      :boolean
#  is_mutual  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Rating do
  it { should belong_to(:rater) }
  it { should belong_to(:ratee) }

end
