# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  liker_id   :integer
#  likee_id   :integer
#  is_mutual  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Like do
  pending "add some examples to (or delete) #{__FILE__}"
end
