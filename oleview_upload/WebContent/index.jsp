<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oleview</title>
<style>
#page {
	box-shadow: 0 0 0 5px blue inset;
}
</style>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>

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
	var getCategory = function() {
		var userId = document.getElementById('userID').value;
		var input_value = document.getElementById('input_category').value;
		return false;
	}
</script>
</head>
<body>

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
