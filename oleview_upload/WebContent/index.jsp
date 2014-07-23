<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oleview</title>
<style>
#page {
	box-shadow: 0 0 0 5px blue inset;
}

.toggler {
	width: 500px;
	height: 200px;
	position: relative;
}

#button {
	float: left;
	/*버튼 이미지 사이즈 만큼*/
	width: 40px;
	height: 30px;
	background: url(img/button1.gif);
	text-indent: -9999px;
	cursor: pointer; /*버튼위에 마우스 올리면 손가락 모양으로!*/
}

#effect {
	width: 500px;
	height: 135px;
	position: fixed;
	left: -200px;
	top: 5%;
}

#content {
	width: 195px;
	height: 2000px;
	float: left;
	font: 18px/1.6 NanumBrushWeb;
	background-color: #666666;
	z-index: 1;
	float: left;
}

#real_content {
	margin_left: 20px;
}

div.backLayer {
	display: none;
	background-color: black;
	position: absolute;
	left: 0px;
	top: 0px;
	z-index: 2;
}

div#tutorialDiv {
	background-color: skyblue;
	display: none;
	position: absolute;
	width: 300px;
	height: 300px;
	z-index: 2;
}
</style>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
<script type="text/javascript">
	jQuery(function() {
		jQuery("#button").toggle(function() {
			jQuery("#effect").animate({
				left : 0
			}, 500);
			jQuery("#button").css({
				"background" : "url(img/button2.gif)"
			});
		}, function() {
			jQuery("#effect").animate({
				left : '-200px'
			}, 500);
			jQuery("#button").css({
				"background" : "url(img/button1.gif)"
			});
		});
	});
</script>

<script src="http://connect.facebook.net/en_US/all.js"
	language="JavaScript" type="text/javascript"></script>
<script>
	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		if (response.status === 'connected') {
			//console.log('status - connected');
			document.getElementById('status').innerHTML = 'login!! success';
			document.getElementById('userID').innerHTML = 'id = '
					+ response.authResponse.userID;

			 
			 //처음인 경우 
			var width = $(window).width();
			var height = $(window).height();

			$(".backLayer").width(width);
			$(".backLayer").height(height);
			$(".backLayer").fadeTo(500, 0.5);

			var tutorialDiv = $("#tutorialDiv");
			tutorialDiv.css("top", $(document).height() / 2 - 150);
			tutorialDiv.css("left", $(document).width() / 2 - 150);
			tutorialDiv.fadeIn(500);

		} else if (response.status === 'not_authorized') {
			document.getElementById('status').innerHTML = 'please log into this app';
		} else {
			document.getElementById('status').innerHTML = 'did you log out?';
		}
	}
	$(document).keydown(function(event) {
		if (event.which == '27') {
			$("#tutorialDiv").fadeOut(500);
			$(".backLayer").fadeOut(1000);
		}
	});
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
			//여기 어딘지 확인하기
			//document.getElementById('userID').innerHTML = 'id = '
			//		+ response.authResponse.userID;
		});
	}
	//페이스북 초기화
	window.fbAsyncInit = function() {
		FB.init({
			appId : '283897015123867',
			status : true,
			xfbml : true
		});
	};
	(function() {
		var e = document.createElement('script');
		e.type = 'text/javascript';
		e.src = document.location.protocol
				+ '//connect.facebook.net/ko_KR/all.js';
		e.async = true;
	}());
</script>

<script>
	var getPage = function() {
		var url = $("#input_url").val();
		var params = "url=" + url;
		$.ajax({
			url : "GetSelectPage",
			data : params
		}).done(function(data) {
			$('#page').empty();
			$('#page').append(data);
			$('#page').find("*").addClass('oleview_tag');
			add_event();
		}).fail(function() {
			alert('Fail?');

		});
		return false;
	}
</script>
<script>
	function add_event() {
		// ele.addEventListener('hover', callback, false)
		$('.oleview_tag').mouseenter(function(event) {
			event.stopPropagation();
			$('#page').find("*").css('box-shadow', 'none');
			$('#page').find("*").css('background-color', 'none');
			$(this).css('box-shadow', '0 0 0 5px blue inset');
			$(this).css('background-color', 'rgba(0, 0, 0, 0.3)');
		});
		//올리브 테그에 클릭이벤트 추가
		$('.oleview_tag').click(
				function(event) {
					event.stopPropagation();

					var parentEls = "";
					//Dom Object를 반환
					parentEls = $(this).parents().map(
							function() {
								var ret = serialize_dom_data(this.tagName,
										this.id, this.className);
								return ret;
							}).get().join(",");

					var parentEls_arry = parentEls.split(",");
					parentEls_arry.reverse();
					var parentEls_str = parentEls_arry.toString();
					parentEls_str += ",";
					parentEls_str += serialize_dom_data(this.tagName, this.id,
							this.className);

					select_dom($(this), parentEls_str);
				});
	}
	function serialize_dom_data(tag_name, tag_id, tag_class) {
		var ret_str = tag_name;

		//ID가 존재하면 추가
		if (tag_id != '') {
			ret_str += "#";
			ret_str += tag_id;
		}

		//Class에 Oleview 테그 제거
		tag_class = tag_class.replace(' oleview_tag', '');
		tag_class = tag_class.replace('oleview_tag', '');

		//Class가 존재할경우 추가
		if (tag_class != '') {
			var tag_class_arry = tag_class.split(" ");
			for ( var i in tag_class_arry) {
				if (isValidClass(tag_class_arry[i])) {
					ret_str += ".";
					ret_str += tag_class_arry[i];
				}
			}
		}

		return ret_str;
	}
	function isValidClass(str) {
		if (str == '')
			return false;
		if (str.indexOf("#") > -1)
			return false;
		return true;
	}
	function replaceAll(str, orgStr, repStr) {
		return str.split(orgStr).join(repStr);
	}

	function select_dom(element, dom_data) {
		var width = element.width();
		var height = element.height();
		var url = $("#input_url").val();

		var replace_url = "main.jsp?" + "width=" + width + "&height=" + height
				+ "&url=" + encodeURIComponent(url) + "&dom_data="
				+ encodeURIComponent(dom_data);
		//main.jsp 페이지로 이동 + 파라미터 전달
		window.location = replace_url;
	}
</script>
</head>
<body>

<div class='backLayer'></div>
	<div id="effect">
		<div id="content">
			<div id="real_content">
				<br>
				<fb:login-button autologoutlink="true" onlogin="checkLoginState();"></fb:login-button>
				<br> <br>

				<!-- 로그인한 프로필 사진-->
				<fb:profile-pic uid="loggedinuser" size="square"></fb:profile-pic>
				<!-- 로그인한 이름 -->
				<fb:name uid="loggedinuser" use-you="no"></fb:name>
				<br>
				<div id="status"></div>
				<div id="userID"></div>

			</div>
		</div>
		<div id="button">
			<p>
				<a href="#">Toggle</a>
			</p>
		</div>

	</div>

	<div id="tutorialDiv">tutorial Div!</div>

	<div id="page"></div>
	<form onsubmit="getPage(); return false;">
		<table>
			<tr>
				<td>URL 입력 :</td>
				<td><input type="text" id="input_url" name="input_url" /></td>
				<td><input type="submit" /></td>
			</tr>
		</table>
	</form>
</body>
</html>