<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isErrorPage="true"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %> 
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetailsService" %>
<html>
<head>
<title>Acess Denied Error Page</title>
</head>
<body>
접근권한이 없습니다. 담당자에게 문의하여주기 바랍니다.
${SPRING_SECURITY_403_EXECEPTION }
<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();
	if (principal instanceof UserDetails){
		String username= ((UserDetails) principal).getUsername();
		String password= ((UserDetails) principal).getPassword();
		out.println("Account :" + username.toString() +"");
	}
%>
	<a href="<c:url value='/'/>">확인</a>
</body>
</html>