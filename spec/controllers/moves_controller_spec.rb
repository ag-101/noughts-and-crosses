require "rails_helper"

RSpec.describe MovesController do
  before do
    user = FactoryGirl.create(:player1)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
    @game = FactoryGirl.create(:game)
  end
  
  describe "GET new" do 
    it "saves a valid move" do
      get :new, game_id: @game.id, position: 0
      expect(flash[:notice]).to eq('Move was successfully created.')
    end
    
    it "won't save an invalid move" do
      get :new, game_id: -1, position: 0
      expect(flash[:alert]).to eq('Invalid move.')
    end


    #it "won't save a move if the game is over" do
    #  get :new, game_id: @game.id, position: 0
    #end   
    
    
  end
end
