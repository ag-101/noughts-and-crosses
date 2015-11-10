module GamesHelper
  def stats
    content_tag :h4, "Played #{current_user.games.count} | Won #{current_user.winners.count}"   
  end
  
  def render_game(game)
    rows = 3
    cols = 3
    
    content = ''.html_safe
    count = 0
    
    moves = {}
    game.moves.each do |move|
      moves[move.position] = move
    end
    
    current_user_move = (game.moves.empty? and game.player1 == current_user) || (game.moves.any? and game.moves.last.player != current_user) rescue false
            
    (1..rows).each do |row|
      row_content = ''.html_safe
      (1..cols).each do |col|
        
        row_content += content_tag :td, class: "#{current_user_move ? 'space' : 'disabled'}", data: { space: count } do
          if moves[count]
            token = content_tag :span, '&times'.html_safe, class: 'player1' if moves[count].player.username == game.player1.username            
            token = content_tag :span, '&#x25CF;'.html_safe, class: 'player2' if moves[count].player.username == game.player2.username
            token
          else
            link_to '&nbsp;'.html_safe, new_game_moves_path(game, count), class: 'btn btn-success alert-success btn-block' if current_user_move and !game.check_for_winner
          end
        end
        count += 1
      end
      
      content += content_tag :tr do
        row_content
      end
    end
    
    content_tag :table, class: 'noughts-and-crosses-board' do
      content
    end
  end
end
