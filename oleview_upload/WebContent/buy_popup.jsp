<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>배경 구매 알림 팝업</title>

<link rel="stylesheet" href="css/ui-lightness/jquery-ui-1.10.4.custom.min.css">
<script src="scripts/jquery-1.11.0.min.js"></script>
<script src="scripts/jquery-ui-1.10.4.custom.min.js"></script>

<script language="javascript" type="text/javascript">
	function buy(){
		window.close();
	}

</script>
</head>

<body background="img/popup/bg_box.jpg" >
<img id="btn_yes" onclick="buy()" src="img/popup/btn_buy.jpg" border=0 style="position:absolute; width:199px; height:50px; top:210px; left:150px; cursor: pointer"/> 
</body>
</html>