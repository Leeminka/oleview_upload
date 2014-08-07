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
	border-width: 1px; 
	border-color: rgb(167,204,18); 
	border-style: solid;
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

.btn_migrate {
	width: 39px;
	hegith: 36px;
	left: -2px;
	top: 0px;
}

.btn_crop {
	left: 37px;
	top: 0px;
}

.btn_delete {
	left: 74px;
	top: 0px;
}

.btn_save {
	left: 111px;
	top: 0px;
}

.handle_div {
	position: absolute;
	left: 0px;
	top: 0px;
	background: rgba(167, 204, 18, 0.3);
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
.clip_div {
	position: absolute;
	top: -31px;
	left: -1px;
	height: 31px;
	background: rgb(191,221,67);
}
.btn_setting {
	position: absolute;
	top: 0px;
	left: 0px;
	height: 31px;
	width: 41px;
}
.btn_reflash {
	position: absolute;
	top: 0px;
	right: 34px;
	height: 31px;
	width: 31px;
}
.btn_new {
	position: absolute;
	top: 0px;
	right: -2px;
	height: 31px;
	width: 36px;
}

.btn_x {
	position: absolute;
	top: 37px;
	right: -37px;
	height: 37px;
	width: 37px;
}
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/jquery-ui-1.10.4.custom.min.js"></script>
<script>
	const STATE_PLAIN = 0;
	const STATE_EDIT = 1;
	var STATE = STATE_PLAIN;
	var contents_list = [];
	$(document).ready(function() {
		//데이터베이스에서 모든 저장된 컨텐츠를 가져옴
		getAllContents();

		//편집 상태 (Select Page -> main 으로 Query와 함께 넘어옴) - serch
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
		var draggable_div = $('<div></div>').addClass("draggable_div");
		draggable_div.width(width);
		draggable_div.height(height);
		draggable_div.css('position','absolute');
		draggable_div.css('left', left);
		draggable_div.css('top', top);

		//iframe 컨텐츠생성 나중에 사용하기 위해 속성으로 다 넣어버려
		var content1 = $('<iframe></iframe>');
		content1.width(width);
		content1.height(height);
		content1.attr('src', '/oleview_upload/testGetPage?url=' + encodeURIComponent(url)
				+ '&dom_data=' + encodeURIComponent(dom_data));
		content1.attr('scrolling', 'no');
		content1.attr('url', url);
		content1.attr('dom_data', dom_data);
		content1.addClass('content');

		//컨텐츠를 DIV에 붙임
		content1.appendTo(draggable_div);

		//리모콘 생성
		var remote_bar = 0;	//0이믄 리모콘이 있습니다 1이믄 리모콘이 있지 않습니다	
		var remote_div = $('<div></div>').addClass("remote_div");
		var btn_migrate = $('<img />').attr('src', 'img/main/btn_migrate.png')
				.addClass('btn_migrate remote_btn');
		var btn_crop = $('<img />').attr('src', 'img/main/btn_crop.png')
				.addClass('btn_crop remote_btn');
		var btn_delete = $('<img />').attr('src', 'img/main/btn_delete.png')
				.addClass('btn_delete remote_btn');
		var btn_save = $('<img />').attr('src', 'img/main/btn_save.png')
				.addClass('btn_save remote_btn');

		//각 생성된 버튼들을 remote_div에 붙임
		btn_migrate.appendTo(remote_div);
		btn_crop.appendTo(remote_div);
		btn_delete.appendTo(remote_div);
		btn_save.appendTo(remote_div);

		//save 이벤트 추가
		btn_save.click(function() {
			handle_div.hide();	remote_div.hide();
			remote_bar = 1;

			//InsertDB		
			/* if (isNewFrame)
				saveContentPosition(content1);  */
		});

		//remote_div를 content에 붙임
		remote_div.appendTo(draggable_div);

		//핸들 생성
		var handle_div = $('<div></div>').addClass("handle_div");
		handle_div.width(width);
		handle_div.height(height);

		//핸들에 들어가는 이미지 생성
		var handle_img = $('<img />').attr('src', 'img/main/handle_img.png').addClass("handle_img");

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

		//클립바 생성
		var clip_div = $('<div></div>').addClass("clip_div");
		var btn_setting = $('<img />').attr('src', 'img/main/btn_clip-setting.png')
				.addClass('btn_setting');
		var btn_reflash = $('<img />').attr('src', 'img/main/btn_clip-reflash.png')
				.addClass('btn_reflash');
		var btn_new = $('<img />').attr('src', 'img/main/btn_clip-new.png')
				.addClass('btn_new');

		//클립바 속성 설정
		clip_div.width(width);

		//클립바 어펜드어펜드
		btn_setting.appendTo(clip_div);	
		btn_reflash.appendTo(clip_div);	
		btn_new.appendTo(clip_div);
		clip_div.appendTo(draggable_div);

		clip_div.hide();	//첨에는 클립바를 숨기고 리모컨바를 보여줘야해

		//만약 새로운 프레임이면 핸들을 바로 보이게 아닐경우 핸들을 숨김
		if (isNewFrame) {

		} else {
			handle_div.hide();
			remote_div.hide();
		}

		//DIV를 contents 컨테이너에 붙임
		//컨테이너는 한 화면을 넘어가지 않습니다 그래서 스크롤도 숨김니다
		$('#contents_cont').width(window.innerWidth);
		$('#contents_cont').height(window.innerHeight);
		draggable_div.appendTo($('#contents_cont'));

		//iframe 위에 커서를 올리믄 바가 나와용 위에 없으면 바가 없어져용
		$(this).mousemove(function(event) {
			var div_top = content1.offset().top;
			var div_left = content1.offset().left;
			var pointX = event.clientX + document.body.scrollLeft;	//커서x좌표
			var pointY = event.clientY + document.body.scrollTop;	//커서y좌표

			if (remote_bar==1)
			{
				if ((div_top-31<pointY) && (pointY<div_top) && (div_left<pointX) && (pointX<div_left+Number(width)))
				{
					clip_div.show();
				}
				else
				{	
					clip_div.hide();
				}	
			}
		});

		//클립바에서 setting 버튼을 누르면 리모컨이 나옵니다
		btn_setting.click(function() {
			handle_div.show();	remote_div.show();
			remote_bar = 0;
			clip_div.hide();
		});

		//클립바에서 reflash 버튼을 누르면 새로고침이 됩니다
		btn_reflash.click(function() {
			content1.contentDocument.location.reload(true);
		});

		//클립바에서 new 버튼을 누르면 해당 프레임의 url로 새창을 엽니다
		btn_new.click(function() {
			window.open("http://" + url);

			/* content1.animate({width: '1303px', height: '721px', top: '20px', left: '20px'}, 300);
			var btn_x = $('<img />').attr('src', 'img/main/btn_x.png').addClass('btn_x');
			btn_x.appendTo(content1); */

		});

		//delete 이벤트 추가
		btn_delete.click(function() {
			remote_div.hide();	handle_div.hide();	draggable_div.hide();
			//db에서 content 삭제 
		});

		//crop 이벤트 추가
		btn_crop.click(function() {
			remote_div.hide();	handle_div.hide();	draggable_div.hide();
			//db에서 content 삭제 

			//주소만 똑같게 해서 index.jsp 복붙
		});

		btn_migrate.click(function() {

		});

		return true;
	}

	//iframe 내에서 링크를 하믄 크기가 커져용 팝업팝업
	//자식프레임에서 호출할끄얌
	function wide_frame(title){
		  alert(title);
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
		content_json["left"] = content.parent().position().left;
		content_json["top"] = content.parent().position().top;
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
		} else {
			content_json["title"] = content.attr("title");
		}

		$.ajax({
			url : "/InsertContent",
			type : "post",
			data : "jData=" + JSON.stringify(content_json)
		}).done(function(data) {
			if (data.result == "success") {
				content.parent().find('.handle_div').hide();
				content.parent().find('.remote_div').hide();
			} else if (data.result == "fail") {
				alert("data result : fail");
			}
		}).fail(function(error) {
			alert("main save Content ajax error");
			alert(JSON.stringify(error));
			return false;
		});
		return true;
	}
	function getAllContents() {
		$.ajax({
			url : "/GetContents",
			type : "Get"
		}).done(
				function(data) {
					for ( var i in data) {
						makeFrame(data[i].width, data[i].height, data[i].url,
								data[i].dom_data, data[i].left, data[i].top,
								false);
					}
				}).fail(function(error) {
			alert("main get Contents ajax error");
			alert(JSON.stringify(error));
			return false;
		});
	}
</script>
</head>
<body style="overflow-x:hidden; overflow-y:hidden">


	<div id="contents_cont"></div>
</body>
</html>