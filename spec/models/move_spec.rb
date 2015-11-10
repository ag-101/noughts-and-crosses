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

require "rails_helper"

RSpec.describe Move, type: :model do
  before(:each) do
    @game = FactoryGirl.build(:game)
    
  end
  
  it "won't save a move if it's not your turn" do
    move = Move.new
    move.player = FactoryGirl.build(:player1)
    move.game = @game
    move.position = 0
    move.save
    
    expect(move.errors.size).to eq(1)
  end
   

end
