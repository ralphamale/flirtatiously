# == Schema Information
#
# Table name: user_filters
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  beg_age            :integer
#  end_age            :integer
#  sex                :string(255)
#  sexual_orientation :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class UserFilter < ActiveRecord::Base
  attr_accessible :beg_age, :end_age, :sex, :sexual_orientation, :user_id

  belongs_to :user, inverse_of: :user_filter,
  foreign_key: :user_id
end
