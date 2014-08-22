<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>이름을 지어주세용~</title>

<link rel="stylesheet"
	href="css/ui-lightness/jquery-ui-1.10.4.custom.min.css">
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/jquery-ui-1.10.4.custom.min.js"></script>

<script language="javascript" type="text/javascript">
	function yes() {
		window.returnValue = $('#input').val();
		window.close();
	}

	function cancel() {
		window.returnValue = "cancel_oleview";
		window.close();
	}
</script>
</head>

<body background="img/popup/bg_title.png">
	<input type="text" maxlength="10" id="input"
		style="margin-left: 10px; margin-right: 10px; background: url(img/popup/input.png); border: 0px; font-face: 나눔고딕; position: absolute; width: 391px; height: 45px; top: 115px; left: 40px;">
	<img id="btn_yes" onclick="yes()" src="img/popup/btn_yes.png" border=0
		style="position: absolute; width: 147px; height: 50px; top: 180px; left: 95px; cursor: pointer" />
	<img id="btn_cancel" onclick="cancel()" src="img/popup/btn_cancel.png"
		border=0
		style="position: absolute; width: 147px; height: 50px; top: 180px; left: 270px; cursor: pointer" />
</body>
</html>
