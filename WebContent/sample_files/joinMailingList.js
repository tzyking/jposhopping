var globalX = 0;
var xDiff = 0;
var lastPhotoX = 0;
var containerToMove = null;
var movementXCoord = 0;
var startedMoving;
var	finishedMoving;
var timeDiff;
var moved = false;
var movementTimer;
var totalDistance = 0;
var movementIntervalOne;
var movementIntervalTwo;
var loadShopping = 0;
var index = 1;
var temp = 0;

$(document).ready(function() {
	
	$("#lnkSubmit").click(function(event) {
		event.preventDefault(); 
		var emailaddr = $("#email").val(); 
		if(!isValidEmailAddress(emailaddr)){
			$("p.errorinfo").append('<font size="14" color="red">Invalid email address, please check and re-enter.</font>');
		}else{
			//alert("good one");
		    $.ajax({
				type: 		"post",
				url: 		"addToMailingList.jsp",
				data: 		"email=" + emailaddr,
				success:	function(msg) {
								//alert(msg);
								$("li.emailline, li.submitline, p.errorinfo").empty(); 
								$("li.thanksline").append('<font size="14">THANK YOU!</font>');
								setTimeout("backToMainPage()",3000);
								//window.location.href = "index.jsp";	
							}
			}); 
		}
	});
	
	
});

function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
}

function backToMainPage() {
	window.location.href = "index.jsp";
}

function expandCollection() {
			$("#backhome").show(100);
			$("div.contact").hide(100);
			
			$("#other_container").height(200);
			$("#other_container").hide(500);
			$("#other_container").removeClass("container");

			$("#shopping_container").height(200);
			$("#shopping_container").hide(500);
			$("#shopping_container").removeClass("container");
			
			$("#look_container").height(630);
			$("#look_container").show(500);
			$("#look_container").addClass("container");
			
			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("#look_container div.category_container").width(0);
			index = 1; 
			$("#look_container div.category_container div.photo img").each(function(){
				
				$(this).attr("src","sample_files/look/b" + index.toString() + ".jpg");
				index++;
				var curWidth = $("#look_container div.category_container").width();
				$("#look_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
				//alert("add new one finished");
			});		


}
function expandShopping(){
	
			$("#backhome").show(100);
			$("div.contact").hide(100);
			
			$("#other_container").height(200);
			$("#other_container").hide(500);
			$("#other_container").removeClass("container");

			$("#look_container").height(200);
			$("#look_container").hide(500);
			$("#look_container").removeClass("container");
			
			$("#shopping_container").height(630);
			$("#shopping_container").show(500);
			$("#shopping_container").addClass("container");
			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
			     
				$(this).attr("src","");
				// alert("delete orginal photo finished");
			});
			$("div.category_container_shopping").width(0);
			index = 1; 
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
				
				$(this).attr("src","sample_files/shopping/b" + index.toString() + ".jpg");
				index++;
				var curWidth = $("div.category_container_shopping").width();
				$("div.category_container_shopping").width(curWidth + 10);
				initializeImage($(this).parent("div.shoppingphoto"));
				//alert("add new one finished");
			});
	
	}
function  expandAbout() {
			$("#backhome").show(100);
			$("div.contact").hide(100);

			$("#look_container").height(200);
			$("#look_container").hide(500);
			$("#look_container").removeClass("container");
			
			$("#shopping_container").height(200);
			$("#shopping_container").hide(500);
			$("#shopping_container").removeClass("container");
			
			$("#other_container").height(630);
			$("#other_container").show(500);
			$("#other_container").addClass("container");

			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("#other_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("#other_container div.category_container").width(0);
			index = 1; 
			$("#other_container div.category_container div.photo img").each(function(){
				if(index <5)
					temp = 40 + index;
				if(index >4)
					temp = index - 4;
					
				$(this).attr("src","sample_files/other/b" + temp.toString() + ".jpg");
				index++;
				var curWidth = $("#other_container div.category_container").width();
				$("#other_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
				//alert("add new one finished");
			});		
}
function resetPage() {
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("div.contact").hide(100);
			$("#backhome").hide(100);
			
			$("#look_container").show(500);
			$("#shopping_container").show(500);
			$("#other_container").show(500);
			
			$("#look_container").addClass("container");
			$("#shopping_container").addClass("container");
			$("#other_container").addClass("container");
			
			$("#look_container").height(200);
			$("#shopping_container").height(200);
			$("#other_container").height(200);
			
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){   
				$(this).attr("src","");
				// alert("delete orginal photo finished");
			});
			$("#other_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			
			$("#look_container div.category_container").width(0);
			$("div.category_container_shopping").width(0);
			$("#other_container div.category_container").width(0);
			
			index = 1;
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","sample_files/look/" + index.toString() + ".jpg");
				index++;
				var curWidth = $("#look_container div.category_container").width();
				$("#look_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
			});
			index = 1;
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
				
				$(this).attr("src","sample_files/shopping/" + index.toString() + ".jpg");
				index++;
				var curWidth = $("div.category_container_shopping").width();
				$("div.category_container_shopping").width(curWidth + 10);
				initializeImage($(this).parent("div.shoppingphoto"));
				//alert("add new one finished");
			});
			index = 1;
			$("#other_container div.category_container div.photo img").each(function(){ 
				if(index <5)
					temp = 40 + index;
				if(index >4)
					temp = index - 4;
					  
				$(this).attr("src","sample_files/other/" + temp.toString() + ".jpg");
				index++;
				var curWidth = $("#other_container div.category_container").width();
				$("#other_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
			});
}

function handleKeyPress(e) {
	if(e.which == 39 || e.which == 37) {
  		if ($("a.left:visible").next("div.category_container, div.category_container_shopping").length > 0) {
  			var theContainer = $("a.left:visible").next("div.category_container, div.category_container_shopping");
  			var containerLeft = theContainer.position().left;
  			theContainer.stop();
  			if (e.which == 39) {
  				var found = false;
  					//alert(containerLeft);
  					theContainer.children("div.photo, div.shoppingphoto").each(function() {
  						if (($(this).offset().left - 60) > 0 && !found) {
  							found = true;
  							containerLeft = -($(this).position().left);
  						}
  						//alert($(this).offset().left - 60);
  					});
  				//containerLeft = containerLeft - 100;
  				theContainer.animate({left: containerLeft + "px"}, 200, "swing");
  			}
  			else if (e.which == 37) {
  				theContainer.children("div.photo, div.shoppingphoto").each(function() {
  					if (($(this).offset().left - 60) < 0)
  						containerLeft = -($(this).position().left);	
  				});
  				theContainer.animate({left: containerLeft + "px"}, 200, "swing");
  			}
  		}
	}
}

function moveRight(movingSpeed) {
  var left = containerToMove.position().left - movingSpeed;
  if ((left + containerToMove.width()) >= ($(window).width() - 160))
    containerToMove.css("left", left + "px");
}

function moveLeft(movingSpeed) {
  var left = containerToMove.position().left + movingSpeed;
  if (left <= 50)
    containerToMove.css("left", left + "px");
}

function doneMoving() {
	if (containerToMove != null) {
			if (containerToMove.position().left > 0)
				containerToMove.animate({left: "0px"}, 250, "swing");
			else if ((containerToMove.position().left + containerToMove.width()) < ($(window).width() - 110)) {
				var position = ($(window).width() - 110) - containerToMove.width()
				containerToMove.animate({left: position + "px"}, 250, "swing");
			}
			containerToMove = null;
		}
}

function initializeImage(image) {
	if (image.width() > 0) {
		var curWidth = image.parent("div.category_container, div.category_container_shopping").width();
		image.parent("div.category_container, div.category_container_shopping").width(curWidth + image.width());
		image.children("div.photo_overlay").css("background-color", "transparent");

		if (curWidth + image.width() > $(window).width()) {
      		if (image.siblings("div.loader").length > 0) {
        		loadAnimation(image);        
      		}
    	} 
	}
	else {
		setTimeout(function() { initializeImage(image); }, 5);
	}
}


function movementTimerElapsed() {
	startedMoving = new Date().getTime();
	totalDistance = 0;	
}

function loadAnimation(image) {
  if ($("div.container:animated").length == 0) {
    image.siblings("div.loader").remove();
    image.parents("div.container").animate({
      width: $(window).width() - 120,
      height: image.height() + 'px'
    }, 500, "swing", function() { $(this).css("width", "auto") });
  }
  else {
    setTimeout(function() { loadAnimation(image) }, 250);
  }
}

function doneLoading(e) {
  alert(e.css("position"));
}