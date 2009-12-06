// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() 
{
  $('a[rel*=facebox]').facebox()
  
  //flash message fade-out
  $('#flash').delay(5000, function(){
    $("#flash").fadeTo("slow", 0.01, function(){ //fade
         $(this).remove(); //then remove from the DOM
     });
  });
  
  /*
  //Grab the original BG color of the link
  var originalBG = $(".url").css("background-color"); 
  //The color you want to fade too
  var fadeColor = "#99FF99"; 

  $('.url').mouseover(function(){
    $(this).animate({backgroundColor:fadeColor}, 750)
  });
  $('.url').mouseout(function(){
    $(this).animate({backgroundColor:originalBG},750) 
  });*/
  
  $(document).ready(function() {

      $(".signin").click(function(e) {          
	e.preventDefault();
          $("fieldset#signin_menu").toggle();
	$(".signin").toggleClass("menu-open");
      });

  $("fieldset#signin_menu").mouseup(function() {
  	return false
  });
  
  $(document).mouseup(function(e) {
  	if($(e.target).parent("a.signin").length==0) {
  		$(".signin").removeClass("menu-open");
  		$("fieldset#signin_menu").hide();
    	}
    });			

  });
  
});

function swapResults(query, type)
{
  if(type)
  {
    $.get("/search?query="+type+":"+query, function(data){$("#results").html(data);});
    $("#searchtypes").removeClass();
    $("#searchtypes").addClass('comments');
  }
  else
  {
    $.get("/search?query="+query, function(data){$("#results").html(data);});
    $("#searchtypes").removeClass();
    $("#searchtypes").addClass('bookmarks');
  }
}

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