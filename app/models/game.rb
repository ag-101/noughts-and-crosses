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

  has_many :moves
  
  validates :player1_id, presence: true
  validates :player2_id, presence: true

end
