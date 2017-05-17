<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 댓글게임 관리 > 댓글달기</title>
	<script>
		$(function(){
			
			$('#searchForm').submit(function(e){
				 e.preventDefault();
			});
			
			$('#btnReg').click(function(){
				
				var isEvent = $(':radio[name="isEvent"]:checked').val();
				if(isEvent == null || isEvent == ''){
					alert('이벤트 여부를 선택하세요!');
					return false;
				}else{
					$("#topYn").val(isEvent);
				}
				
				//닉네임 선택확인
				var targetId = $(':radio[name="targetList"]:checked').val();
				if(targetId == null || targetId == ''){
					alert('닉네임을 선택하세요!');
					return false;
				}else{
					$("#userNo").val(targetId);
				}
				
				var comment = $("#comment").val();
				if(comment == null || comment == ''){
					alert('댓글을 입력하세요!');
					return false;
				}
								
				//등록처리
				var form = $('form')[0];	//FormData parameter에 담아줌				
				var formData = new FormData(form);

				$.ajax({
	                url: '<c:url value="/popup/CM/GB/GB0302"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                    alert("등록 되었습니다.");
	                    parent.document.location.reload();
	                    location.reload();
	                },
	                error: function(xhr, status, error){
	                	var _errData = $.parseJSON(xhr.responseText);
	                	alert("등록 중 오류가 발생하였습니다.\n[원인:" + _errData.error.message + "]");
	                }
	            });
			});
			
			/* 
			$('#btnMod').click(function(){
				
				if ( $('input[name=excelfile]').val() != ''){
					var form = $('form')[0];
					//FormData parameter에 담아줌
					var formData = new FormData(form);

					$.ajax({
		                url: '<c:url value="/popup/GM/GM07"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                	alert("교체가 성공하였습니다.");
		                    location.reload();
		                },
		                error: function(xhr, status, error){
		                	var _errData = $.parseJSON(xhr.responseText);
		                	alert("교체 중 오류가 발생하였습니다.\n(원인:" + _errData.error.message + ")");
		                	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		                }
		            });
				}else{
					alert('업로드할 파일을 선택하세요.');
				}
				
			});
			 */
			
		});
		
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<!-- <div class="inner-cont"> -->
	<div>
		<div class="title-area">
			<!-- Title -->
			<h2>댓글달기(쿠폰/도전과제)</h2>			
		</div>
		
		<div >
			<form role="form" name="searchForm" id="searchForm" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="parentId" name="parentId" value="${params.parentId }"/>
				<input type="hidden" id="gameSeq" name="gameSeq" value="${params.gameSeq }"/>
				<input type="hidden" id="commentSeq" name="commentSeq" value="${params.commentSeq }"/>
				<input type="hidden" id="depthUserNo" name="depthUserNo" value="${params.depthUserNo }"/>
				<input type="hidden" id="depth" name="depth" value="${params.depth }"/>
				<input type="hidden" id="userNo" name="userNo"/>
				<input type="hidden" name="topYn" id="topYn" value="${params.topYn }"/>
				
				<br/>
				
				<div>
					<input type="radio" id="sl1" name="isEvent" value="N" checked="checked" <c:if test="${params.topYn eq 'N'}">checked='checked'</c:if> 
						<c:if test="${params.depth eq '2'}">disabled='disabled'</c:if> > 일반
					<input type="radio" id="sl1" name="isEvent" value="Y" <c:if test="${params.topYn eq 'Y'}">checked='checked'</c:if> 
						<c:if test="${params.depth eq '2'}">disabled='disabled'</c:if> > 이벤트
					
					&nbsp;&nbsp;※ 날짜: <input type="datetime" id="createDt" name="createDt" title="날짜" class="hasDatepicker" value="${params.createDt }" 
						placeholder="이벤트성 게시글 등록시 등록날짜를 변경할수 있습니다." <c:if test="${params.depth eq '2'}">disabled='disabled'</c:if> >
				</div>
								
				<!-- 테이블 목록 -->
				<div class="table-list-type1">
					<table>
						<caption></caption>
						<colgroup>
							<col style="width:10%;"/>
							<col style="width:40%;"/>
							<col style="width:*;"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">선택</th>
								<th scope="col">썸네일</th>
								<th scope="col">닉네임</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(users) > 0 }">
									<c:forEach var="item" items="${users}" varStatus="status">
										<tr>
											<td>
												<input type="radio" id="sl1" name="targetList" value="${item.userNo }">
											</td>
											<td>
												<img src="${item.profileImg }" style="width:50px;"/>
											</td>
											<td>${item.nick}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="2">조회 결과가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				
				<div>
					<!-- 여기가 댓글 넣는 곳!!! -->
					<textarea id="comment" name="comment" placeholder="댓글을 입력해주세요!"></textarea>
				</div>
			
			</form>
		</div>
			
		<br/>
		
		<div class="btn-group">
			<button class="btn-black2" id="btnReg" ><span>등록하기</span></button>
			
		</div>
				
	</div>
</body>
</html>