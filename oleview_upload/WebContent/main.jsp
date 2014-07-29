<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//String url = (String) request.getAttribute("url");
	//String dom_data = (String) request.getAttribute("dom_data");
	//String sWidth = (String) request.getAttribute("width");
	//String sHeight = (String) request.getAttribute("height");
	//int width = 0;
	//int height = 0;
	//if (sWidth != null)
	//	width = Integer.parseInt(sWidth);
	//if (sHeight != null)
	//	height = Integer.parseInt(sHeight);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Oleview</title>
<link rel="stylesheet"
	href="css/ui-lightness/jquery-ui-1.10.4.custom.min.css">
<style>
* {
	margin: 0px;
	padding: 0px;
}

.draggable_div {
	position: relative;
}

.handle {
	position: absolute;
	left: -25px;
	top: -25px;
	width: 50px;
	height: 50px;
	z-index: 10;
	cursor: move;
}

.content {
	position: absolute;
	left: 0px;
	top: 0px;
	overflow: hidden;
	z-index: 0;
}

#contents_cont {
	position: relative;
	width: 1000px;
	height: 700px;
	border: solid;
}

.container_button {
	z-index: 10;
}

#container_button_save {
	position: absolute;
	top: 0px;
	right: 100px;
	width: 60px;
	height: 30px;
}

#container_button_cancel {
	position: absolute;
	top: 0px;
	right: 20px;
	width: 60px;
	height: 30px;
}
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/jquery-ui-1.10.4.custom.min.js"></script>

<script>
	const
	STATE_PLAIN = 0;
	const
	STATE_EDIT = 1;
	var STATE = STATE_PLAIN;
	var contents_list = [];
	$(document).ready(function() {
		//데이터베이스에서 모든 저장된 컨텐츠를 가져옴
		//getAllContents();
		
		//편집 상태 (Select Page -> main 으로 Query와 함께 넘어옴)
		if (isAnyQuery())
			if (makeFrame())
				STATE = STATE_EDIT;

		//평소 로그인 했을때의 상태
		if (STATE == STATE_PLAIN)
			alert('메인페이지 환영');

		if (STATE == STATE_EDIT) {
			createSaveButton();
			createCancleButton();
		}
	});

	function createSaveButton() {
		var button = $('<button>저장</button>');
		button.addClass('container_button');
		button.attr('id', 'container_button_save');
		button.appendTo('#contents_cont');
	}
	function clickSaveButton() {
		if (isValidPosition()) {
			savePosition();
		}
	}
	function savePostion() {
		
	}
	function isValidPosition() {
		return true;
	}
	function createCancleButton() {
		var button = $('<button>취소</button>');
		button.addClass('container_button');
		button.attr('id', 'container_button_cancel');
		button.appendTo('#contents_cont');
	}
	function clickCancleButton() {

	}
	function makeFrame() {
		var width = getQueryVariable("width");
		var height = getQueryVariable("height");
		var url = getQueryVariable("url");
		var dom_data = getQueryVariable("dom_data");

		if (width == '' || height == '' || url == '' || dom_data == '') {
			return false;
		}

		//드래그 할수있는 div 생성 하고 핸들 추가
		var draggable_div = $('<div></div>').addClass("draggable_div");
		var handle_img = $('<img />').attr('src', 'img/handle_img.png')
				.addClass("handle");
		draggable_div.append(handle_img);

		var content1 = $('<iframe></iframe>');
		content1.width(width);
		content1.height(height);
		content1.attr('src', '/GetPage?url='
				+ encodeURIComponent(url) + '&dom_data='
				+ encodeURIComponent(dom_data));
		content1.attr('scrolling', 'no');
		content1.addClass('content');

		draggable_div.width(width);
		draggable_div.height(height);

		content1.appendTo(draggable_div);
		draggable_div.appendTo($('#contents_cont'));

		draggable_div.draggable({
			handle : handle_img,
			containment : "#contents_cont",
			scroll : false
		});
		return true;
	}

	function isAnyQuery() {
		var query = window.location.search.substring(1);
		if (query == '')
			return false;
		return true;
	}

	function getQueryVariable(variable) {
		var query = window.location.search.substring(1);
		var vars = query.split('&');
		for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split('=');
			if (decodeURIComponent(pair[0]) == variable) {
				return decodeURIComponent(pair[1]);
			}
		}
		return '';
	}
</script>
</head>
<body>
	<div id="contents_cont">컨테이너ㅋㅋㅋ</div>
</body>
</html>