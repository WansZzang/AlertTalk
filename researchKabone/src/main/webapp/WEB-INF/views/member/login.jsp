<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<title>로그인</title>
<link rel="stylesheet" href="/admin/common/css/default.css">
<link rel="stylesheet" href="/admin/common/css/common.css">
<link rel="stylesheet" href="/admin/common/css/bootstrap-datepicker.css">
<script src="/admin/common/js/jquery-1.9.1.js"></script>
<script src="/admin/common/js/ui.common.js"></script>
<script src="/admin/common/js/jquery.placeholder.js"></script>
<script src="/admin/common/js/bootstrap-datepicker.js"></script>

<script type="text/javascript"> 
	function doLogin() {
		if(frm.j_username.value == "") {
			alert("아이디를 입력해주세요.");
			return;
		}
		if(frm.j_password.value == "") {
			alert("패스워드를 입력해주세요.");
			return;
		}
		
		frm.submit();
	}
</script>


</head>
<body class="login">


<!-- login -->
<div id="login-wrap">
	<!-- 
	<strong class="logo">
		<img src="/admin/common/images/logo.png" alt="">
	</strong> 
	-->
	<h1>간호평가원 만족도조사</h1>
	<div class="login-area">
		<div class="login-form">
			<form name="frm" action="j_spring_security_check" method="post">
			<fieldset>
				<legend>로그인 영역</legend>
				<span class="inpt"><input name="j_username" type="text" title="아이디" placeholder="아이디" value=""></span>
				<span class="inpt"><input name="j_password" type="password" title="비밀번호" placeholder="비밀번호" value=""></span>
				<button type="submit" class="btn-login" onclick="doLogin();"><span>로그인</span></button>
			<!-- <a href="/pm/projectListSpCnfm.do">로그인</a> -->
			</fieldset>
			</form>
		</div>
	</div>
</div>
<!-- //login -->
<!-- 
<a href="/pm/projectListSpCnfm.do"> 후원형 프로젝트 승인 관리</a></p>
-->

</body>
</html>