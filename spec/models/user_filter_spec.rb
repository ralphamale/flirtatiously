# == Schema Information
#
# Table name: user_filters
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  beg_age            :integer
#  end_age            :integer
#  sex                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  distance           :integer
#  sexual_orientation :integer
#

require 'spec_helper'

describe UserFilter do
  it { should validate_presence_of(:user) }

  pending "Beg age should be 0 < x < 100 and < end_age"
  pending "End age should be 0 < x < 100 and < end_age"
  pending "Distance should be greater than 0 and be able to be nil"
  pending "Sex is 'M' or 'F' with allow nil"
  pending "Sexual Orientation should be 0..2 with nil okay"

  it { should belong_to(:user) }

  it "should convert blank attributes to blank"

end
