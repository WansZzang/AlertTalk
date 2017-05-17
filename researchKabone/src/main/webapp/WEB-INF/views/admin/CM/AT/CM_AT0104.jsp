<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 공략정보</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnsave').click(function(){
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				$('#tipComment').val(CKEDITOR.instances.tipComment.getData());
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				if ( $('input[name=gameNm]').val() == ''){
					alert('게임을 선택하세요.');
					return false;
				}
				
				if ( $('input[name=title]').val() == ''){
					alert('제목을 입력하세요.');
					return false;
				}
				
				if ( $('#tipComment').val() == ''){
					alert('공략내용을 입력하세요.');
					return false;
				}

				$.ajax({
	                url: '<c:url value="/CM/AT/AT04"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	alert("<spring:message code='ui.modify.alert.success'/>");
	                    location.href = '<c:url value="/CM/AT/AT01"/>';
	                },
	                error: function(){
	                	alert("<spring:message code='ui.modify.alert.failure'/>");
	                }
	            });
				
			});
			
			/*
			$('#searchBtn').click(function(){
				
				$.ajax({
	                url: '<c:url value="/RM/GM/GM03"/>',
	                data: formData,
	                type: 'GET',
	                success: function(result){
	                },
	                error: function(){
	                	alert("등록 중 오류가 발생하였습니다.");
	                }
	            });
				
			});
			*/
			
			$('#gameSelBtn').click(function(){
				//주소록 검색창 팝업
				$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
				showLayer($(this), 'gameListPopup');
			});
		});
		
		$(document).ready(function(){
			
		});
		
		function selectGame(_seqNo, _lang, _gameName, _gamePacNm){
			alert(_seqNo + "|" + _lang + "|" + _gameName);
			
			$('input[name=gameNm]').val(_gameName);
			$('input[name=gameSeq]').val(_seqNo);
			
			//close popup
			$('.btnPopClose').click();
		}
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">공략정보</a> &gt;
		<strong>공략정보 등록</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>공략정보</h2>
			<p>공략정보를 등록합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="seqNo" value="${item.seqNo }"/>
				<input type="hidden" name="gameSeq" value="${item.gameSeq }"/>
				<input type="hidden" name="showYn"/>
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
								<div class="addr-input">
									<input type="text" title="게임명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly" value="${item.gameNm }">
									<a href="#none" class="btn-gray" id="gameSelBtn">게임선택</a>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 사용여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" <c:if test="${item.showYn eq 'Y'}">checked="checked"</c:if> value="Y">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" <c:if test="${item.showYn eq 'N'}">checked="checked"</c:if> value="N">
										<label for="at2">미사용</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="title" placeholder="제목을 입력해 주세요." value="${item.title }">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 내용</th>
							<td>
								<div class="editor-area">
									<textarea id="tipComment" name="tipComment" title="내용">${item.tipComment}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'tipComment', {
						                    width:'100%',
						                    height:'200px',
						                    filebrowserImageUploadUrl: '<c:url value="/CM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                });
					                </script>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/CM/AT/AT01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
		</div>

	</div>
	
	<!-- 주소록 -->
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