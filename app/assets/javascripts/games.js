var games = {
  init: function(){
    $('.game-container-loader').each(function(){
      var target = $(this);
      setTimeout(function(){ games.load_game(target); }, 3000);
    });
  },
  
  load_game: function(target){
    var url = target.data('url');
    $.ajax({
      url: url,
      dataType: 'html'
    }).success(function(data){ 
      target.html(data);
      setTimeout(function(){ games.load_game(target); }, 3000);      
    });
  }
};

$(document).ready(function(){
  games.init();
});
