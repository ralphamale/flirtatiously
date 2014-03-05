# == Schema Information
#
# Table name: message_headers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  other_id   :integer
#  message_id :integer
#  is_sent    :boolean
#  is_read    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe MessageHeader do
  it { should belong_to(:message) }
end
