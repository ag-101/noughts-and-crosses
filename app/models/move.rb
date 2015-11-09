# == Schema Information
#
# Table name: moves
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  game_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Move < ActiveRecord::Base
  belongs_to :player, class_name: 'User', foreign_key: 'player_id'
  belongs_to :game
  
  validates :player_id, presence: true
  validates :game_id, presence: true
  validates :position, presence: true
  
  before_save :before_save
  def before_save
    # FINISH THIS - should it be here or in Game?  Probably here.
    errors.add(:game, "It's not your turn")
    errors.add(:game, "Invalid move")
    errors.add(:game, "The game has finished")

  end
end
