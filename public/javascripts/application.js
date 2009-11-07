// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() 
{
  $('a[rel*=facebox]').facebox()
});

$.fn.selectRange = function(start, end)
{
  return this.each(function() {
          if(this.setSelectionRange) {
                  this.focus();
                  this.setSelectionRange(start, end);
          } else if(this.createTextRange) {
                  var range = this.createTextRange();
                  range.collapse(true);
                  range.moveEnd('character', end);
                  range.moveStart('character', start);
                  range.select();
          }
  });
};

jQuery.fn.delay = function(time,func){
    return this.each(function(){
        setTimeout(func,time);
    });
};

function guideMenu(div){
  /*$(".flyout").each(function(){
    $(this).hide();
  });*/
  element = document.getElementById(div);
  toggle = document.getElementById(div+"toggle");

  if (element.style.display == "none") {
    $(toggle).removeClass('inactive');
    $(toggle).addClass('active');

    $(element).fadeIn(function(){
      $('body').click(function(){
        $(toggle).removeClass('active');
        $(toggle).addClass('inactive');
        $(element).fadeOut();
        $("body").unbind("click");
      });
    });
    
  } else {
    $(toggle).removeClass('active');
    $(toggle).addClass('inactive');
    
    $(element).fadeOut();
  }
}

//check if password field == password confirmation field
//show good password message if true
function checkPasswordMatch()
{
  //FIXME: fix problem with bad-password-message being shown because of pre-existing setTimeout()

  if ($('#user_password').val() == $('#user_password_confirmation').val())
  {
    $("#password-message").html("<p id=\"good-password-message\">Passwords match</p>");
    clearTimeout();
  }
  else
  {
    setTimeout(function() {
      $("#password-message").html("<p id=\"bad-password-message\">Passwords don't match</p>");
    }, 5000);
  }
  
}