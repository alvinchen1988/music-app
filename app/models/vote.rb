class Vote < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validate :check_if_user_already_voted
  after_create :increment_track_and_user_vote

  def increment_track_and_user_vote
    if track && user
        track.num_votes += 1
        user.num_votes += 1
        track.save 
        user.save
    end
  end

  def check_if_user_already_voted
    if user && user.voted?(track) 
      errors.add(:duplicate, "the user already upvoted for this track")
    end
  end
end