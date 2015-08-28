# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#= require jquery
#= require jquery-ui/effect-blind
#= require jquery_ujs
#= require bootstrap
#= require turbolinks
#= require Chart


flashCallback = ->
    $(".alert").slideUp
      height: 0
      opacity: 0
    , 350
    , ->
      $(this).remove()

$ ->
    $(".alert").bind 'click', (ev) =>
        flashCallback()
    setTimeout flashCallback, 6000