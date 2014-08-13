<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR" session="true"%>
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
	background: url(img/tutorial/tutorial1.png);
	display: none;
	position: fix;
	top: 0px;
	left: 0px;
	width: 1600px;
	height: 842px;
	width: 1600px;
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
			//$(".backLayer").fadeOut(1000);
			location.href = "main.jsp";
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
		var userID;
		FB
				.login(function(response) {
					if (response.authResponse) {
						console.log('Welcome!  Fetching your information.... ');
						//console.log(response); // dump complete info
						userID = response.authResponse.userID;

						console.log("userhearrrrrrr="
								+ response.authResponse.userID);
						$.ajax({
							url : "/Login",
							type : "post",
							data : "userID=" + userID
						}).done(function() {
							//String
							//str = (String)
							//session.getAttribute("userID");
							//alert("in session!! userID = " + str);
							console.log("success function");
						}).fail(function() {
							alert("fail.....?");
						});
						access_token = response.authResponse.accessToken; //get access token
						user_id = response.authResponse.userID; //get FB UID
						document.getElementById('userID').innerHTML = ''
								+ user_id;

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

		//$(".backLayer").width(width);
		//$(".backLayer").height(height);
		//$(".backLayer").fadeTo(500, 0.5);
		console.log("진행중");
		var tutorialDiv = $("#tutorialDiv");
		//tutorialDiv.css("top", $(document).height() / 2 - 150);
		//tutorialDiv.css("left", $(document).width() / 2 - 150);
		tutorialDiv.fadeIn(500);
		console.log("진행중2");
		console.log("useridhear! = " + userID);
		/* 		$.ajax({
		 url : "/Login",
		 type : "post",
		 data : "userID=" + userID
		 }).done(function() {
		 String
		 str = (String)
		 session.getAttribute("userID");
		 alert("in session!! userID = " + str);
		 }).fail(function() {
		 alert("fail.....?");
		 }); */
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
<script type="text/javascript">
	//tutorial 변경에 필요한 script
	$(function() {
		$("#btn_before")
				.click(
						function() {
							var num = document
									.getElementById('currentTutorial').value;
							if (num != 1) {
								document.getElementById('currentTutorial').value = num - 1;
								var bg = String("img/tutorial/tutorial");
								bg = br + "" + document.getElementById('currentTutorial').value;
								window.alert("" + bg);
								document.getElementById('tutorialDiv').style.backgroundImage = "url(''+bg)";
							}

						});

	});
	$(function() {
		$("#btn_next")
				.click(
						function() {
							var num = document
									.getElementById('currentTutorial').value;
							if (num != 5) {
								document.getElementById('currentTutorial').value = Number(num) + 1;
								var bg = String("img/tutorial/tutorial");
								bg = br + "" + (num + 1);
								document.getElementById("tutorialDiv").style.backgroundImage = "url(''+bg)";
							}
						});
	});
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


	<!--  div class='backLayer'></div> -->
	<div id="tutorialDiv">
		<input type="hidden" id="currentTutorial" value="1" /> <img
			src="img/tutorial/btn_before.png" id="btn_before" /> <img
			src="img/tutorial/btn_next.png" / id="btn_next" />

	</div>


</body>
</html>