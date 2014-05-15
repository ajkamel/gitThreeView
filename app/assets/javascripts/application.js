// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require tween.min
//= require three.min
//= require stats.min
//= require Detector
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ready(function() {

  $('.repo-link').on('click', getGraphData);
    //Make AJAX Request to welcome page for class name
    function getGraphData(event){
        console.log(event.target.href);
        event.preventDefault();
        $.getJSON(event.target.href, function(data) {
            console.log(data);
            $("#graph-canvas").html("");
            createGraph(data);
        });
    }

  // createGraph();
});
