<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 커뮤니티 관리 > 댓글 관리 > 댓글 달기</title>
	<script>
		$(function(){
			
			$('#searchForm').submit(function(e){
				 e.preventDefault();
			});
			
			$('#btnReg').click(function(){
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
												
				//alert($("#userNo").val() + ', ' + $("#communitySeq").val() + ', ' + $("#boardSeq").val() + ', ' + $("#comment").val());
				
				//등록처리
				var form = $('form')[0];	//FormData parameter에 담아줌				
				var formData = new FormData(form);

				$.ajax({
	                url: '<c:url value="/popup/CM/UF/UF06"/>',
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
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>댓글 달기</h2>			
		</div>
		
		<p>
			<br/>
			닉네임을 선택하신 후 댓글을 등록해주세요!
			<br/>
		</p>
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
		
		<br/>
		
		<!-- search -->
		<div >
			<form role="form" name="searchForm" id="searchForm" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="parentId" name="parentId" value="${params.parentId }"/>
				<input type="hidden" id="communitySeq" name="communitySeq" value="${params.communitySeq }"/>
				<input type="hidden" id="boardSeq" name="boardSeq" value="${params.boardSeq }"/>
				<input type="hidden" id="userNo" name="userNo" value="${params.userNo }"/>
				
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