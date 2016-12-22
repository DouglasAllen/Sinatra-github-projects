// This script allows the sticky sidemenu

var elementPosition = $('#sidemenu').offset();

$(window).scroll(function(){
  if($(window).scrollTop() > elementPosition.top){
    $('#sidemenu').css('position','fixed').css('top','0').css('width', '20%');
  }
  else {
    $('#sidemenu').css('position','static').css('width', '25%');
  }
});
