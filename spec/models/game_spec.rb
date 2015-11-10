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

require "rails_helper"

RSpec.describe Game, type: :model do
  it "saves a valid game" do
    
    player1 = FactoryGirl.build(:player1)
    player2 = FactoryGirl.build(:player2)
    
    game = Game.create!(player1_id: player1.id, player2_id: player2.id, status: 'new')
    
    expect(game.status).to eq('new')
  end
  
  it "won't save a valid game" do
    game = Game.new()
    game.save
    expect(game.errors.size).to be >= 1
  end
end
