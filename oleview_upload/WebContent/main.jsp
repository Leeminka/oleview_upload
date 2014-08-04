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
	const STATE_PLAIN = 0;
	const STATE_EDIT = 1;
	var STATE = STATE_PLAIN;
	var contents_list = [];
	$(document).ready(function() {
		//�����ͺ��̽����� ��� ����� �������� ������
		getAllContents();

		//���� ���� (Select Page -> main ���� Query�� �Բ� �Ѿ��)
		if (isAnyQuery())
			if (makeNewFrame())
				STATE = STATE_EDIT;

		//��� �α��� �������� ����
		if (STATE == STATE_PLAIN)
			alert('���������� ȯ��');

		if (STATE == STATE_EDIT) {

		}
	});

	function makeFrame(width, height, url, dom_data, left, top, isNewFrame) {
		//���ο� DIV ����
		var draggable_div = $('<div></div>').addClass("draggable_div");
		draggable_div.width(width);
		draggable_div.height(height);
		draggable_div.css('position','absolute');
		draggable_div.css('left', left);
		draggable_div.css('top', top);
		

		//iframe ���������� ���߿� ����ϱ� ���� �Ӽ����� �� �־����
		var content1 = $('<iframe></iframe>');
		content1.width(width);
		content1.height(height);
		content1.attr('src', '/GetPage?url=' + encodeURIComponent(url)
				+ '&dom_data=' + encodeURIComponent(dom_data));
		content1.attr('scrolling', 'no');
		content1.attr('url', url);
		content1.attr('dom_data', dom_data);
		content1.addClass('content');

		//�������� DIV�� ����
		content1.appendTo(draggable_div);

		//������ ����
		var remote_div = $('<div></div>').addClass("remote_div");
		var btn_migrate = $('<img />').attr('src', 'img/main/btn_migrate.png')
				.addClass('btn_migrate remote_btn');
		var btn_crop = $('<img />').attr('src', 'img/main/btn_crop.png')
				.addClass('btn_crop remote_btn');
		var btn_delete = $('<img />').attr('src', 'img/main/btn_delete.png')
				.addClass('btn_delete remote_btn');
		var btn_save = $('<img />').attr('src', 'img/main/btn_save.png')
				.addClass('btn_save remote_btn');

		//�� ������ ��ư���� remote_div�� ����
		btn_migrate.appendTo(remote_div);
		btn_crop.appendTo(remote_div);
		btn_delete.appendTo(remote_div);
		btn_save.appendTo(remote_div);

		//save �̺�Ʈ �߰�
		btn_save.click(function() {
			//InsertDB
			if (isNewFrame)
				saveContentPosition(content1);
		});

		//remote_div�� content�� ����
		remote_div.appendTo(draggable_div);

		//�ڵ� ����
		var handle_div = $('<div></div>').addClass("handle_div");
		handle_div.width(width);
		handle_div.height(height);

		//�ڵ鿡 ���� �̹��� ����
		var handle_img = $('<img />').attr('src', 'img/main/handle_img.png')
				.addClass("handle_img");

		//�ڵ� �̹��� ������ ����
		if (width >= height) {
			handle_img.width(height * 0.5);
			handle_img.height(height * 0.5);
		} else {
			handle_img.width(width * 0.5);
			handle_img.height(width * 0.5);
		}
		//�ڵ� ��ġ ���� ����� ����
		handle_img.css("top", (height * 0.5) - (handle_img.height() * 0.5));
		handle_img.css("left", (width * 0.5) - (handle_img.width() * 0.5));

		//�ڵ� DIV�� �ڵ� img �߰�
		handle_div.append(handle_img);

		//�ڵ� DIV�� CONTENT�� �߰�
		draggable_div.append(handle_div);

		//�巡�� ����
		draggable_div.draggable({
			handle : handle_div,
			containment : "#contents_cont",
			scroll : false
		});

		//���� ���ο� �������̸� �ڵ��� �ٷ� ���̰� �ƴҰ�� �ڵ��� ����
		if (isNewFrame) {

		} else {
			handle_div.hide();
			remote_div.hide();
		}

		//DIV�� contents �����̳ʿ� ����
		draggable_div.appendTo($('#contents_cont'));
		return true;
	}

	function makeNewFrame() {
		//URL���� �Ķ���͸� �޾ƿ´�
		var width = getQueryVariable("width");
		var height = getQueryVariable("height");
		var url = getQueryVariable("url");
		var dom_data = getQueryVariable("dom_data");

		//���� �Ķ������ �ϳ��� ����ִٸ�
		if (width == '' || height == '' || url == '' || dom_data == '') {
			return false;
		}

		//������ ���� width, heigth, url, dom_data, left, top , isNewFrame
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

	//�����̳� �ȿ� �ִ� ���������� �������� ������
	function saveContentPosition(content) {
		var content_json = {};
		content_json["left"] = content.parent().position().left;
		content_json["top"] = content.parent().position().top;
		content_json["width"] = content.width();
		content_json["height"] = content.height();
		content_json["dom_data"] = content.attr("dom_data");
		content_json["url"] = content.attr("url");

		if (typeof content.attr("title") == "undefined") {
			var title = prompt("�������� ������ �Է��ϼ���", "");
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
<body>
	<div id="contents_cont">�����̳ʤ�����</div>
</body>
</html>