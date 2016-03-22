class Track < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true

  before_create do 
    self.num_votes = 0
  end

end