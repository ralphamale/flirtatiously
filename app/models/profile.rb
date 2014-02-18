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
#  height             :string(255)
#  body_type          :string(255)
#  diet               :string(255)
#  smokes             :string(255)
#  drinks             :string(255)
#  religion           :string(255)
#  sign               :string(255)
#  education          :string(255)
#  job                :string(255)
#  offspring          :string(255)
#  pets               :string(255)
#  likes              :text
#  latitude           :float
#  longitude          :float
#  zip_code           :integer
#  city               :string(255)
#

class Profile < ActiveRecord::Base
  attr_accessible :description, :drugs, :sex, :sexual_orientation, :user_id, :height, :body_type, :diet, :smokes, :drinks, :religion, :sign, :education, :job, :offspring, :pets, :likes, :zip_code, :latitude, :longitude, :city

  validates :zip_code, presence: true

  belongs_to :user, inverse_of: :profile,
  foreign_key: :user_id

  geocoded_by :zip_code
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.zip_code = geo.postal_code
    end
  end
  after_validation :geocode, :reverse_geocode

  # Custom Handling of Detailed Reverse Geocoding Results
  #
  # Given a Place model with known latitude/longitude coordinates, automatically fetch address components and store in separate attributes:

  # # app/models/place.rb
  # reverse_geocoded_by :lat, :lon do |obj,results|
  #   if geo = results.first
  #     obj.city    = geo.city
  #     obj.zipcode = geo.postal_code
  #     obj.country = geo.country_code
  #   end
  # end
  # after_validation :reverse_geocode
  # Forward and Reverse Geocoding on Same Model
  #
  # Given a Place model, objects of which sometimes have a street address and sometimes have coordinates, automatically fetch and fill in whatever's missing, based on what's provided:
  #
  # # app/models/place.rb
  # geocoded_by :address
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :geocode, :reverse_geocode



end
