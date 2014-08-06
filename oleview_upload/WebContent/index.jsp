<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, 
javax.sql.*, 
java.io.*,
javax.naming.InitialContext,
javax.naming.Context"%>
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
	width: 37px;
	height: 33px;
	background: url(img/btn_slide.png);
	text-indent: -9999px;
	cursor: pointer; /*버튼위에 마우스 올리면 손가락 모양으로!*/
	position: fixed;
	top: 7px;
	left: 2px;
}

#bgbutton {
	float: right;
	width: 37px;
	height: 33px;
	background: url(img/background/btn_bgskin.png);
	text-indent: -9999px;
	cursor: pointer;
	position: fixed;
	top: 7px;
	right: 2px;
}

#effect {
	width: 500px;
	height: 135px;
	position: fixed;
	left: -200px;
	top: 48px;
	z-index: 1;
}

#effect2 {
	width: 500px;
	height: 135px;
	position: fixed;
	right: -200px;
	top: 48px;
	z-index: 1;
}

#content {
	width: 195px;
	height: 2000px;
	float: left;
	font: 18px/1.6 NanumBrushWeb;
	background: url(img/bg_slide.png);
	z-index: 1;
	margin: auto;
}

#content2 {
	width: 93px;
	height: 793px;
	float: right;
	background: url(img/background/bg_bgskin.png);
	z-index: 1;
	margin: auto;
}

#real_content {
	margin_left: 10px;
	text-align: center;
}

#bg_select_slide {
	margin_right: 10px;
	text-align: center;
}

#bar {
	position: fixed;
	left: 0px;
	top: 0px;
	z-index: 1;
}

#search {
	position: absolute;
	top: 3px;
	left: 1100px;
	z-index: 1;
}

#search_icon {
	position: absolute;
	left: 1340px;
	top: 10px;
	z-index: 1;
}

#show_content_area {
	top: 40px;
	width: 1100px;
	height: 700px;
	backgorund-color: black;
}

#bg {
	top: 40px;
	width: 1200px;
	height: 800px;
	background: url(img/background/bg_1.png)
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
				"background" : "url(img/btn_select-slide.png)"
			});
		}, function() {
			jQuery("#effect").animate({
				left : '-200px'
			}, 500);
			jQuery("#button").css({
				"background" : "url(img/btn_slide.png)"
			});
		});
	});

	jQuery(function() {
		jQuery("#bgbutton").toggle(function() {
			jQuery("#effect2").animate({
				right : 0
			}, 500);
			jQuery("#bgbutton").css({
				"background" : "url(img/background/btn_select-bgskin.png)"
			});
		}, function() {
			jQuery("#effect2").animate({
				right : '-200px'
			}, 500);
			jQuery("#bgbutton").css({
				"background" : "url(img/background/btn_bgskin.png)"
			});
		});
	});
</script>

<script src="http://connect.facebook.net/en_US/all.js"
	language="JavaScript" type="text/javascript"></script>
<script>
	//페이스북 초기화
	window.fbAsyncInit = function() {
		FB.init({
			appId : '283897015123867',
			status : true,
			cookie : true,
			xfbml : true
		});
		FB.login(function(response){
			user_id = response.authResponse.userID; //get FB UID
			document.getElementById('userID').innerHTML = ''
					+ user_id;
		});
	};
	function fb_logout() {
		FB.logout(function(response) {
			window.alert('byebye!');
			window.location.href = "";
		});
	}
</script>
<script>
	var getPage = function() {
		var url = $("#input_url").val();
		var params = "url=" + url;
		$.ajax({
			url : "GetSelectPage",
			data : "" + params
		}).done(function(data) {
			$('#page').empty();
			$('#page').append(data);
			$('#page').find("*").addClass('oleview_tag');
			console.log("getPage안쪽");
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
		console.log("add-_event 처음");
		$('.oleview_tag').mouseenter(function(event) {
			console.log("add event inside");
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

<script type="text/javascript">
	$(function() {
		$("#btn_before").click(function() {
			alert("before button!");

		});
	});

	$(function() {
		$("#btn_next").click(function() {
			var number = $("#count").text() + 1;
			var pf = parent.opener.document;
			console.log("number=" + number);
			pf.getElementById('count').innerHTML = ""
			alert("next button!");
		});
	});
	$(function() {
		$("#btn_skin1")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_1.png)";
							document.getElementById("btn_skin0").src="img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src="img/background/btn_skin1_c.png";
							document.getElementById("btn_skin2").src="img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src="img/background/btn_skin3.png";
							
							//pf.getElementById('count').innerHTML="1";
						});
	});
	$(function() {
		$("#btn_skin2")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_2.png)";
							document.getElementById("btn_skin0").src="img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src="img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src="img/background/btn_skin2_c.png";
							document.getElementById("btn_skin3").src="img/background/btn_skin3.png";
							
							//pf.getElementById('count').innerHTML="2";
						});
	});
	$(function() {
		$("#btn_skin3")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_3.png)";
							document.getElementById("btn_skin0").src="img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src="img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src="img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src="img/background/btn_skin3_c.png";
							
							//pf.getElementById('count').innerHTML="3";
						});
	});
	$(function() {
		$("#btn_skin0").click(function() {
			//var pf = parent.opener.document;
			document.getElementById("bg").style.backgroundImage = "url()";
			document.getElementById("btn_skin0").src="img/background/btn_no-skin_c.png";
			document.getElementById("btn_skin1").src="img/background/btn_skin1.png";
			document.getElementById("btn_skin2").src="img/background/btn_skin2.png";
			document.getElementById("btn_skin3").src="img/background/btn_skin3.png";
			
			//pf.getElementById('count').innerHTML="0";
		});
	});
	$(function() {
		$("#btn_skin4").click(function() {
			alert("구매 후 사용 가능합니다!");
		});
	});
</script>
</head>
<body>

	<!-- 상단 바 부분 -->
	<div id="bar">
		<img src="img/bg_bar.png" />
	</div>
	<div id="search">
		<form onsubmit="getPage(); return false;">
			<input type="text" id="input_url" name="input_url"
				style="background: url(img/bg_search1.png); background-repeat: no-repeat; width: 225px; height: 31px; border: 0px; padding-left: 6px; padding-right: 40px;">
		</form>

	</div>
	<div id="search_icon">
		<input type="image" src="img/btn_search.png" name="submit"
			align="absmiddle" border="0">
	</div>


	<!-- 좌측 슬라이드 부분 -->
	<div id="effect">
		<div id="content">
			<div id="real_content">
				<div style="float: right;">
					<a href="#" onclick="fb_logout();"><img
						src="img/btn_logout.png" border="0"></a> <br>
				</div>
				<br>
				<div style="margin: 0 auto;">
					<div style="margin-top: 15px">
						<!-- 로그인한 프로필 사진-->
						<fb:profile-pic uid="loggedinuser" size="square"></fb:profile-pic>
						<!-- 로그인한 이름 -->
						<fb:name uid="loggedinuser" use-you="no"></fb:name>
						<br>
						<div id="status"></div>
						<div onlogin="checkLoginState();" id="userID"></div>
					</div>
				</div>
			</div>
		</div>
		<div id="button">
			<p>
				<a href="#">Toggle</a>
			</p>
		</div>
	</div>

	<!-- 우측 슬라이드 부분 -->
	<div id="effect2">
		<div id="content2">
			<div id="bg_select_slide">
				<br> <Br> <br> 
				<!--  img
					src="img/background/btn_beforepage.png" id="btn_before" /> <span
					id="count">1</span> / 4 <img src="img/background/btn_nextpage.png"
					id="btn_next" /> -->
					<br> <img
					src="img/background/btn_no-skin_c.png" id="btn_skin0" /><br>
				<img src="img/background/btn_skin1.png" id="btn_skin1" /><br>
				<img src="img/background/btn_skin2.png" id="btn_skin2" /><br>
				<img src="img/background/btn_skin3.png" id="btn_skin3" /><br>
				<img src="img/background/btn_skin4.png" id="btn_skin4" />
			</div>
		</div>
		<div id="bgbutton">
			<p>
				<a href="#">Toggle</a>
			</p>
		</div>
	</div>

	<div id="page"></div>

	<br>
	<Br>
	<br>
	<Br>
	<!-- show_content_area에 내용들이 보일꺼고, 위치 수정해줘야함..시작위치가 바 부분 밑일수 있게 -->
	<div id="bg" align="center">
		<div id="show_content_area"></div>
	</div>
</body>
</html>