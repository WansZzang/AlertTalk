<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 도전과제</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({
		                url: '<c:url value="/DM/DM05"/>',
		                data: "seqNo=${item.seqNo}",
		                type: 'POST',
		                success: function(result){
		                    alert("삭제되었습니다.");
		                    location.href = '<c:url value="/DM/DM01"/>';
		                },
		                error: function(){
		                	alert("삭제 중 오류가 발생하였습니다.");
		                }
		            });
				}
				
			});
		});
		
		$(document).ready(function(){
			
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">도전과제</a> &gt;
		<strong>도전과제  상세</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>도전과제  상세</h2>
			<p>도전과제를 관리합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게임명</th>
							<td>
								<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly" value="${item.game.gameNm }">
							</td> 
						</tr>
						
						<tr>
							<th scope="row"> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showOrder" placeholder="순서를 입력해 주세요." value="${item.showOrder }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" value="Y" disabled="disabled" <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if> >
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N" disabled="disabled" <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if>>
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 추천여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optRcmdYN" value="Y" disabled="disabled" <c:if test="${item.recommendYn eq 'Y'}">checked='checked'</c:if>>
										<label for="at1">추천</label>
									</li>
									<li>
										<input type="radio" name="optRcmdYN" value="N" disabled="disabled" <c:if test="${item.recommendYn eq 'N'}">checked='checked'</c:if>>
										<label for="at2">추천안함</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>유효기간</th>
							<td>
								<input type="text" id="validDt" name="validDt" title="유효기간" value="${item.validDt }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게시기간</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" value="${item.startDt }" readonly="readonly"></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" value="${item.endDt }" readonly="readonly"></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="missionTitle" placeholder="제목을 입력해 주세요." readonly="readonly" value="${item.missionTitle }">
							</td>
						</tr>
						<c:if test="${item.items ne null &&  fn:length(item.items) > 0 }">
							<c:forEach var="missionItem" items="${item.items }" >
								<tr>
									<th scope="row"><span class="required" title="필수">*</span> ${missionItem.subNo}_미션</th>
									<td>
										<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요." value="${missionItem.missionContents }" readonly="readonly">
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody> 
				</table>
			</form>
		</div> 

		<div class="btn-area ar">
			<a href="<c:url value="/DM/DM01"/>" class="btn-black2">목록</a>
			<a href="<c:url value="/DM/DM04"/>?seqNo=${item.seqNo}" class="btn-black2">수정</a>
			<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
		</div>

	</div>
<div id="gameListPopup" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">게임리스트</h2>
			<div class="search-detail">
				<h3 class="blind"> </h3>
				<div>
					<iframe id="popupIfrm" src="" style="width:100%;height:800px;border:0;frameborder:0;"></iframe>
				</div>
			</div>
		</div>
		<button type="button" class="close btnPopClose">레이어팝업 닫기</button>
	</div>
</div>
</body>
</html>