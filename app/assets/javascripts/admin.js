// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//
//= require jquery
//= require jquery-ui/effect-blind
//= require jquery_ujs
//= require bootstrap
//= require Chart





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




// jQuery(function() {
//   var data, my_doughnut_expenses_chart;
//   data = [
//     {
//         value: 300,
//         color:"#F7464A",
//         highlight: "#FF5A5E",
//         label: "Red"
//     },
//     {
//         value: 50,
//         color: "#46BFBD",
//         highlight: "#5AD3D1",
//         label: "Green"
//     },
//     {
//         value: 100,
//         color: "#FDB45C",
//         highlight: "#FFC870",
//         label: "Yellow"
//     }
// ]
//   return my_doughnut_expenses_chart = new Chart($("#canvas_expenses").get(0).getContext("2d")).Doughnut(data,{
//     animationEasing : "easeOutSine"
//   });
// });

console.log(gon.daily_income);
console.log(gon.daily_income_dates);

console.log(gon.monthly_profits);
console.log(gon.profit_loss_months);

jQuery(function() {
  var data = [], my_doughnut_expenses_chart;

  function Data(value,label,color,highlight){
    this.value = value;
    this.label = label;
    this.color = color;
    this.highlight = highlight;
  }

  function shadeColor2(color, percent) {   
    var f=parseInt(color.slice(1),16),t=percent<0?0:255,p=percent<0?percent*-1:percent,R=f>>16,G=f>>8&0x00FF,B=f&0x0000FF;
    return "#"+(0x1000000+(Math.round((t-R)*p)+R)*0x10000+(Math.round((t-G)*p)+G)*0x100+(Math.round((t-B)*p)+B)).toString(16).slice(1);
  }

  for(var i = 0; i < gon.expenses_account.length; i++)
  {
    var pie_data = new Data(gon.expenses_amount[i],gon.expenses_account[i],shadeColor2("FF0000",(i + 0.05)),shadeColor2("5AD3D1",0));
    data.push(pie_data);
  }

  return my_doughnut_expenses_chart = new Chart($("#canvas_expenses").get(0).getContext("2d")).Doughnut(data,{
    animationEasing : "easeOutQuart",
    tooltipTemplate: "<%if (label){%><%= label%>: <%}%>Ksh <%= value %>"
  });

});



//Charts views
jQuery(function() {
  var data , myNewChart;
  data = {
    labels: gon.daily_income_dates,
    datasets: [
     {
        fillColor: "rgba(133, 238, 139, 0.2)",
        strokeColor: "rgba(133, 238, 139, 1)",
        pointColor: "#fff",
        pointStrokeColor: "rgba(133, 238, 139, 1)",
        data: gon.daily_income
      }
    ]
  };
  return myNewChart = new Chart($("#shop_income").get(0).getContext("2d")).Line(data,{
    datasetStrokeWidth : 4,
    pointDotRadius : 8,
    bezierCurveTension : 0,
    pointDotStrokeWidth : 4,
    tooltipTemplate: "<%if (label){%><%= label%>: <%}%>Ksh <%= value %>"
  });
});

//Charts views
jQuery(function() {
  var data, myNewChart;
  data = {
    labels: gon.profit_loss_months,
    datasets: [
     {
        fillColor: "rgba(151,187,205, 0.2)",
        strokeColor: "rgba(62, 241, 255, 1)",
        pointColor: "#fff",
        pointStrokeColor: "rgba(62, 241, 255, 1)",
        data: gon.monthly_profits
      }
    ]
  };
  return myNewChart = new Chart($("#profit_loss").get(0).getContext("2d")).Line(data,{
    datasetStrokeWidth : 4,
    pointDotRadius : 8,
    bezierCurveTension : 0,
    pointDotStrokeWidth : 4,
    tooltipTemplate: "<%if (label){%><%= label%>: <%}%>Ksh <%= value %>"
  });
});




