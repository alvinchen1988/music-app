class AddNumVotesAndUserIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :num_votes, :integer
    add_reference :tracks, :user, index: true, foreign_key: true
  end
end
