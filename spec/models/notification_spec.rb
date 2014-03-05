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
  it { should validate_presence_of(:is_read) }
  it { should validate_presence_of(:status_type) }

  pending { should ensure_inclusion_of(:is_read).in_array([true,false]) }
  it { should ensure_inclusion_of(:status_type).in_array([0,1]) }

  it { should belong_to(:receiver) }
  it { should belong_to(:triggering_user) }

  it { should have_many (:triggerer_photos) }
  it { should have_one (:triggering_profile) }


end
