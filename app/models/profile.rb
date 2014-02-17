# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  sex                :string(255)
#  sexual_orientation :string(255)
#  drugs              :string(255)
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Profile < ActiveRecord::Base
  attr_accessible :description, :drugs, :sex, :sexual_orientation, :user_id, :height, :body_type, :diet, :smokes, :drinks, :religion, :sign, :education, :job, :offspring, :pets, :likes

  belongs_to :user, inverse_of: :profile,
  foreign_key: :user_id


end
