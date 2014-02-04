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

class StatusMessage < ActiveRecord::Base
  attr_accessible :body, :category, :user_id
end
