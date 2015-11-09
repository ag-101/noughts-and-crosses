module GamesHelper
  def render_game(game)
    rows = 3
    cols = 3
    
    content = ''.html_safe
    count = 0
    
    (1..rows).each do |row|
      row_content = ''.html_safe
      (1..cols).each do |col|
        row_content += content_tag :td, '', class: 'space', data: { space: count }
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
