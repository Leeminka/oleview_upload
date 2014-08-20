<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>삭제할꺼에용??</title>
<script>
	$('#btn_yes').click(function() {
		window.opener.getReturnValue(1);
		window.close();
	});
	
	$('#btn_cancle').click(function() {
		window.opener.getReturnValue(2);
		window.close();
	});
</script>
</head>

<body background="img/popup/bg_delete.png" >
<img id="btn_yes" src="img/popup/btn_yes.png" border=0 style="position:absolute; width:147px; height:50px; top:210px; left:95px;"/> 
<img id="btn_cancel" src="img/popup/btn_cancel.png" border=0 style="position:absolute; width:147px; height:50px; top:210px; left:310px"/> 
</body>
</html>