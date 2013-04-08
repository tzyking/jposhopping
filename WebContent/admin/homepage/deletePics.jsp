<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.bjsxt.shopping.homepage.* " %>
<%
	String category = request.getParameter("category");
	//category = "shopping";
	String order = picsOrder.getCurrentOrderByCategoryName(category);
	//String rootpath = ;
	String rooturl =  request.getScheme() + "://" + request.getServerName() + request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<title>John Patrick Organic:Delete Pictures</title>
	<link rel="stylesheet" href="photo-manager_files/jquery.css">
	<script src="photo-manager_files/jquery-1.js"></script>
	<script src="photo-manager_files/jquery_008.js"></script>
	<script src="photo-manager_files/jquery_006.js"></script>
	<script src="photo-manager_files/jquery_005.js"></script>
	<script src="photo-manager_files/jquery.js"></script>
	<script src="photo-manager_files/jquery_004.js"></script>
	<script src="photo-manager_files/jquery_002.js"></script>
	<script src="photo-manager_files/jquery_007.js"></script>
	<script src="photo-manager_files/jquery_003.js"></script>
	<link rel="stylesheet" href="photo-manager_files/demos.css">
	<style>
	#gallery { float: left; width: 65%; min-height: 12em; } * html #gallery { height: 12em; } /* IE6 */
	.gallery.custom-state-active { background: #eee; }
	.gallery li { float: left; width: 254px; padding: 0.4em; margin: 0 0.4em 0.4em 0; text-align: center; }
	.gallery li h5 { margin: 0 0 0.4em; cursor: move; }
	.gallery li a { float: right; }
	.gallery li a.ui-icon-zoomin { float: left; }
	.gallery li img { width: 100%; cursor: move; }

	#trash { float: right; width: 32%; min-height: 18em; padding: 1%;} * html #trash { height: 18em; } /* IE6 */
	#trash h4 { line-height: 16px; margin: 0 0 0.4em; }
	#trash h4 .ui-icon { float: left; }
	#trash .gallery h5 { display: none; }
	</style>
	<script>
	$(function() {
		// there's the gallery and the trash
		var $gallery = $( "#gallery" ),
			$trash = $( "#trash" );

		// let the gallery items be draggable
		$( "li", $gallery ).draggable({
			cancel: "a.ui-icon", // clicking an icon won't initiate dragging
			revert: "invalid", // when not dropped, the item will revert back to its initial position
			containment: $( "#demo-frame" ).length ? "#demo-frame" : "document", // stick to demo-frame if present
			helper: "clone",
			cursor: "move"
		});

		// let the trash be droppable, accepting the gallery items
		$trash.droppable({
			accept: "#gallery > li",
			activeClass: "ui-state-highlight",
			drop: function( event, ui ) {
				deleteImage( ui.draggable );
			}
		});

		// let the gallery be droppable as well, accepting items from the trash
		$gallery.droppable({
			accept: "#trash li",
			activeClass: "custom-state-active",
			drop: function( event, ui ) {
				recycleImage( ui.draggable );
			}
		});

		// image deletion function
		var recycle_icon = "<a href='link/to/recycle/script/when/we/have/js/off' title='Recycle this image' class='ui-icon ui-icon-refresh'>Recycle image</a>";
		function deleteImage( $item ) {
			$item.fadeOut(function() {
				var $list = $( "ul", $trash ).length ?
					$( "ul", $trash ) :
					$( "<ul class='gallery ui-helper-reset'/>" ).appendTo( $trash );

				$item.find( "a.ui-icon-trash" ).remove();
				$item.append( recycle_icon ).appendTo( $list ).fadeIn(function() {
					$item
						.animate({ width: "48px" })
						.find( "img" )
							.animate({ height: "36px" });
				});
			});
		}

		// image recycle function
		var trash_icon = "<a href='link/to/trash/script/when/we/have/js/off' title='Delete this image' class='ui-icon ui-icon-trash'>Delete image</a>";
		function recycleImage( $item ) {
			$item.fadeOut(function() {
				$item
					.find( "a.ui-icon-refresh" )
						.remove()
					.end()
					.css( "width", "254px")
					.append( trash_icon )
					.find( "img" )
						.css( "height", "200px" )
					.end()
					.appendTo( $gallery )
					.fadeIn();
			});
		}

		// image preview function, demonstrating the ui.dialog used as a modal window
		function viewLargerImage( $link ) {
			var src = $link.attr( "href" ),
				title = $link.siblings( "img" ).attr( "alt" ),
				$modal = $( "img[src$='" + src + "']" );

			if ( $modal.length ) {
				$modal.dialog( "open" );
			} else {
				var img = $( "<img alt='" + title + "' width='384' height='288' style='display: none; padding: 8px;' />" )
					.attr( "src", src ).appendTo( "body" );
				setTimeout(function() {
					img.dialog({
						title: title,
						width: 400,
						modal: true
					});
				}, 1 );
			}
		}

		// resolve the icons behavior with event delegation
		$( "ul.gallery > li" ).click(function( event ) {
			var $item = $( this ),
				$target = $( event.target );

			if ( $target.is( "a.ui-icon-trash" ) ) {
				deleteImage( $item );
			} else if ( $target.is( "a.ui-icon-zoomin" ) ) {
				viewLargerImage( $target );
			} else if ( $target.is( "a.ui-icon-refresh" ) ) {
				recycleImage( $item );
			}

			return false;
		});
		
		 $("#btnNextStep").click(function(){
		    var order = "";
    		$("#gallery > li").each(function(){
        		order = order + $(this).attr("id") + ",";
      		});
      		order = order.substring(0, (order.length-1));
      		//alert(order);
      		
      		$.ajax({
					type: 		"post",
					url: 		"savePicsOrder.jsp",
					data: 		"currentorder=" + order + "&category=<%=category%>",
					success:	function(msg) {
							alert(msg);
							window.location.href = "reorderPics.jsp?category=<%=category%>";
							
					}
				});
      		 
    		
  		});
		
		
	});
	</script>
</head>
<body>

<div class="demo ui-widget ui-helper-clearfix">

<ul id="gallery" class="gallery ui-helper-reset ui-helper-clearfix ui-droppable">
<%
	StringTokenizer st = new StringTokenizer(order, ","); 
	 while (st.hasMoreTokens()) {
	 	String item = st.nextToken();
%>
	<li class="ui-widget-content ui-corner-tr ui-draggable" id="<%=item %>">
		<h5 class="ui-widget-header"><%=item %></h5>
		<img src="../../sample_files/<%=category %>/<%=item %>.jpg" alt="The peaks of High Tatras" width="254" height="200">
		<a href="<%=rooturl%>/sample_files/<%=category %>/<%=item %>.jpg" title="View larger image" class="ui-icon ui-icon-zoomin">View larger</a>
		<a href="http://jqueryui.com/demos/droppable/link/to/trash/script/when/we/have/js/off" title="Delete this image" class="ui-icon ui-icon-trash">Delete image</a>
	</li>
<%} %>

</ul>

<div id="trash" class="ui-widget-content ui-state-default ui-droppable">
	<h4 class="ui-widget-header"><span class="ui-icon ui-icon-trash">Trash</span> Trash</h4>
</div>

</div><!-- End demo -->


<div class="demo-description">
<p><button id="btnNextStep" name="btnNextStep">Next Step</button></p>
<p>You can delete an image either by dragging it to the Trash or by clicking the trash icon.</p>
<p>You can "recycle" an image by dragging it back to the gallery or by clicking the recycle icon.</p>
<p>You can view larger image by clicking the zoom icon. jQuery UI dialog widget is used for the modal window.</p>
</div><!-- End demo-description -->



</body></html>