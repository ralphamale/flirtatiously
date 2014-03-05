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

  it { should validate_presence_of(:likes) }
  it { should validate_presence_of(:rater) }
  it { should validate_presence_of(:ratee) }

  pending { should ensure_inclusion_of(:likes).in_array([true,false]) }

  it { should belong_to(:rater) }
  it { should belong_to(:ratee) }

end
