var base = {
  init: function(){
    $('.flash_message').each(function(){
      base.trigger_flash_message($(this));
    });
  },
  
  trigger_flash_message: function(message){  
    message.animate({'margin-top':-message.outerHeight()+'px'}, 0, function(){
      $(this).animate({'margin-top':'0px'}, function(){
        $(this).animate({opacity:1}, 3000, function(){
          $(this).slideUp('fast', function(){
            $(this).remove();
          });
        });
      });
    });    
  }
};

$(document).ready(function(){
  base.init();
});
