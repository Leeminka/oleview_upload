<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oleview</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	cursor: pointer;
}
</style>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		//URL 에서 쿼리를 가져와서 전역변수인 url에 입력
		url = getQuery();
		getPage();
	});
</script>
<script>
	var url;
	var getPage = function() {
		var params = "url=" + url;
		$.ajax({
			url : "GetSelectPage",
			data : "" + params
		}).done(function(data) {
			if (data == 'fail') {
				window.location = '/main.jsp?result=fail';
			} else {
				$('#page').append(data);
			}
			add_event();
		}).fail(function() {
			alert('Fail?');
		});
		return false;
	};
</script>
<script>
	function add_event() {
		$('#page').find("*").mouseenter(function(event) {
			event.stopPropagation();
			$('#page').find("*").css('box-shadow', 'none');
			$('#page').find("*").css('background-color', 'rgba(0, 0, 0, 0)');
			$(this).css('box-shadow', '0 0 0 3px #a7cc12 inset');
			$(this).css('background-color', 'rgba(212, 255, 162, 0.6)');
		});

		//올리브 테그에 클릭이벤트 추가
		$('#page').find("*").click(
				function(event) {
					event.stopPropagation();
					
					var selected_dom = this;
					var j_selected_dom = $(this);
					
					//이벤트 제거
					$('#page').find("*").unbind('mouseenter');
					
					//Pick 버튼 생성
					var pickButton = $('<img />').attr('src','img/btn_pic.png');
					pickButton.css('position','absolute');
					pickButton.css('right','0px');
					pickButton.css('top','0px');
					pickButton.css('cursor','pointer');
					pickButton.css('z-index','1000');
					pickButton.appendTo($(this));
					
					pickButton.click(function(){
						var parentEls = "";
						//Dom Object를 반환
						parentEls = j_selected_dom.parents().map(
								function() {
									var ret = serialize_dom_data(this.tagName,
											this.id, this.className);
									return ret;
								}).get().join(",");

						var parentEls_arry = parentEls.split(",");
						parentEls_arry.reverse();
						var parentEls_str = parentEls_arry.toString();
						parentEls_str += ",";
						parentEls_str += serialize_dom_data(selected_dom.tagName, selected_dom.id,
								selected_dom.className);

						select_dom(j_selected_dom, parentEls_str);
					});
				});
	}
	function serialize_dom_data(tag_name, tag_id, tag_class) {
		var ret_str = tag_name;

		//ID가 존재하면 추가
		if (tag_id != '') {
			ret_str += "#";
			ret_str += tag_id;
		}

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

		var replace_url = "main.jsp?" + "width=" + width + "&height=" + height
				+ "&url=" + encodeURIComponent(url) + "&dom_data="
				+ encodeURIComponent(dom_data);
		//main.jsp 페이지로 이동 + 파라미터 전달
		window.location = replace_url;
	}
	function getQuery() {
		var query = window.location.search.substring(1);
		var pair = query.split('=');
		return decodeURIComponent(pair[1]);
	}
</script>

</head>
<body>
	<div id="page"></div>

</body>
</html>
