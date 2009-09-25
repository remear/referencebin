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
