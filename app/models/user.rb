# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  password_digest :string(255)
#  session_token   :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :password_digest, :session_token, :username, :password, :answer_choice_ids

  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password cannot be blank." }
  #ensure token
  #validates :age, inclusion: 
  #validates :gender, inclusion: { in: ["M", "F"] }
  #validates :orientation, inclusion: { in: ["Straight", "Gay", "Bisexual"] }
  validates :username, uniqueness: true

  has_one :profile, inverse_of: :user,
  foreign_key: :user_id

  has_many :message_headers,
  foreign_key: :user_id

  has_many :other_message_headers,
  class_name: "User",
  foreign_key: :other_id

  has_many :messages, through: :message_headers, source: :message

  has_many :sent_likes,
  class_name: "Like",
  foreign_key: :liker_id

  has_many :liked_users,
  through: :sent_likes,
  source: :likee

  has_many :received_likes,
  class_name: "Like",
  foreign_key: :likee_id

  has_many :likers,
  through: :received_likes,
  source: :received_likes

  belongs_to :liker,
   class_name: "User",
   foreign_key: :liker_id
   
   belongs_to :likee,
   class_name: "User",
   foreign_key: :likee_id
   
   has_many :responses, inverse_of: :user, dependent: :destroy,
   foreign_key: :user_id

   has_many :acceptable_responses, inverse_of: :user, dependent: :destroy,
   foreign_key: :user_id
   
   def is_liked_by?(user)
     self.likers.include?(user)
   end
   
   def likes?(user)
     self.liked_users.include?(user)
   end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.try(:is_password?, password) ? user : nil

  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end


end
