<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
	border-width: 3px;
	border-color: rgb(167, 204, 18);
	border-style: solid;
}

.remote_div {
	position: absolute;
	top: -36px;
	left: 2px;
	width: 148px;
	height: 36px;
}

.remote_btn {
	position: absolute;
	width: 37px;
	hegith: 36px;
}

.btn_delete {
	width: 37px;
	hegith: 36px;
	left: -2px;
	top: 36px;
	position: absolute;
	z-index: 15;
}

.btn_save {
	width: 37px;
	hegith: 36px;
	left: 66px;
	top: 36px;
	position: absolute;
	z-index: 15;
}

.btn_save_clip {
	width: 37px;
	hegith: 36px;
	left: 35px;
	top: 36px;
	position: absolute;
	z-index: 15;
}

.btn_clip {
	width: 33px;
	hegith: 36px;
	left: 34px;
	top: 36px;
	position: absolute;
	z-index: 15;
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
	background-color: rgb(255, 255, 255);
}

#contents_cont {
	top: 50%;
	left: 50%;
	margin: -350px 0 0 -740px;
	position: absolute;
	width: 1480px;
	height: 710px;
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
	z-index: 10;
	top: -31px;
	left: 4px;
	height: 31px;
	background: rgb(191, 221, 67);
}

.btn_setting {
	position: absolute;
	z-index: 10;
	top: 0px;
	left: -7px;
	height: 31px;
	width: 41px;
}

.btn_reflash {
	position: absolute;
	z-index: 10;
	top: 0px;
	right: 35px;
	height: 31px;
	width: 31px;
}

.btn_new {
	position: absolute;
	z-index: 10;
	top: 0px;
	right: 1px;
	height: 31px;
	width: 36px;
}

.toggler {
	width: 500px;
	height: 200px;
	position: relative;
}

#button {
	/*버튼 이미지 사이즈 만큼*/
	width: 37px;
	height: 33px;
	background: url(img/btn_slide.png);
	text-indent: -9999px;
	cursor: pointer; /*버튼위에 마우스 올리면 손가락 모양으로!*/
	position: fixed;
	top: 7px;
	left: 2px;
	display: block;
}

#bgbutton {
	float: right;
	width: 35px;
	height: 36px;
	background: url(img/background/btn_bgskin.png);
	text-indent: -9999px;
	cursor: pointer;
	position: fixed;
	top: 7px;
	right: 2px;
}

#effect {
	width: 600px;
	height: 135px;
	position: fixed;
	left: -250px;
	top: 48px;
	z-index: 1;
}

#effect2 {
	width: 500px;
	height: 135px;
	position: fixed;
	right: 0%;
	top: -700px;
	z-index: 1;
}

#left_slide_content {
	width: 243px;
	height: 793px;
	float: left;
	font: 18px/1.6 NanumBrushWeb;
	background: url(img/bg_slide.png);
	z-index: 1;
	margin: auto;
}

#right_slide_content {
	width: 93px;
	height: 550px;
	float: right;
	background: transparent;
	z-index: 1;
	margin: auto;
}

#left_slide_real_content {
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
	width: 100%;
	height: 48px;
	background-color: rgb(167, 204, 18);
	z-index: 1;
}

#search {
	position: fixed;
	top: 7px;
	right: 50px;
	z-index: 1;
}

#search_icon {
	position: fixed;
	top: 15px;
	right: 87px;
	z-index: 1;
	cursor: pointer;
}

#bg {
	position: absolute;
	text-align: center;
	left: 50%;
	top: 50%;
	margin: -400px auto 0 -600px;
	width: 1200px;
	height: 800px;
	background: url(img/background/bg_1.png)
}

.btn_x {
	position: absolute;
	top: -4px;
	right: -37px;
	height: 37px;
	width: 37px;
	z-index: 10;
}

.fb_link {
	color: rgb(131, 166, 30);
	text-decoration: none;
	font-weight: bold;
}

.fb_link:active {
	color: rgb(131, 166, 30);
	text-decoration: none;
	font-weight: bold;
}

.fb_link:visited {
	color: rgb(131, 166, 30);
	text-decoration: none;
	font-weight: bold;
}

#make_icon {
	position: fixed;
	top: 15px;
	right: 62px;
	z-index: 1;
}
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/jquery-ui-1.10.4.custom.min.js"></script>


<script> </script>
<script>
window.history.forward(0);
	const
	STATE_PLAIN = 0;
	const
	STATE_EDIT = 1;
	var STATE = STATE_PLAIN;
	var contents_list = [];
	$(document).ready(function() {
		//컨테이너 사이즈 ->절대값으로 바꿈 이거 필요없음
		//$('#contents_cont').width(window.innerWidth);
		//$('#contents_cont').height(window.innerHeight - 48);
		
		//데이터베이스에서 모든 저장된 컨텐츠를 가져옴
		getAllContents();

		//데이터베이스에서 카테고리 이름을 가져옴
		getAllCategory();

		//편집 상태 (Select Page -> main 으로 Query와 함께 넘어옴) - serch
		if (isAnyQuery()){
			if (makeNewFrame()){
				STATE = STATE_EDIT;
			}else if(makeAlertDiv()){
				
			}
		}

		//평소 로그인 했을때의 상태 
		if (STATE == STATE_PLAIN) {
			//카테고리 눌렀는지안눌렀는지까지 나눠야지!
			document.getElementById("search").style.display = "block";
		}

		if (STATE == STATE_EDIT) {

		}
		
		 /* $(document).keydown(function(e){   
		        if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){       
		            if(e.keyCode === 8){   
		            return false;
		            }
		        }
		 }); */
		 
		
		    /* $(window).keyup(function (e) {
		        // 발생한 이벤트에서 키 코드 추출, BackSpace 키의 코드는 8
		        if (e.keyCode == 8) {
		            // 다른 함수 호출
		            alert("ee");
		            // 기존 키의 기능은 무력화
		            return false;
		        }
		    }); */
	});
	
	//0이면 remote_bar / 1이믄 clip_bar
	var toggle_bar;

	function makeFrame(width, height, url, dom_data, title, left, top,
			isNewFrame) {
		//새로운 DIV 생성
		var draggable_div = $('<div></div>').addClass("draggable_div");
		draggable_div.width(width);
		draggable_div.height(height);
		draggable_div.css('position', 'absolute');
		draggable_div.css('left', left);
		draggable_div.css('top', top);

		var content1;
		if (dom_data != null) {
			//iframe 컨텐츠생성 나중에 사용하기 위해 속성으로 다 넣어버려
			content1 = $('<iframe></iframe>');
			content1.attr('src', '/GetPage?url=' + encodeURIComponent(url)
					+ '&dom_data=' + encodeURIComponent(dom_data) + '&title='
					+ encodeURIComponent(title));
			content1.attr('scrolling', 'no');
			
		} else { //make icon

			//색 랜덤지정
			var back_name=String("url(img/link/bg_2.png");
			var number=Math.floor(Math.random() * 6);
			switch(number){
			case 0:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_0.png)').css(
						'cursor', 'pointer');
				break;
			case 1:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_1.png)').css(
						'cursor', 'pointer');
				break;
			case 2:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_2.png)').css(
						'cursor', 'pointer');
				break;
			case 3:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_3.png)').css(
						'cursor', 'pointer');
				break;
			case 4:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_4.png)').css(
						'cursor', 'pointer');
				break;
			case 5:
				content1 = $('<div></div>').css('background', 'url(img/link/bg_5.png)').css(
						'cursor', 'pointer');
				break;
			}
			
		//타이틀 글자 수정
			var title_val = $('<p></p>');
			var brtag = document.createElement('br');
			var brtag2 = document.createElement('br');
			var brtag3 = document.createElement('br');
			
			title_val=$('<b></b>').css('color', 'white').text(title);
			content1.append(brtag);
			content1.append(brtag2);
			content1.append(brtag3);
			
			content1.append(title_val);
			content1.click(function() {
				show_frame(title, url);
			});
			draggable_div.css('border-color', 'rgba(255, 255, 255, 0)');
		}
		
		//remote bar - delete & clip & save
		var remote_div = $('<div></div>').addClass("remote_div");
		var btn_delete = $('<img />').attr('src', 'img/main/btn_delete.png')
				.addClass('btn_delete remote_btn');
		var btn_save = $('<img />').attr('src', 'img/main/btn_save.png')
				.addClass('btn_save remote_btn');
		var btn_clip = $('<img />').attr('src', 'img/main/clip.jpg')
				.addClass('btn_clip remote_btn');

		//각 생성된 버튼들을 remote_div에 붙임
		btn_delete.appendTo(remote_div);
		btn_save.appendTo(remote_div);
		btn_clip.appendTo(remote_div);
		
		if(dom_data == null){
			btn_clip.hide();
			btn_save.css('left','34px');
		}
		
		content1.width(width);
		content1.height(height);
		content1.attr('url', url);
		content1.attr('title', title);
		content1.attr('dom_data', dom_data);
		content1.addClass('content');

		//컨텐츠를 DIV에 붙임
		content1.appendTo(draggable_div);

		//컨텐츠와 div에 id 만듬
		content1.attr('id', 'ifr_' + title); //iframe에 고유 id를 만들어죠
		draggable_div.attr('id', "div_" + title); //div에 고유 id를 만들어죠

		//remote _save 이벤트 추가
		btn_save.click(function() {
			//겹치는곳 체크
			if (!isValidPosition(draggable_div)) {
				draggable_div.css('border-color', 'rgb(255, 0, 0)');
				return;
			}else{
				if(dom_data != null)
					draggable_div.css('border-color', 'rgb(167, 204, 18)');
				else
					draggable_div.css('border-color', 'rgba(255, 255, 255,0)');
			}
			handle_div.hide();
			remote_div.hide();
			toggle_bar = 1;
			//InsertDB		
			if (isNewFrame) {
				saveContentPosition(content1);
				//window.location.reload();
			}
			//SaveDB
			else {
				var para_top = content1.parent().position().top;
				var para_left = content1.parent().position().left;

				$.ajax({
					url : "/SaveContent",
					type : "Get",
					data : {
						"para_data" : title,
						"para_top" : para_top,
						"para_left" : para_left,
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					}
				});

			}
	
			return;
			
		});

		//delete 이벤트 추가
		btn_delete.click(function() {  
			var popOptions = "dialogWidth: 506px; dialogHeight: 275px; center: yes; resizable: yes; status: no; scroll: no;"; 
			var pop = window.showModalDialog("delete_popup.jsp", "",  popOptions ); 
			
			if (pop) {
				draggable_div.remove();
				toggle_bar = 1;
				$.ajax({
					url : "/DelectContent",
					type : "Get",
					data : {
						"para_data" : title
					},
					error : function(request, status, error) {
						alert("delete code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					} 
				});
			}
		});

		//remote bar_clip event
		btn_clip.click(function() {
			
			//create new icon
			$.ajax({
				url : "/SaveIcon",
				type : "Get",
				data : {
					"para_data" : title,
					"para_width" : 108,
					"para_height" : 108,
				},
				success : function (data) {
					location.href="main.jsp";
				},
				error : function(request, status, error) {
					alert("saveicon code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
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
		if (handle_img.width() > 60)
			handle_img.width(60);
		if (handle_img.height() > 60)
			handle_img.height(60);

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
			scroll : false,
			drag: function(){positionChecker(draggable_div);}
		});
	
		//클립바 생성
		var clip_div = $('<div></div>').addClass("clip_div");
		var btn_setting = $('<img />').attr('src',
				'img/main/btn_clip-setting.png').addClass('btn_setting');
		var btn_reflash = $('<img />').attr('src',
				'img/main/btn_clip-reflash.png').addClass('btn_reflash');
		var btn_new = $('<img />').attr('src', 'img/main/btn_clip-new.png')
				.addClass('btn_new');

		//클립바 속성 설정
		clip_div.width(width);

		//클립바 어펜드어펜드
		btn_setting.appendTo(clip_div);

		if (dom_data != null) {
			btn_reflash.appendTo(clip_div);
			btn_new.appendTo(clip_div);
		}
		clip_div.appendTo(draggable_div);

		//클립바에서 setting 버튼을 누르면 리모컨이 나옵니다
		btn_setting.click(function() {
			handle_div.show();
			remote_div.show();
			toggle_bar = 0;
			clip_div.hide();
		});

		//클립바에서 reflash 버튼을 누르면 새로고침이 됩니다
		btn_reflash.click(function() {
			document.getElementById('ifr_' + title).contentDocument.location.reload(true);
		});

		//클립바에서 new 버튼을 누르면 해당 프레임의 url로 새창을 엽니다
		btn_new.click(function() {
			if (url.toLowerCase().indexOf("http://") == -1) {
				window.open("http://" + url);
			} else
				window.open(url);
		});

		if (isNewFrame) { //새 프레임의 경우
			toggle_bar = 0;
			clip_div.hide();
		} else { //저장되어 있는 프레임의 경우
			toggle_bar = 1;
			handle_div.hide();
			remote_div.hide();
		}

		//DIV를 contents 컨테이너에 붙임
		//컨테이너는 한 화면을 넘어가지 않습니다 그래서 스크롤도 숨김니다
		draggable_div.appendTo($('#contents_cont'));

		//iframe 위에 커서를 올리믄 바가 나와용 위에 없으면 바가 없어져용
		 $(document).mousemove(
				function(event) {
					var div_top = content1.offset().top;
					var div_left = content1.offset().left;
					var pointX = event.clientX + document.body.scrollLeft; //커서x좌표
					var pointY = event.clientY + document.body.scrollTop; //커서y좌표

					if (toggle_bar == 1) {
						if ((div_top - 31 < pointY) && (pointY < div_top)
								&& (div_left < pointX)
								&& (pointX < div_left + Number(width))) {
							clip_div.show();
							if(dom_data == null)
							draggable_div.css('border-color', 'rgb(167, 204, 18)');
						} else {
							clip_div.hide();
							if(dom_data == null)
							draggable_div.css('border-color', 'rgba(0, 0, 0,0)');
						}
					}
				}); 
		return true;
	}
	
	function positionChecker(content){
		if(isValidPosition(content)){
			content.css('border-color', 'rgb(167, 204, 18)');
		}else{
			content.css('border-color', 'rgb(255, 0, 0)');
		}
	}
	
	//겹치는거 체크 함수
	function isValidPosition(content) {
		var ret_val = true;
		var cont_width = content.width();
		var cont_height = content.height();
		var cont_top = content.position().top;
		var cont_left = content.position().left;
		var cont_right = cont_left + cont_width;
		var cont_bottom = cont_top + cont_height;
		
		var container = $('#contents_cont');
		var contents = container.children();
		contents.each(function(i) {
			if(content.attr('id') == $(this).attr('id')){
				return true;
			}
			var tmp_width = $(this).width();
			var tmp_height =  $(this).height();
			var tmp_top =  $(this).position().top;
			var tmp_left = $(this).position().left;
			var tmp_right = tmp_left + tmp_width;
			var tmp_bottom = tmp_top + tmp_height;
			
			if(cont_left < tmp_right &&
					cont_top < tmp_bottom &&
					cont_right > tmp_left &&
					cont_bottom > tmp_top){
				ret_val = false;
				return false;
			}
		});
		return ret_val;
	}

	var zindex = 20;

	//click on icon, create iframe and wide 
	function show_frame(title, url) {
		//원본 position 저장
		var div_top = $("#ifr_" + title).parent().position().top;
		var div_left = $("#ifr_" + title).parent().position().left;
		var div_width = $("#ifr_" + title).width();
		var div_height = $("#ifr_" + title).height();
		var div_url = url;
		
		if (url.toLowerCase().indexOf("http://") == -1) 
			div_url = "http://" + url;

		var open_frame = $('<iframe></iframe>');
		open_frame.attr('id', 'open_frame');
		open_frame.attr('src', div_url);
		open_frame.appendTo($("#div_" + title));
		
		$("#div_" + title).css('background-color', 'rgb(167, 204, 18)');
		
		//wide 애니메이션
		$("#div_" + title).animate({
			width : '1300px',
			height : '670px',
			top : '40px',
			left : '100px'
		}, 300);
		$("#open_frame").animate({
			width : '1300px',
			height : '670px'
		}, 300);

		zindex = zindex + 1;
		$("#div_" + title).css('zIndex', zindex); //맨 앞으로  
		$("#open_frame").css('border', 'none');
		$("#open_frame").css('background-color', 'rgb(255, 255, 255)');
		$("#open_frame").attr('scrolling', 'yes'); //scroll on
		
		//hide icon img
		$("#ifr_" + title).css('width', 1);
		$("#ifr_" + title).css('height', 1);
		
		//닫기(x) 버튼
		var btn_x = $('<img />').attr('src', 'img/main/btn_x.png').addClass(
				'btn_x');
		btn_x.appendTo($("#div_" + title));

		//clip var 안나오게 
		$("#div_" + title).find('.clip_div').hide();
		toggle_bar = 2;
		
		//hide 'p' tag
		$("#div_" + title).find('p').hide();
		
		//닫기(x)	 버튼을 누르면 창이 원상태로 되돌아가지요
		btn_x.click(function() {
			$("#div_" + title).animate({
				width : '108px',
				height : '108px',
				top : div_top,
				left : div_left,
			}, 300);
			$("#open_frame").animate({
				width : '108px',
				height : '108px'
			}, 300);
			
			$("#open_frame").attr('src', div_url);
			$("#open_frame").attr('scrolling', 'no'); //scroll off
			$("#div_" + title).find('p').show();
			$("#ifr_" + title).css('width', div_width);
			$("#ifr_" + title).css('height', div_height);
			$("#open_frame").css('zIndex', '20'); 
			
			btn_x.remove();
			open_frame.remove();
			toggle_bar = 1;
			$("#div_" + title).css('background-color', 'rgba(255, 255, 255,0)');
			return true;
		});
	}

	//iframe 내에서 링크를 하믄 크기가 커져용 팝업팝업
	function wide_frame(title) {
		//원본 position 저장
		var div_top = $("#ifr_" + title).parent().position().top;
		var div_left = $("#ifr_" + title).parent().position().left;
		var div_width = $("#ifr_" + title).width();
		var div_height = $("#ifr_" + title).height();
		var div_url = $("#ifr_" + title).attr('src');

		//wide 애니메이션
		$("#div_" + title).animate({
			width : '1300px',
			height : '670px',
			top : '40px',
			left : '100px'
		}, 300);
		$("#ifr_" + title).animate({
			width : '1300px',
			height : '670px'
		}, 300);

		zindex = zindex + 1;
		$("#div_" + title).css('zIndex', zindex); //맨앞으로
		$("#ifr_" + title).attr('scrolling', 'yes'); //scroll on
		
		//닫기(x) 버튼
		var btn_x = $('<img />').attr('src', 'img/main/btn_x.png').addClass(
				'btn_x');
		btn_x.appendTo($("#div_" + title));

		//clip var 안나오게 
		$("#div_" + title).find('.clip_div').hide();
		toggle_bar = 2;
		
		//닫기(x)	 버튼을 누르면 창이 원상태로 되돌아가지요
		btn_x.click(function() {
			$("#div_" + title).animate({
				width : div_width,
				height : div_height,
				top : div_top,
				left : div_left,
			}, 300);
			$("#ifr_" + title).animate({
				width : div_width,
				height : div_height
			}, 300);
			btn_x.remove();
			$("#ifr_" + title).attr('src', div_url);
			$("#ifr_" + title).attr('scrolling', 'no'); //scroll off
			$("#div_" + title).css('zIndex', '20');
			toggle_bar = 1;
			
			return true;
		});
	}

	function makeNewIcon() {
		var url = $('#input_url').val();
		$('#input_url').val('');
		var popOptions = "dialogWidth: 506px; dialogHeight: 254px; center: yes; resizable: yes; status: no; scroll: no;"; 
		var title = window.showModalDialog("title_popup.jsp", "",  popOptions ); 
		
		if (title == "cancel_oleview")
			return true;
		else if (title == "")
			alert("title을 입력하세요");
		else if (makeFrame(108, 108, url, null, title, 0, 0, true))
			return true;

		return false;
	}

	function makeAlertDiv(){
		var result = getQueryVariable("result");
		var url = getQueryVariable("url");
		if(result == ''|| url ==''){
			return false;
		}else if(result == 'fail'){
			var alertDiv = $('<div></div>').width(window.innerWidth).height(window.innerHeight - 48);
			alertDiv.css('position','absolute');
			alertDiv.css('left','0px');
			alertDiv.css('top','48px');
			alertDiv.css('z-index','1000');
			
			var backgroundDiv = $('<div></div>').css('width','100%').css('height','100%');
			backgroundDiv.css('position','absolute');
			backgroundDiv.css('background-color','rgba(0, 0, 0, 0.5)');
			backgroundDiv.appendTo(alertDiv);
			
			var alertIcon = $('<img />').attr('src','img/alert/wrong_url_alert_icon.png');
			alertIcon.css('position','absolute');
			alertIcon.css('left','230px');
			alertIcon.css('top','230px');
			alertIcon.appendTo(alertDiv);
			
			var alertText = $('<p> </p>');
			alertText = $('<b></b>').css('color', 'white').css('font-size','32px').text(url);
			alertText.css('position','absolute');
			alertText.css('left','720px');
			alertText.css('top','380px');
			alertText.appendTo(alertDiv);
			
			var exitIcon = $('<img />').attr('src','img/alert/wrong_url_alert_exit.png');
			exitIcon.css('position','absolute');
			exitIcon.css('right','30px');
			exitIcon.css('top','30px');
			exitIcon.css('cursor','pointer');
			
			exitIcon.click(function(){
				alertDiv.remove();
			});
			
			exitIcon.appendTo(alertDiv);
			alertDiv.appendTo('body');
		}
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
		
		var popOptions = "dialogWidth: 506px; dialogHeight: 254px; center: yes; resizable: yes; status: no; scroll: no;"; 
		var title = window.showModalDialog("title_popup.jsp", "",  popOptions ); 	
	
		if (title == "cancel_oleview")
			return true;
		else if (title == "")
			alert("title을 입력하세요");
		else if (makeFrame(width, height, url, dom_data, title, 0, 0, true))
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
		for ( var i = 0; i < vars.length; i++) {
			var pair = vars[i].split('=');
			if (decodeURIComponent(pair[0]) == variable) {
				console.log(pair[1]);
				return decodeURIComponent(pair[1]);
			}
		}
		return '';
	}

	//컨테이너 안에 있는 컨텐츠들의 포지션을 저장함
	function saveContentPosition(content) {
		var content_json = {};
		content_json["left"] = parseInt(content.parent().position().left);
		content_json["top"] = parseInt(content.parent().position().top);
		content_json["width"] = content.width();
		content_json["height"] = content.height();
		content_json["dom_data"] = content.attr("dom_data");
		content_json["url"] = content.attr("url");
		content_json["title"] = content.attr("title");

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
	}
	function getAllContents() {
		$.ajax({
			url : "/GetContents",
			type : "Get"
		}).done(
				function(data) {
					for ( var i in data) {
						makeFrame(data[i].width, data[i].height, data[i].url,
								data[i].dom_data, data[i].title, data[i].left,
								data[i].top, false);
					}
				}).fail(function(error) {
			alert("main get Contents ajax error");
			alert(JSON.stringify(error));
			return false;
		});
	}
</script>

<script>
	//카테고리 불러오는데 필요한것들!
	function getAllCategory() {
		$
				.ajax({
					url : "/GetCategory",
					type : "Get"
				})
				.done(
						function(data) {
							if (data.length == 3)
								document.getElementById("category_add_btn").src = "img/left_slide/btn_hold-list.png";
							for ( var i in data) {
								//category 삭제와 수정하는데 필요한 쓰래기들 ㅠㅠㅠ
								showCategory(data[i].title);
								var j = Number(i) + 1;
								var divID = String("category");
								divID += j;
								document.getElementById('' + divID).style.display = "block";

								var hiddenDivID = divID + "hidden";
								var hiddenDivID_ = divID + "hidden_";
								var hiddenDivID__ = divID + "hidden__";
								document.getElementById('' + divID).value = ''
										+ data[i].title;
								document.getElementById('' + hiddenDivID).value = ''
										+ data[i].title;
								document.getElementById('' + hiddenDivID_).value = ''
										+ data[i].title;
								document.getElementById('' + hiddenDivID_).innerHTML = ''
										+ data[i].title;
								document.getElementById('' + hiddenDivID__).value = ''
										+ data[i].title;

								var deletebtn = String("category_");
								deletebtn += j;
								deletebtn += "_delete_btn";
								document.getElementById('' + deletebtn).style.display =

								"block";

								var editbtn = String("category_");
								editbtn += j;
								editbtn += "_edit_btn";
								document.getElementById('' + editbtn).style.display = "block";

								//alert("" + data[i].title + ", " + divID);
							}
						}).fail(function(error) {
					alert("main get Categorys ajax error");
					alert(JSON.stringify(error));
					return false;
				});
	}
	function showCategory(name) {

	}
</script>

<script type="text/javascript">
	//좌측 슬라이드에 필요한 script
	var left_toggle_flag = true;
	$(function() {
		$("#button").click(function() {
			if (left_toggle_flag) {
				$("#effect").animate({
					left : 0
				}, 500);
				$("#button").css({
					"background" : "url(img/btn_select-slide.png)"
				});
				left_toggle_flag = false;
			} else {
				$("#effect").animate({
					left : '-250px'
				}, 500);
				$("#button").css({
					"background" : "url(img/btn_slide.png)"
				});
				left_toggle_flag = true;
			}
		});
	});

	//우측 슬라이드 필요한 script
	var right_toggle_flag = true;
	$(function() {
		$("#bgbutton").click(function() {
			if (right_toggle_flag) {
				$("#effect2").animate({
					top : '48px'
				}, 500);
				$("#bgbutton").css({
					"background" : "url(img/background/btn_bgskin.png)"
				});
				right_toggle_flag = false;
			} else {
				$("#effect2").animate({
					top : '-700px'
				}, 500);
				$("#bgbutton").css({
					"background" : "url(img/background/btn_bgskin.png)"
				});
				right_toggle_flag = true;
			}
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
		FB.getLoginStatus();
		//FB.login(function(response) {
		//	fb_user_id = response.authResponse.userID; //get FB UID
		//	document.addCategoryForm.user_id.value = fb_user_id;
		//	document.getElementById('userID').innerHTML = '' + fb_user_id;
		//});
		/* FB.api('/me/picture?type=larger', function(response) {
			document.getElementById("profile").innerHTML += "<img src=" + response+ "><br>";
			docuemnt.getElementById("profile").style.backgroundImage = response;
			//document.getElementById("profile").value = response;
		}); */
	};
	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		// The response object is returned with a status field that lets the
		// app know the current login status of the person.
		// Full docs on the response object can be found in the documentation
		// for FB.getLoginStatus().
		if (response.status === 'connected') {
			// Logged into your app and Facebook.
			fb_user_id = response.authResponse.userID; //get FB UID
			document.addCategoryForm.user_id.value = fb_user_id;
			document.getElementById('userID').innerHTML = '' + fb_user_id;
		} else if (response.status === 'not_authorized') {
			// The person is logged into Facebook, but not your app.
			FB.login();
		} else {
			// The person is not logged into Facebook, so we're not sure if
			// they are logged into this app or not.
			FB.login();
		}
	}
	function fb_logout() {
		FB.logout(function(response) {
			window.alert('byebye!');
			window.location.href = "/";
			
		});
	}
</script>
<script type="text/javascript">
	//오른쪽 배경 변경에 필요한 script
	$(function() {
		$("#btn_skin1").click(function() {
			//document.getElementById(
			return true;
		});

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
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1_c.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.body.style.backgroundColor = "rgb(247,254,219)";
							//document.getElementById("bgNumber").innerHTML = "1";
							document.change_bg_Form.bgNumber.value = 1;
							//pf.getElementById('count').innerHTML="1";
						});
	});
	$(function() {
		$("#btn_skin2")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_2.png)";
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2_c.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.change_bg_Form.bgNumber.value = 2;
							document.body.style.backgroundColor = "rgb(237,254,247)";

							//pf.getElementById('count').innerHTML="2";
						});
	});
	$(function() {
		$("#btn_skin3")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_3.png)";
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3_c.png";
							document.change_bg_Form.bgNumber.value = 3;
							document.body.style.backgroundColor = "rgb(255,246,247)";
							//document.getElementById("bgNumber").innerHTML = "3";
							//pf.getElementById('count').innerHTML="3";
						});
	});
	$(function() {
		$("#btn_skin0")
				.click(
						function() {
							//var pf = parent.opener.document;
							document.getElementById("bg").style.backgroundImage = "url(img/background/bg_0.png)";
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin_c.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.change_bg_Form.bgNumber.value = 0;
							document.body.style.backgroundColor = "rgb(255,255,255)";
							//document.getElementById("bgNumber").innerHTML = "0";
							//pf.getElementById('count').innerHTML="0";
						});
	});
	$(function() {
		$("#btn_skin4").click(function() {
			var popOptions = "dialogWidth: 506px; dialogHeight: 275px; center: yes; resizable: yes; status: no; scroll: no;"; 
			var title = window.showModalDialog("buy_popup.jsp", "",  popOptions ); 
		});
	});
</script>


<script>
	//배경설정된거 확인후 오른쪽 사이드에서 클릭된 이미지 변경될때 사용할 스크립트

	$(window)
			.load(
					function() {
						var backgroundNumber =
<%=(String) session.getAttribute("userBG")%>
	;

						//document.getElementById("btn_skin1").src = "img/background/btn_skin1_c.png";
						switch (backgroundNumber) {
						case 0:
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin_c.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.body.style.backgroundColor = "rgb(255,255,255)";
							break;
						case 1:
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1_c.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.body.style.backgroundColor = "rgb(247,254,219)";
							break;
						case 2:
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2_c.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3.png";
							document.body.style.backgroundColor = "rgb(237,254,247)";
							break;
						case 3:
							document.getElementById("btn_skin0").src = "img/background/btn_no-skin.png";
							document.getElementById("btn_skin1").src = "img/background/btn_skin1.png";
							document.getElementById("btn_skin2").src = "img/background/btn_skin2.png";
							document.getElementById("btn_skin3").src = "img/background/btn_skin3_c.png";
							document.body.style.backgroundColor = "rgb(255,246,247)";
							break;
						}
						//프로필 이미지 가져올것들..
						var profileURL = String("https://graph.facebook.com/");
						profileURL +=
<%=(String) session.getAttribute("userID")%>
	;
						profileURL += "/picture";
						document.getElementById("profile").src = ""
								+ profileURL;

					});
</script>
<script language="JavaScript">
	function test(e) {
		//카테고리 이름변경을  위한 함수
		var oldDiv = String("category" + e + "hidden_");
		var newDiv = String("category" + e + "new");
		var oldName = document.getElementById('' + oldDiv).value;

		var newName = prompt("새로운 제목을 입력하세요", "");
		if (newName == null) {
			document.getElementById('' + newDiv).value = '' + oldName;
		}
		document.getElementById('' + newDiv).value = '' + newName;
	}
</script>
</head>
<body id="id_body" style="overflow-x: hidden; overflow-y: hidden">

	<!-- 상단 바 부분	 -->
	<div id="bar">
		<div align="center" style="margin-top: 7px;">
			<img src="img/bg_barlogo.png" />
		</div>
	</div>

	<div id="search">
		<form action="index.jsp">
			<input type="text" id="input_url" name="input_url"
				style="background: url(img/bg_search1.png); background-repeat: no-repeat; width: 205px; height: 34px; border: 0px; padding-left: 6px; padding-right: 60px;">
		</form>
	</div>
	<div id="search_icon">
		<input type="image" src="img/btn_search.png" name="submit"
			align="absmiddle" border="0">
	</div>
	<div id="make_icon">
		<input type="image" src="img/link/btn_link.png"
			onclick="makeNewIcon(); return false;"></input>
	</div>


	<!-- 좌측 슬라이드 부분 -->
	<div id="effect">
		<div id="left_slide_content">
			<div id="left_slide_real_content">
				<div style="float: right;">
					<a href="#" onclick="fb_logout();"><img
						src="img/btn_logout.png" border="0"></a> <br>
				</div>
				<br>
				<div style="margin: 0 auto;">
					<div>
						<table cellspacing="10" style="padding-left: 20px;">
							<tr>
								<td>
									<!-- 로그인한 프로필 사진--> <img id="profile"
									style="height: 3em; width: 3em; border-radius: 1.5em; -webkit-border-radius: 1.5em; -moz-border-radius: 1.5em; text-align: center; line-height: 3em; border: 3px solid rgb(167, 204, 18);">
									</img>
								</td>
								<td>
									<!-- 로그인한 이름 --> <fb:name uid="loggedinuser" use-you="no"></fb:name>
								</td>
							</tr>
						</table>
						<br>
						<div id="status"></div>
						<form method="post" action="add_category.jsp"
							name="addCategoryForm">
							<div onlogin="checkLoginState();" id="userID" name="userID"
								style="display: none;"></div>
							<input type="hidden" name="user_id" id="user_id" />
							<table
								style="border-collapse: collapse; padding: 0; border-spacing: 0px;">
								<tr>
									<td><input type="text" id="input_category"
										name="input_category"
										style="background: url(img/left_slide/bg_add-list1.png); background-repeat: no-repeat; width: 160px; height: 33px; border: 0px; padding-left: 6px; padding-right: 15px; margin-left: 20px;"
										maxlength="10"></td>
									<td><input type="image"
										src="img/left_slide/btn_add-list_btn.png" name="submit"
										id="category_add_btn" border="0" style="margin-left: 15px;"></td>
								</tr>
							</table>
						</form>
						<!-- 카테고리 목록 -->
						<table style="padding: 2px; border-spacing: 2px;">
							<tr>
								<td>
									<form action="delete_category.jsp" method="post"
										name=category1deleteForm>
										<input type="hidden" name="categoryName" id="category1hidden" />
										<input type="image" src="img/left_slide/btn_list-delete.png"
											name="submit" id="category_1_delete_btn"
											style="display: none;" />
									</form>
								</td>
								<td width="200px" align="center">
									<form action="SetCategory.jsp" method="post">
										<input type="hidden" name="categoryName"
											id="category1hidden__" /> <input type="submit"
											id="category1"
											style="display: none; background-color: rgba(255, 255, 255, 0.0); font-weight: bold; text-align: center; border: 0px; color: rgb(131, 166, 30); cursor: pointer;" />
									</form>
								</td>

								<td>
									<form action="edit_category.jsp" method="post"
										name=category1editForm>
										<input type="hidden" name="categoryName" id="category1hidden_" />
										<input type="hidden" name="categorynew" id="category1new" />
										<input type="image" src="img/left_slide/btn_list-edit.png"
											onClick="test('1')" id="category_1_edit_btn"
											name="category_1_edit_btn" style="display: none;" />
									</form>
								</td>
							</tr>
							<tr>

								<td>
									<form action="delete_category.jsp" method="post"
										name=category2deleteForm>
										<input type="hidden" name="categoryName" id="category2hidden" />
										<input type="image" src="img/left_slide/btn_list-delete.png"
											name="submit" id="category_2_delete_btn"
											style="display: none;">
									</form>
								</td>
								<td align="center">
									<form action="SetCategory.jsp" method="post">
										<input type="hidden" name="categoryName"
											id="category2hidden__" /><input type="submit" id="category2"
											style="display: none; background-color: rgba(255, 255, 255, 0.0); font-weight: bold; text-align: center; border: 0px; color: rgb(131, 166, 30); cursor: pointer;" />
									</form>

								</td>
								<td>
									<form action="edit_category.jsp" method="post"
										name=category2editForm>
										<input type="hidden" name="categoryName" id="category2hidden_" />
										<input type="hidden" name="categorynew" id="category2new" />
										<input type="image" src="img/left_slide/btn_list-edit.png"
											onClick="test('2')" id="category_2_edit_btn"
											name="category_2_edit_btn" style="display: none;" />
									</form>
								</td>
							</tr>
							<tr>
								<td>
									<form action="delete_category.jsp" method="post"
										name=category3deleteForm>
										<input type="hidden" name="categoryName" id="category3hidden" />
										<input type="image" src="img/left_slide/btn_list-delete.png"
											name="submit" id="category_3_delete_btn"
											style="display: none;">
									</form>
								</td>
								<td align="center">
									<form action="SetCategory.jsp" method="post">
										<input type="hidden" name="categoryName"
											id="category3hidden__" /> <input type="submit"
											id="category3"
											style="display: none; background-color: rgba(255, 255, 255, 0.0); font-weight: bold; text-align: center; border: 0px; color: rgb(131, 166, 30); cursor: pointer;" />
									</form>
								</td>

								<td>
									<form action="edit_category.jsp" method="post"
										name=category3editForm>
										<input type="hidden" name="categoryName" id="category3hidden_" />
										<input type="hidden" name="categorynew" id="category3new" />
										<input type="image" src="img/left_slide/btn_list-edit.png"
											onClick="test('3')" id="category_3_edit_btn"
											name="category_3_edit_btn" style="display: none;" />
									</form>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="button" style="display: block">
			<p>
				<a href="#">Toggle</a>
			</p>
		</div>
	</div>

	<!-- 우측 슬라이드 부분 -->
	<div id="effect2">
		<div id="right_slide_content">
			<div id="bg_select_slide">
				<br> <Br> <br>
				<!--  img
					src="img/background/btn_beforepage.png" id="btn_before" /> <span
					id="count">1</span> / 4 <img src="img/background/btn_nextpage.png"
					id="btn_next" /> -->
				<form method="post" action="change_bg.jsp" name="change_bg_Form">
					<input type="hidden" id=bgNumber name=bgNumber /> <br> <img
						src="img/background/btn_no-skin_c.png" id="btn_skin0"
						style="cursor: pointer;" /><br> <img
						src="img/background/btn_skin1.png" id="btn_skin1"
						style="cursor: pointer;" /><br> <img
						src="img/background/btn_skin2.png" id="btn_skin2"
						style="cursor: pointer;" /><br> <img
						src="img/background/btn_skin3.png" id="btn_skin3"
						style="cursor: pointer;" /><br> <img
						src="img/background/btn_lock.png" id="btn_skin4"
						style="cursor: pointer;" /> <br> <input type="image"
						src="img/background/btn_bgsave.png" name="submit" id="bg_save_btn"
						border="0">
				</form>
			</div>
		</div>
		<div id="bgbutton">
			<p>
				<a href="#">Toggle</a>
			</p>
		</div>
	</div>

	<!-- bg는 배경화면 테스트를위한 div임.. 나중에 contents_cont가 bg안에 들어가있어야함 bg:1200x800, 

contents_cont:1100x700 -->
	<div id="bg" align="center"
		style="background: url(img/background/bg_<%=session.getAttribute("userBG")%>.png);">
		<div id="contents_cont"></div>
	</div>
	<!-- contents_cont에 내용들이 보일꺼고, 위치 수정해줘야함..시작위치가 바 부분 밑일수 있게 -->
</body>
</html>
