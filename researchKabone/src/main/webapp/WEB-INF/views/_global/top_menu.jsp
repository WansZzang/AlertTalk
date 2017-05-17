<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header id="header-area">

	<!-- logo -->
	<h1><img src="/admin/common/images/login_logo.png" alt="간평원 로고"></h1>

	<!-- nav  -->
	<ul class="nav">
		<li class="RM"><a href='<c:url value="/RM/RM/RM01"/>'>설문 조사 현황</a></li>
		<li class="MM"><a href='<c:url value="/MM/ME/ME01"/>'>사용자 관리</a></li>
	</ul>
</header>
<!-- //header -->