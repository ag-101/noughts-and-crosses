# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :player1_games, class_name: 'Game', foreign_key: 'player1_id'
  has_many :player2_games, class_name: 'Game', foreign_key: 'player2_id'
  has_many :winners, class_name: 'Game', foreign_key: 'winner_id'
  
  validates :username, uniqueness: true
    
  def games
    # Player 1 initiates games, so worth keeping that information separate through the associations above
    games = self.player1_games + self.player2_games
    games.sort.reverse
  end
  
end
