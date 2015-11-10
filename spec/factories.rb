FactoryGirl.define do
  factory :player1, class: User do
    id 1
    username "Player1"
    email "player1@overthere.com"
    password "testtest"
  end
  
  factory :player2, class: User do
    id 2
    username "Player2"
    email "player2@overthere.com"
    password "testtest"
  end  
  
  factory :game do  
    id 1
    player1 FactoryGirl.build(:player1)
    player2 FactoryGirl.build(:player2)
    status 'new'
  end
  
  factory :move do
    id 1
    game FactoryGirl.build(:game)
    player FactoryGirl.build(:player1)
    position 0
  end
end