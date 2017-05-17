<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sform"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title></title>
	
	<meta charset="utf-8">
	<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="" />
	<meta name="author" content="" />

	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta http-equiv='Cache-Control' ConTENT='no-cache'>
	<meta http-equiv='Pragma' ConTENT='no-cache'>
	<meta http-equiv="Expire" ConTENT="-1">
	
	<link rel="stylesheet" href="/admin/common/css/default.css">
	<link rel="stylesheet" href="/admin/common/css/common.css">
	<link rel="stylesheet" href="/admin/common/css/bootstrap-datepicker.css">
	
	<style>
		.snb {
			display : none;
		}
	</style>
	<script type="text/javascript" src="/admin/common/js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="/admin/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="/admin/common/js/ui.common.js"></script>
	<script type="text/javascript" src="/admin/common/js/jquery.placeholder.js"></script>
	<script type="text/javascript" src="/admin/common/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/admin/common/js/customCommon.js"></script>
	
	<script type="text/javascript" src="/admin/common/js/util.js"></script>
	
	<!-- 20161024 ycyu add > 드래그앤드랍 -->
	<!-- <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script> -->
	<script type="text/javascript" src="/admin/common/js/jquery.tablednd.js"></script>
	<script type="text/javascript" src="http://jsgetip.appspot.com/?getip">
	</script>
	<script>
	
		$(function(){
			$('#submitBtn').click(function(){		        
		        if(!$("#checkIp")[0].checked){
		            alert('약관에 동의해 주세요');
		            return false;
		        } 
		        
				if ( confirm("제출하시겠습니까?")){
					$("#userIp").val(getip());
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/research/researchInsert.do"/>',
						data: $("#pollDetailData").serialize(),
						error:function(data){
							alert('제출 실패.\nresponseText : ' + data.responseText);
						},
						success:function(data){
							alert('제출 완료');
							location.href = '<c:url value="/research/result.do"/>';
						}
					});
				}
			});
		});
				
	</script>
</head>
<body>
	<div id="container">
	<section class="contents" style="background:WHITE;width:80%;padding-left:5%;padding-right:5%;">
		<!-- 설문MASTER 시작 -->
		<div style="padding:20px 20px 20px 20px;">
			<div class="pollTitle" style="position:center;width:85%;vertical-align: middle;text-align: center;margin:5% 5% 5% 5%;padding:20px 20px 20px 20px;">
				<h1 style="font-size: 20px;color: #5a6779;">${pollMaster.pollTitle}</h1>
				<br>
				<br>
			</div>
			<h2 style="font-size: 16px; font-family: sans-serif; color: #5a6779; font-weight: normal;  line-height: 20px;">${pollMaster.pollMasterDesc}</h2>
		</div>
		<!-- 설문DETAIL 시작 -->
		<div class="table-form2">
			<form id="pollDetailData" method="post">
				<input name="userIp" id="userIp" type="hidden" value="">
				<div class="rules-area">
				<ul>
				<li>
				◦ 개인 정보 수집․이용의 목적 : 설문 중복 작성 필터링
				</li>
				<li>
				◦ 수집하려는 개인 정보의 항목 : IP주소
				</li>
				<li>
				◦ 개인정보의 보유 및 이용 기간 : 수집 시점으로부터 5년
				</li>
				<li><input name="checkIp" id="checkIp" type="checkbox" ><label for="checkIp">동의 하시겠습니까?</label></li>
				</ul>
				</div>
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:40%;">
						<col style="width:60%;">
					</colgroup>
					<tbody>
					<c:forEach items="${pollDetailList}" var="list">
					<tr>
						<th scope="row" <c:if test="${list.pollType == 1}"> colspan="2"</c:if>>
							<span style="float: left;padding-left:${list.pollDepth*3}%;">${list.pollDesc}</span><br><br>
						</th>
						<td>
							<c:if test="${list.pollType == 2 || list.pollType == 3 }">
							<ul class="radio-group" style="float:right;">
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="1"><label for="pollDetailId${list.pollDetailSeq}">매우 그렇다</label>
								</li>
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="2"><label for="pollDetailId${list.pollDetailSeq}">그렇다</label>
								</li>
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="3"><label for="pollDetailId${list.pollDetailSeq}">보통</label>
								</li>
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="4"><label for="pollDetailId${list.pollDetailSeq}">그렇지 않다</label>
								</li>
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="5"><label for="pollDetailId${list.pollDetailSeq}">전혀 그렇지 않다</label>
								</li>
							</ul>
							</c:if>
							<c:if test="${list.pollType == 4 }">
							<div style="width:100%">
							<input type="text" title="주관식" name="pollDetailId${list.pollDetailSeq}" placeholder="의견을 입력해주세요." >
							</div>
							</c:if>
							<c:if test="${list.pollType == 5}">
							<ul class="radio-group" style="float:right;">
								<c:forEach items="${polloptionList}" var="optionList">
								<c:if test="${optionList.pollDetailSeq eq list.pollDetailSeq}">
								<li>
									<input name="pollDetailId${list.pollDetailSeq}" type="radio" value="${optionList.optionSeq}"><label for="pollDetailId${list.pollDetailSeq}">${optionList.optionDesc}</label>
								</li>
								</c:if>
								</c:forEach>
							</ul>
							</c:if>
						</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div style="width: 100%;padding:20px 20px 0 40%;">
		<button type="submit" class="btn-black3" id="submitBtn"><span style="font-size:15px;">    설문 조사 참여     </span></button>
		
		</div>
	</section>
	</div>
</body>
</html>