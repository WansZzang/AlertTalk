<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*, java.text.*"  %>

<%
	 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	 String today = formatter.format(new java.util.Date());
%>

<script type="text/javascript">
	function logout(){
		location.href = '/member/logout.do';
	}
</script>

<div id="side">
	<!-- user-area -->
	<div class="user-area">
		</br>
		<h3 style="text-decoration:underline;">
			${sessionScope.userLoginInfo.adminNm} 님</h3>
		</h1>
		</br>
		<%-- <strong>
			${sessionScope.userLoginInfo.adminNm}<br>님
		</strong> --%> 
		<span class="par">반갑습니다.</span>
		<span class="date"><%=today%></span>
		
		<button type="submit" onclick="logout();"><span>로그아웃</span></button>
	</div>
	<!-- //user-area -->
	
	<div class="snb RM">
		<ul class="side-nav">
			<li><a href='<c:url value="/RM/RM/RM01"/>'>설문 조사</a>
				<ul>
					<li><a href='<c:url value="/RM/RM/RM01"/>'>진행중인 설문 조사</a></li>
					<li><a href='<c:url value="/RM/RM/RM02"/>'>완료된 설문 조사</a></li>
				</ul>
			</li>
		</ul>
	</div>
</div>
