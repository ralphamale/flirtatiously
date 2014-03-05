# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  receiver_id :integer
#  trigger_id  :integer
#  status_type :integer
#  is_read     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Notification do
  it { should belong_to(:receiver) }
  it { should belong_to(:triggering_user) }
end
