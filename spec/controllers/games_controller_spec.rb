require "rails_helper"

RSpec.describe GamesController do
  before do
    user = FactoryGirl.create(:player1)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end
  
  describe "GET index" do
    it "displays a game" do
      game = FactoryGirl.build(:game)
      get :index

      # This test is mostly pointless as the controller only contains a model method
      # But it's useful to know a user can sign in and their see games without error
    end
  end
end
