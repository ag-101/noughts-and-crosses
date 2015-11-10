# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  status     :string
#  player1_id :integer
#  player2_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  belongs_to :player1, class_name: 'User', foreign_key: 'player1_id'
  belongs_to :player2, class_name: 'User', foreign_key: 'player2_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'

  has_many :moves
  
  def players
    [self.player1, self.player2]
  end
  
  validates :player1_id, presence: true
  validates :player2_id, presence: true
  
  def next_player
    if self.moves.empty?
      return player1
    else
      return self.player2 if self.moves.last.player == self.player1
      return self.player1 if self.moves.last.player == self.player2      
    end
  end
  
  def check_for_winner
    return winner if self.winner
        
    winning_combinations = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [1, 4, 7], [2, 4, 6], [2, 5, 8], [3, 4, 5], [6, 7, 8]]
    
    check = {}
    
    self.players.each do |player|
      check[player.id] = [] unless check[player.id]
      self.moves.map{|move| check[player.id] << move.position if move.player == player }
      
      winning_combinations.each do |win|
        if check[player.id].is_a? Array and check[player.id].any? and (win - check[player.id]).empty?
          winner = player 
          self.status = 'Finished'
          self.winner_id = winner.id
          self.save
        end
      end      
    end
    
    return winner ? winner : false
  end  

end
