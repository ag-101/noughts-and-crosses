var games={init:function(){$(".game-container-loader").each(function(){var a=$(this);setTimeout(function(){games.load_game(a)},3e3)})},load_game:function(a){var e=a.data("url");$.ajax({url:e,dataType:"html"}).success(function(e){a.html(e),setTimeout(function(){games.load_game(a)},3e3)})}};$(document).ready(function(){games.init()});