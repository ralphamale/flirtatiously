# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  category   :string(255)
#  text       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Question do
  pending "add some examples to (or delete) #{__FILE__}"
end
