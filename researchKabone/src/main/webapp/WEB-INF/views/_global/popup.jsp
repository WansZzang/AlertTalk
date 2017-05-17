<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sform"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><decorator:title default="▒ Research Kabone ▒" /></title>
	
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Neon Admin Panel" />
	<meta name="author" content="" />

	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta http-equiv='Cache-Control' ConTENT='no-cache'>
	<meta http-equiv='Pragma' ConTENT='no-cache'>
	<meta http-equiv="Expire" ConTENT="-1">
	
	<link rel="stylesheet" href="/admin/common/css/default.css">
	<link rel="stylesheet" href="/admin/common/css/common-popup.css">
	<link rel="stylesheet" href="/admin/common/css/bootstrap-datepicker.css">
	<script src="/admin/common/js/jquery-1.9.1.js"></script>
	<script src="/admin/common/js/ui.common.js"></script>
	<script src="/admin/common/js/jquery.placeholder.js"></script>
	<script src="/admin/common/js/bootstrap-datepicker.js"></script>
	<style>
		body{ background : ''}
	</style>
	<decorator:head/>
	<script> 
		$(document).ready(function(){
			/*if(isMobile() == 'nomobile'){
				
			}*/
		});
	</script>
</head>
<body >

<decorator:body/>
	
</body>
</html>