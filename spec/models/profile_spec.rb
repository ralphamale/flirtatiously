# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  sex                :string(255)
#  sexual_orientation :string(255)
#  drugs              :string(255)
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  height             :string(255)
#  body_type          :string(255)
#  diet               :string(255)
#  smokes             :string(255)
#  drinks             :string(255)
#  religion           :string(255)
#  sign               :string(255)
#  education          :string(255)
#  job                :string(255)
#  offspring          :string(255)
#  pets               :string(255)
#  likes              :text
#  latitude           :float
#  longitude          :float
#  zip_code           :integer
#  city               :string(255)
#

require 'spec_helper'

describe Profile do
  pending "add some examples to (or delete) #{__FILE__}"
end
