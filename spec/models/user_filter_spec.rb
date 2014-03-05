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
  it { should belong_to(:user) }



end
