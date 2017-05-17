<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 설문 조사 > 설문 조사 현황</title>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
    function selectPoll(pollUrlParam){		
		$.ajax({ 
			type: 'POST',
			url: '<c:url value="/RM/RM/RM0101"/>',
			data: $("#frmact").serialize(),
			error:function(data){
				alert('조회 안됨 ');
				
			},
			success:function(data){
				$('.authList').empty();
				$('.authList').append(data);
				
			}
			,beforeSend:function(){
            	
            }
            ,complete:function(){
            	
            }
		});
		 
	}
	$(document).ready(function(){
		//excel
		$("#excelBtn").bind("click", function(){
			$("#frmact").attr('action', '<c:url value="/RM/RM/RM04" />').submit();			
			return false;
		});
	});
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">설문 조사</a>
	</p>
	<div class="inner-cont">
		<div class="title-area" style="border-bottom: 1px solid #fff;">
			<div class="pollTitle" style="position:center;width:85%;vertical-align: middle;text-align: center;margin:5% 5% 5% 5%;">
				<h1 style="font-size: 30px;color: #5a6779;">설문 조사 현황</h1>
				<br>
				<br>
				<h2 style="font-size: 15px;color: #5a6779;"> 현재 진행중인 설문 조사 현황을 보여줍니다.</h2>
			</div>
			<div class="table-form">
				<form id="frmact" method="post">
					<input type="hidden" name="isNewAuthEmail"/>
					<table>
						<div class="btn-area ar">
							<button type="button" class="btn-simple excel" id="excelBtn"><span>EXCEL</span></button>
						</div>
						<caption></caption>
						<colgroup>
							<col style="width:10%;">
							<col style="width:90%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">설문 타이틀 선택</th>
								<td>
									<div class="select-row1">
										<span class="search-group">
											<select title="설문지 타이틀" id="pollUrlParam" name="pollUrlParam" onchange="javascript:selectPoll(this.value);">
												<option value="">선택없음</option>
												<c:forEach items="${pollMasterVOList}" var="list">
												<option value="${list.pollUrlParam}"  >${list.pollTitle}</option>
												</c:forEach>
											</select>
										</span>
									</div>
								</td>
							</tr>		
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<div class="authList">
		</div>
	</div>
</body>
</html>