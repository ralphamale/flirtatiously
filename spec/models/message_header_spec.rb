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
  describe "Validations" do
    it { should validate_presence_of(:is_sent) }
    it { should validate_presence_of(:is_read) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:message) }
    it "should only allow is_sent and is_read to be true and false"
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:other_user) }
    it { should belong_to(:message) }
  end
end
