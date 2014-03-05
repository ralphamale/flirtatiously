# == Schema Information
#
# Table name: user_filters
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  beg_age            :integer
#  end_age            :integer
#  sex                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  distance           :integer
#  sexual_orientation :integer
#

class UserFilter < ActiveRecord::Base
  attr_accessible :beg_age, :end_age, :sex, :sexual_orientation, :user_id, :distance

  validates :distance, numericality: {greater_than: 0}, allow_nil: true

  validates :beg_age,
    numericality: {greater_than: 0, less_than_or_equal_to: :end_age}, allow_nil: true

  validates :end_age, numericality: {less_than_or_equal_to: 100}, allow_nil: true



  validates :sexual_orientation, :inclusion => 0..2, allow_nil: true
  validates :sex, :inclusion => ["M", "F"], allow_nil: true
  validates :user, presence: true

  NULL_ATTRS = %w( beg_age end_age sex sexual_orientation distance )

  before_save :nil_if_blank


  belongs_to :user,
  inverse_of: :user_filter,
  foreign_key: :user_id

  protected

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
