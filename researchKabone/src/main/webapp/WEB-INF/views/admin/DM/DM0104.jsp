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
			
			$('.btnsave').click(function(){
				
				if ( valid() ){
					var _mission = [];
					
					$('td.missionItems').each(function(){
						var _seqNo = $(this).data('seqno');
						var _delYn = $(this).find('input[type=radio]:checked').val();
						var _contents = $(this).find('input[name=missionContents]').val();
						var _refId = $(this).find('input[name=refId]').val();
						
						if ( typeof _seqNo != 'undefined' && _seqNo > 0) {
							var _item = {
								'subNo' : $(this).data('subno'),
								'missionContents' : _contents,
								'refId' : _refId,
								'seqNo' : _seqNo,
								'delYn' : _delYn
							};
							
							_mission.push(_item);
						}
					});
					
					var makeObj = {
						'seqNo' : $('input[name=seqNo]').val() ,
						'missionTitle' : $('input[name=missionTitle]').val() ,
						'showYn' : $('input[name=optShowYN]:checked').val(),
						'recommendYn' : $('input[name=optRcmdYN]:checked').val(),
						'gameSeq': $('input[name=gameSeq]').val(),
						'showOrder' : $('input[name=showOrder]').val(),
						'validDt' : $('input[name=validDt]').val(),
						'startDt' : $('input[name=startDt]').val(),
						'endDt' : $('input[name=endDt]').val(),
						'items' : _mission,
						'missionType' : $('input[name=optMissionType]:checked').val(),
						'notiMsg' : $('#notiMsg').val(),
						'recvEmail' : $('input[name=recvEmail]').val()
					};
					
					$.ajax({
		                url: '<c:url value="/DM/DM04"/>',
		                data: JSON.stringify(makeObj),
		                contentType:"application/json; charset=UTF-8",
		                type: 'POST',
		                success: function(result){
		                	alert("<spring:message code='ui.modify.alert.success'/>");
		                    location.href = '<c:url value="/DM/DM01"/>';
		                },
		                error: function(){
		                	alert("<spring:message code='ui.modify.alert.failure'/>");
		                }
		            });
				}
			});
			
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({
		                url: '<c:url value="/DM/DM05"/>',
		                data: "seqNo=${item.seqNo}",
		                type: 'POST',
		                success: function(result){
		                	alert("<spring:message code='ui.delete.alert.success'/>");
		                    location.href = '<c:url value="/DM/DM01"/>';
		                },
		                error: function(data){
		                	alert("<spring:message code='ui.delete.alert.failure'/>\n" + data.responseText);
		                }
		            });
				}
				
			});
			
			$('td.missionItems input[type=radio]').click(function(){
				var _delYn = $(this).val();
				
				if ( _delYn == 'Y'){
					$(this).parent().parent().parent().parent().find('input[name=missionContents]').val('');
					$(this).parent().parent().parent().parent().find('input[name=refId]').val('');
				}
				
			});
			
		});
		
		function valid(){
			
			if ( $('input[name=optShowYN]:checked').val() == 'Y' && $('input[name=showOrder]').val() == ''){
				alert('노출순서를  입력하세요.')
				return false;
			}
			
			if ( $('input[name=recvEmail]').val() == ''){
				alert('이메일을 입력하세요.')
				return false;
			}
			//20161019 ycyu del > 사용안함
			/* 
			$('#notiMsg').val(CKEDITOR.instances.notiMsg.getData());
			if ( $('textarea[name=notiMsg]').val() == ''){
				alert('공지문구를 입력하세요.')
				return false;
			}
			 */
			if ( $('input[name=validDt]').val() == ''){
				alert('유효기간을 입력하세요.')
				return false;
			}
			
			if ( $('input[name=startDt]').val() == ''){
				alert('게시기간 시작일자를 입력하세요.')
				return false;
			}
			
			if ( $('input[name=endDt]').val() == ''){
				alert('게시기간 종료일자를 입력하세요.')
				return false;
			}
			
			if ( $('input[name=missionTitle]').val() == ''){
				alert('제목을 입력하세요.')
				return false;
			}
			
			var isMissionItemCount = 0;
			var isValid = true;
			$('td.missionItems').each(function(){
				if ( $(this).find('input[type=radio]:checked').val() == 'N'){
					isMissionItemCount++;
					if ( $(this).find('input[name=missionContents]').val() == '' ){
						isValid = false;
						return false;
					}
				}
			});
			
			if ( isMissionItemCount < 10){
				alert('미션은 10개 모두 입력하셔야 합니다.');
				return false;
			}
			
			if ( !isValid ){
				alert('미션사용시 미션명을 입력하세요.');
				return false;
			}
		
			return true;
		}
		
		$(document).ready(function(){
			
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">도전과제</a> &gt;
		<strong>도전과제  등록</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>도전과제  수정</h2>
			<p>도전과제를 수정합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="gameSeq" value="${item.gameSeq}"/>
				<input type="hidden" name="recommendYn"/>
				<input type="hidden" name="seqNo" value="${item.seqNo }"/>
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
									<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly" value="${item.game.gameNm}">
								</div>
							</td>
						</tr>
						
						<tr>
							<th scope="row"> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showOrder" placeholder="순서를 입력해 주세요." value="${item.showOrder}">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" value="Y"  <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if>>
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N"  <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if>>
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
										<input type="radio" name="optRcmdYN" value="Y" <c:if test="${item.recommendYn eq 'Y'}">checked='checked'</c:if> >
										<label for="at1">추천</label>
									</li>
									<li>
										<input type="radio" name="optRcmdYN" value="N" <c:if test="${item.recommendYn eq 'N'}">checked='checked'</c:if> >
										<label for="at2">추천안함</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr style="display:none;">	<!-- 20161019 ycyu mod > 공지문구 사용안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 타입</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optMissionType" value="00" <c:if test="${item.missionType eq '00'}">checked='checked'</c:if>>
										<label for="at1">자동</label>
									</li>
									<li>
										<input type="radio" name="optMissionType" value="09" <c:if test="${item.missionType eq '09'}">checked='checked'</c:if>>
										<label for="at2">수동</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 이메일</th>
							<td>
								<input type="text" title="이메일" name="recvEmail" placeholder="도전과제 인증샷을 받을 이메일 주소를 입력해 주세요" value="${item.recvEmail }">
							</td>
						</tr>
						
						<tr style="display:none;">	<!-- 20161019 ycyu mod > 공지문구 사용안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 공지문구</th>
							<td>
								<div class="editor-area">
									<textarea id="notiMsg" name="notiMsg" title="공지문구">${item.notiMsg}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'notiMsg', {
						                    width:'100%',
						                    height:'200px',
						                    filebrowserImageUploadUrl: '<c:url value="/DM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>유효기간</th>
							<td>
								<input type="text" id="validDt" name="validDt" title="유효기간" class="hasDatepicker" value="${item.validDt}">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게시기간</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value="${item.startDt}"></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value="${item.endDt}"></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="missionTitle" placeholder="제목을 입력해 주세요(24자 이내)" value="${item.missionTitle }">
							</td>
						</tr>
						<c:if test="${item.items ne null &&  fn:length(item.items) > 0 }">
							<c:forEach var="missionItem" items="${item.items }" varStatus="status">
								<tr>
									<th scope="row"><span class="required" title="필수">*</span> ${status.count}_미션</th>
									<td class="missionItems" data-subno="${missionItem.subNo}" data-seqno="${missionItem.seqNo }">
										<ul class="radio-group">
											<li>
												<input type="radio" name="missionIUse${status.count}" value="N" <c:if test="${missionItem.delYn eq 'N' }">checked='checked'</c:if> >
												<label for="at1">사용</label>
											</li>
											<li>
												<input type="radio" name="missionIUse${status.count}" value="Y" <c:if test="${missionItem.delYn eq 'Y' }">checked='checked'</c:if> >
												<label for="at2">사용안함</label>
											</li>
										</ul>
										<div class="input-group">
											<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" value="${missionItem.missionContents }" style="width:500px;">
											<input type="text" title="RefId" name="refId" placeholder="ReferenceId" value="${missionItem.refId}" style="display:none;">
										</div>
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
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
			<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
		</div>
	</div>
</body>
</html>