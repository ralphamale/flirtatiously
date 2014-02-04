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
#

require 'spec_helper'

describe Profile do
  pending "add some examples to (or delete) #{__FILE__}"
end
