$(document).ready(function(){
    if (window.top !== window) {
        $("body").addClass("embed");
    }
    
    var s_prefix = "OBE";
    if (typeof (document.title) != "undefined") {
        var s_pageName = s_prefix + ":" + document.title
    }
    $.getScript("https://www.oracleimg.com/us/assets/metrics/ora_docs.js");
    
    var toc = $("#toc").tocify({
        selectors: "h2,h3,h4,h5"
    }).data("toc-tocify");

    //prettyPrint();
    //$(".optionName").popover({trigger: "hover"});

    //sets options
    toc.setOptions({extendPage: false, showEffect: "fadeIn", smoothScroll: false});

    // Writes all of the current plugin options to the console
    console.log(toc.options);

var mainnav = $(".left-nav-tut");
$(window).scroll(function(){
	if( $(this).scrollTop() > $("article").offset().top ) {
		
		//do this
		mainnav.addClass("left-nav-tutscrl");
	}else{
		mainnav.removeClass("left-nav-tutscrl");
	}	
	
	
});//end function
});//end doc ready function





///////////////////////

/*if greater than 768 set class to active*/
//run on document load and on window resize
$(document).ready(function () {
sidebarfun();
});

//on resize
/*$(window).resize(function(){
sidebarfun();
    });
	*/
	


    /* Store the window width */
    var windowWidth = $(window).width();

    /* Resize Event */
    $(window).resize(function(){
        // Check window width has actually changed and it's not just iOS triggering a resize event on scroll
        if ($(window).width() != windowWidth) {

            // Update the window width for next time
            windowWidth = $(window).width();

            // Do stuff here
			sidebarfun();

        }

        // Otherwise do nothing

    });


	
	

	
	
	
var sidebarfun = function(){
	           if ($(window).width() > 769) { 
		
		  opensidebar();
			$("#hidenav").css('display','none');
			$("#hidenavw").css('display','none');
						   
		   }else{
			   
			closesidebar();
				
				
			   };
	};
	

var opensidebar = function(){

		// set width 
		$(".left-nav").css('display','block'); 
		$(".navback").css('width',160+'px');  
		$("#main").css('margin-left',160+'px'); 
	
		 // for search results and tutorials
		$("#sidebar").css('display','block');
	 	$(".navbackwide").css('width',220+'px'); 
		$("#bookContainer").css('margin-left',220+'px'); 
		
		//hide menu icon
		$("#shownav").css('display','none');
		$("#hidenav").css('display','block');
		$("#hidenavw").css('display','block');//wider nav bars
			
};

var closesidebar = function(){
	
		// set width
		$(".left-nav").css('display','none');
  		$(".navback").css('width',40+'px');
		$("#main").css('margin-left',40+'px'); 

		
		// for search results and tutorials
		$("#sidebar").css('display','none');
		$(".navbackwide").css('width',40+'px'); 
		$("#bookContainer").css('margin-left',40+'px');
			
		$("#hidenav").css('display','none');
		$("#hidenavw").css('display','none');//wider nav bars
		$("#shownav").css('display','block');
				
		//show menu icon
				
};


$(document).ready(function(){

// Show Nav Icon Click
$("#shownav").keypress(function (e) {
    if (e.keyCode == 13) {
        opensidebar();
        if($("#hidenavw").length > 0) {
            $("#hidenavw").focus();
        } else {
            $("#hidenav").focus();
        }
    }
});
$("#shownav").click(function(){
		opensidebar();
        if($("#hidenavw").length > 0) {
            $("#hidenavw").focus();
        } else {
            $("#hidenav").focus();
        }
				});
// Hide Nav Icon Click
$("#hidenav").click(function(){  
		closesidebar();
        $("#shownav").focus();        
				});

$("#hidenav").keypress(function (e) {
    if (e.keyCode == 13) {
        closesidebar();
        $("#shownav").focus(); 
    }
});
$("#hidenavw").click(function(){
		closesidebar();
        $("#shownav").focus();         
				});
$("#hidenavw").keypress(function (e) {
    if (e.keyCode == 13) {
        closesidebar();
        $("#shownav").focus(); 
    }
});



					});	   
						   