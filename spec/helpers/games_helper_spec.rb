require "spec_helper"
require "rails_helper"

describe GamesHelper do
  describe "render_game" do
    it "renders a table" do
      game = FactoryGirl.build(:game)

      expect(helper.render_game(game)).to match /table/
    end
  end
end