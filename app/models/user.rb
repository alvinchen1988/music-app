class User < ActiveRecord::Base
  has_many :tracks
  has_many :votes

  before_save {email.downcase!}
  before_create do 
    self.num_votes = 0
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false})
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password

  def voted?(track)
    rows = Vote.where(user_id: id)
    rows.each do |row|
      return true if row.track_id == track.id
    end
    false
  end

end