<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<title>로그아웃</title>

<link rel="stylesheet" href="/admin/common/css/default.css">
<link rel="stylesheet" href="/admin/common/css/common.css">
<link rel="stylesheet" href="/admin/common/css/bootstrap-datepicker.css">
<script src="/admin/common/js/jquery-1.9.1.js"></script>
<script src="/admin/common/js/ui.common.js"></script>
<script src="/admin/common/js/jquery.placeholder.js"></script>
<script src="/admin/common/js/bootstrap-datepicker.js"></script>
	<script>
		$(function(){
		
		});
		
		$(document).ready(function(){
			//alert("이용해주셔서 감사합니다.");
			location.href = '<c:url value="/member/login.do"/>';
		});
	</script>
</head>
<body>
	
</body>
</html>
