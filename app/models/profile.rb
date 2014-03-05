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
  attr_accessible :description, :drugs, :sex, :sexual_orientation, :user_id, :smokes, :religion, :zip_code, :latitude, :longitude, :city, :birthday, :big_photo

  validates :birthday, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }

  geocoded_by :zip_code
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.zip_code = geo.postal_code
    end
  end

  after_validation :geocode, :reverse_geocode

  paginates_per 24

  belongs_to :user, inverse_of: :profile,
  foreign_key: :user_id

  has_many :photos

  def self.get_random_unrated(current_user)
    liking_current_users = User.joins("INNER JOIN ratings
      ON users.id = ratings.rater_id").where("ratings.is_mutual IS NULL
      AND ratings.ratee_id = ?", current_user.id)

    return liking_current_users.sample.profile unless liking_current_users.blank?

    @user_filter = current_user.user_filter
    current_user_pid = current_user.profile.id

    already_rated = current_user.sent_ratings.pluck(:ratee_id)
    @random_unmatched = Profile.where("profiles.user_id NOT IN (?)", [-1].concat(already_rated))
                                .apply_filters(@user_filter, current_user)
                                .sample

    @random_unmatched

  end

  def self.suggest_six(current_user)
    profiles = Profile.apply_filters(current_user.user_filter, current_user)

    profiles.sample(6)
  end

  def self.apply_filters(filter, current_user)
    return Profile.all if filter.nil?

    results = Profile.where("id != ?", current_user.profile.id)

    unless filter.sex.nil? || filter.sex == -1
      results = results.where(:sex => filter.sex)
    end

    unless filter.beg_age.nil? && filter.end_age.nil?
      start_date =
      ((filter.beg_age.nil?) ? 18 : filter.beg_age).years.ago

      end_date =
      ((filter.end_age.nil?) ? 99 : filter.end_age).years.ago

      results = results.where(:birthday => end_date..start_date)
    end

    unless filter.sexual_orientation.nil? || filter.sexual_orientation == -1
      results = results.where(:sexual_orientation => filter.sexual_orientation)
    end

    unless filter.distance.nil?
      results.reject! do |result|
        current_user.profile.distance_to(result) > filter.distance
      end
    end

    return results
  end
end