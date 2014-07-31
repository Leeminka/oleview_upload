<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
	position: absolute;
	border: solid;
	border-width: thin;
	border-color: rgb(167, 204, 18);
}

.remote_div {
	position: absolute;
	top: -36px;
	left: 0px;
	width: 148px;
	height: 36px;
}

.remote_btn {
	position: absolute;
	width: 37px;
	hegith: 36px;
}

#btn_migrate {
	width: 39px;
	hegith: 36px;
	left: -2px;
	top: 0px;
}

#btn_crop {
	left: 37px;
	top: 0px;
}

#btn_delete {
	left: 74px;
	top: 0px;
}

#btn_save {
	left: 111px;
	top: 0px;
}

.handle_div {
	position: absolute;
	left: 0px;
	top: 0px;
	background: rgba(167, 204, 18, 0.4);
	cursor: move;
	z-index: 10;
	cursor: move;
}

.handle_img {
	position: absolute;
	z-index: 12;
}

.content {
	position: absolute;
	left: 0px;
	top: 0px;
	overflow: hidden;
	z-index: 0;
	border: none;
	top: 0px;
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
			if (makeNewFrame())
				STATE = STATE_EDIT;

		//평소 로그인 했을때의 상태
		if (STATE == STATE_PLAIN)
			alert('메인페이지 환영');

		if (STATE == STATE_EDIT) {

		}
	});

	function makeFrame(width, height, url, dom_data, left, top, isNewFrame) {
		//새로운 DIV 생성
		var draggable_div = $('<div></div>').addClass("draggable_div").attr(
				"id", "handle");
		draggable_div.width(width);
		draggable_div.height(height);
		draggable_div.css('left', left);
		draggable_div.css('top', top);

		//iframe 컨텐츠생성 나중에 사용하기 위해 속성으로 다 넣어버려
		var content1 = $('<iframe></iframe>');
		content1.width(width);
		content1.height(height);
		content1.attr('src', '/GetPage?url=' + encodeURIComponent(url)
				+ '&dom_data=' + encodeURIComponent(dom_data));
		content1.attr('scrolling', 'no');
		content1.attr('url', url);
		content1.attr('dom_data', dom_data);
		content1.addClass('content');

		//컨텐츠를 DIV에 붙임
		content1.appendTo(draggable_div);

		//리모콘 생성
		var remote_div = $('<div></div>').addClass("remote_div");
		var btn_migrate = $('<img />').attr('src', 'img/main/btn_migrate.png')
				.attr('id', 'btn_migrate').addClass('remote_btn');
		var btn_crop = $('<img />').attr('src', 'img/main/btn_crop.png').attr(
				'id', 'btn_crop').addClass('remote_btn');
		var btn_delete = $('<img />').attr('src', 'img/main/btn_delete.png')
				.attr('id', 'btn_delete').addClass('remote_btn');
		var btn_save = $('<img />').attr('src', 'img/main/btn_save.png').attr(
				'id', 'btn_save').addClass('remote_btn');

		//각 생성된 버튼들을 remote_div에 붙임
		btn_migrate.appendTo(remote_div);
		btn_crop.appendTo(remote_div);
		btn_delete.appendTo(remote_div);
		btn_save.appendTo(remote_div);
		
		
		//save 이벤트 추가
		btn_save.click(function() {
			//InsertDB
			if (isNewFrame)
				saveContentPosition(content1);
		});

		//remote_div를 content에 붙임
		remote_div.appendTo(draggable_div);

		//핸들 생성
		var handle_div = $('<div></div>').addClass("handle_div");
		handle_div.width(width);
		handle_div.height(height);

		//핸들에 들어가는 이미지 생성
		var handle_img = $('<img />').attr('src', 'img/main/handle_img.png')
				.addClass("handle_img");
		//핸들 이미지 사이즈 생성
		if (width >= height) {
			handle_img.width(height * 0.5);
			handle_img.height(height * 0.5);
		} else {
			handle_img.width(width * 0.5);
			handle_img.height(width * 0.5);
		}
		//핸들 위치 생성 가운데에 만듬
		handle_img.css("top", (height * 0.5) - (handle_img.height() * 0.5));
		handle_img.css("left", (width * 0.5) - (handle_img.width() * 0.5));

		//핸들 DIV에 핸들 img 추가
		handle_div.append(handle_img);
		//핸들 DIV를 CONTENT에 추가
		draggable_div.append(handle_div);

		//드래그 가능
		draggable_div.draggable({
			handle : handle_div,
			containment : "#contents_cont",
			scroll : false
		});

		//만약 새로운 프레임이면 핸들을 바로 보이게 아닐경우 핸들을 숨김
		if (isNewFrame) {

		} else {
			handle_div.hide();
			remote_div.hide();
		}

		//DIV를 contents 컨테이너에 붙임
		draggable_div.appendTo($('#contents_cont'));
		return true;
	}

	function makeNewFrame() {
		//URL에서 파라미터를 받아온다
		var width = getQueryVariable("width");
		var height = getQueryVariable("height");
		var url = getQueryVariable("url");
		var dom_data = getQueryVariable("dom_data");

		//만약 파라미터중 하나라도 비어있다면
		if (width == '' || height == '' || url == '' || dom_data == '') {
			return false;
		}

		//프레임 생성 width, heigth, url, dom_data, left, top , isNewFrame
		if (makeFrame(width, height, url, dom_data, 0, 0, true))
			return true;
		return false;
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

	//컨테이너 안에 있는 컨텐츠들의 포지션을 저장함
	function saveContentPosition(content) {
		var content_json = {};
		content_json["left"] = content.offset().left;
		content_json["top"] = content.offset().top;
		content_json["width"] = content.width();
		content_json["height"] = content.height();
		content_json["dom_data"] = content.attr("dom_data");
		content_json["url"] = content.attr("url");
		
		if (typeof content.attr("title") == "undefined") {
			var title = prompt("컨텐츠의 제목을 입력하세요", "");
			if (title == null) {
				return false;
			}
			content_json["title"] = title;
		}else{
			content_json["title"] = content.attr("title");
		}

		$.ajax({
			url : "/InsertContent",
			type : "post",
			data : "jData=" + JSON.stringify(content_json)
		}).done(function(data) {
			alert(data);
		}).fail(function(error) {
			alert("fail");
			alert(JSON.stringify(error));
			return false;
		});

		return true;
	}
</script>
</head>
<body>
	<div id="contents_cont">컨테이너ㅋㅋㅋ</div>
</body>
</html>