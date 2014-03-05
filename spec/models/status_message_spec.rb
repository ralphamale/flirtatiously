# == Schema Information
#
# Table name: status_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  category   :string(255)
#  body       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe StatusMessage do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }

  it { should belong_to(:user) }

end
