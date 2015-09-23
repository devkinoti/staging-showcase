// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//
//= require jquery
//= require jquery-ui/effect-blind
//= require jquery_ujs
//= require bootstrap
//= require turbolinks



var flashCallback;

flashCallback = function() {
  return $(".alert").slideUp({
    height: 0,
    opacity: 0
  }, 350, function() {
    return $(this).remove();
  });
};

$(function() {
  $(".alert").bind('click', (function(_this) {
    return function(ev) {
      return flashCallback();
    };
  })(this));
  return setTimeout(flashCallback, 3000);
});