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

  before {
    user = FactoryGirl.create(:user)
    UserFilter.create!({user_id: user.id,
      beg_age: 20,
      end_age: 50,
      sex: "M",
      distance: 500,
      sexual_orientation: 0})
  }

  subject(:user_filter) { UserFilter.last }

  it "should be valid if all attributes are valid" do
    expect(user_filter).to be_valid
  end

  it { should validate_presence_of(:user) }

  it "should only allow beg_age and end_age to be 0 < x < 100" do
    user_filter.beg_age = -1
    expect(user_filter).to_not be_valid

    user_filter.beg_age = 101
    expect(user_filter).to_not be_valid

    user_filter.beg_age = 40
    expect(user_filter).to be_valid

    user_filter.end_age = 101
    expect(user_filter).to_not be_valid
    user_filter.end_age = 60
    expect(user_filter).to be_valid
  end

  it "should not let beg_age be higher than end_age" do
    user_filter.beg_age = 60
    expect(user_filter).to_not be_valid
  end

  it "should only allow distance greater than 0 or nil" do
    user_filter.distance = 0
    expect(user_filter).to_not be_valid

    user_filter.distance = nil
    expect(user_filter).to be_valid
  end

  it "should only allow sex to be 'M' or 'F' or nil" do
    user_filter.sex = "F"
    expect(user_filter).to be_valid

    user_filter.sex = nil
    expect(user_filter).to be_valid

    user_filter.sex = "Meow"
    expect(user_filter).to_not be_valid
  end

  it "should only allow sexual orientation to be 0..2 with nil okay" do
    user_filter.sexual_orientation = 2
    expect(user_filter).to be_valid

    user_filter.sexual_orientation = nil
    expect(user_filter).to be_valid

    user_filter.sexual_orientation = 500
    expect(user_filter).to_not be_valid
  end

  it { should belong_to(:user) }

end
