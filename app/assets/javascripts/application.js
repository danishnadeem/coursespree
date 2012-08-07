// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
//alert('application js called');
    //$('#create').hide();
    
    $('#tutorjoin').click(function(){
    
    var creat_link = $('#create').attr('href');
    //var serverbase = 'http://localhost:3000'
    var serverbase = "http://198.101.226.133"
    var startlink = serverbase + '/meetings/' + $(this).attr('id').substr(10,2) + '?started=2'
        $.ajax({
            type: "GET",
            url: creat_link
        });//ajax end
        //alert("ajaxed");
        setTimeout(function(){
        
        $.ajax({
            type: "GET",
            url: startlink
        });
            
            },1000);
    //return false
    //alert('tutor join clicked');
    //return false
    });//tutorjoin click end
    
    
});