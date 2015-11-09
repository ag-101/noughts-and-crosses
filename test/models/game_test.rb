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

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
