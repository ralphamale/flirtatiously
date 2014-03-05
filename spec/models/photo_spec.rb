# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  profile_id        :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

require 'spec_helper'

describe Photo do
  it { should belong_to(:profile) }

end
