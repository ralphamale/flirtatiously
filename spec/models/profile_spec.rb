# == Schema Information
#
# Table name: profiles
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  sex                    :string(255)
#  sexual_orientation     :integer
#  drugs                  :integer
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  height                 :string(255)
#  body_type              :integer
#  diet                   :string(255)
#  smokes                 :integer
#  drinks                 :string(255)
#  religion               :integer
#  sign                   :string(255)
#  education              :string(255)
#  job                    :string(255)
#  offspring              :string(255)
#  pets                   :string(255)
#  likes                  :text
#  latitude               :float
#  longitude              :float
#  zip_code               :integer
#  city                   :string(255)
#  birthday               :date             not null
#  big_photo_file_name    :string(255)
#  big_photo_content_type :string(255)
#  big_photo_file_size    :integer
#  big_photo_updated_at   :datetime
#

require 'spec_helper'

describe Profile do
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:user) }

  it { should belong_to(:user) }
  it { should have_many(:photos) }

end
