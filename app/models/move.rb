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
  
  attr_accessor :current_user
  
  validates :player_id, presence: true
  validates :game_id, presence: true
  validates :position, presence: true, uniqueness: {scope: :game_id}
    
  before_validation :allowed_to_move
  def allowed_to_move
    return errors.add(:game_has_finished, " - #{self.game.check_for_winner.username} has won") if self.game.check_for_winner
    errors.add(:illegal_move, " - it's not your turn") if self.game.moves.any? and self.game.moves.last.player == self.current_user
    errors.add(:illegal_move, " - #{self.game.player1.username} to start") if !self.game.moves.any? and self.current_user != self.game.player1
    errors.add(:game_has_finished, " - draw") if self.game.moves.count >= 9
  end
  
  after_save :after_save
  def after_save    
    if self.game.moves.count >= 9
      self.game.status = 'Draw'
    end    
    self.game.save  
  end

end
