<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>올리뷰-시작화면</title>
<style>
div.start_bg {
	position: relative;
	top: -10px;
	left: -10px;
}

div.backLayer {
	display: none;
	background-color: black;
	position: absolute;
	left: 0px;
	top: 0px;
}

div#tutorialDiv {
	background-color: skyblue;
	display: none;
	position: absolute;
	width: 300px;
	height: 300px;
}
</style>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>

<script src="http://connect.facebook.net/en_US/all.js"
	language="JavaScript" type="text/javascript">
	
</script>
<script>
	$(document).keydown(function(event) {
		if (event.which == '27') {
			$("#tutorialDiv").fadeOut(500);
			$(".backLayer").fadeOut(1000);
			location.href = "index.jsp";
		}
	});

	//페이스북 초기화
	window.fbAsyncInit = function() {
		FB.init({
			appId : '283897015123867',
			status : true,
			cookie : true,
			xfbml : true
		});
	};
	function fb_login() {
		FB
				.login(function(response) {
					if (response.authResponse) {
						console.log('Welcome!  Fetching your information.... ');
						//console.log(response); // dump complete info
						access_token = response.authResponse.accessToken; //get access token
						user_id = response.authResponse.userID; //get FB UID
						document.getElementById('userID').innerHTML = ''
								+ user_id;
<%Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager
					.getConnection("jdbc:mysql://localhost/leeminka2",
							"leeminka2", "oleview1");
			Statement stmt = conn.createStatement();
			String query = "insert into user values('1', '1')";
			stmt.executeQuery(query);
			
			stmt.close();
			conn.close();
			
			%>
	FB.api('/me', function(response) {
							user_email = response.email; //get user email
							// you can store this data into your database             
						});

					} else {
						//user hit cancel button
						console
								.log('User cancelled login or did not fully authorize.');

					}
				});
		$(".start_bg").fadeOut(1000);
		var width = $(window).width();
		var height = $(window).height();

		$(".backLayer").width(width);
		$(".backLayer").height(height);
		$(".backLayer").fadeTo(500, 0.5);
		console.log("진행중");
		var tutorialDiv = $("#tutorialDiv");
		tutorialDiv.css("top", $(document).height() / 2 - 150);
		tutorialDiv.css("left", $(document).width() / 2 - 150);
		tutorialDiv.fadeIn(500);
		console.log("진행중2");

	}
	(function() {
		var e = document.createElement('script');
		e.src = document.location.protocol
				+ '//connect.facebook.net/en_US/all.js';
		e.async = true;
		document.getElementById('fb-root').appendChild(e);
	}());

	function fb_logout() {
		FB.logout(function(response) {
			window.alert('byebye!');
			window.location.href = "";
		});
	}
</script>
</head>
<body>
	<div class="start_bg">
		<img src="img/bg_1st-bg2.png"
			style="position: absolute; left: 0px; top: 0px" /><img
			src="img/btn_start.png" border="0" alt=""
			style="position: absolute; left: 700px; top: 560px"
			onclick="fb_login();">
	</div>


	<div class='backLayer'></div>
	<div id="tutorialDiv">tutorial Div!</div>

</body>
</html>