<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 푸쉬관리 > PUSH 메시지 발송 내역</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			
			$('.btnsave').click(function(){
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				$('input[name=pnsType]').val($('#selPnsType option:selected').val());
				$('input[name=renderingYn]').val($('input[name=optRenderingYn]:checked').val());
				$('input[name=targetUserLevel]').val($('input[name=optTargetUserLevel]:checked').val());
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				if ( $('input[name=pnsTitle]').val() == ''){
					alert('제목을 입력하세요.');
					return false;
				}
				
				if($('input[name=optRenderingYn]:checked').val() == 'Y'){
					if ( $('input[name=renderingUrl]').val() == ''){
						alert('연결URL을 입력하세요.');
						return false;
					}	
				}
				
				/* 
				if ( $('input[name=imgUrl]').val().indexOf('http') < 0){
					alert('이미지 URL이 형식에 맞지 않습니다.');
					return false;
				}
				*/
								
				if ( $('input[name=pnsCont]').val() == ''){
					alert('내용을 입력하세요.');
					return false;
				}

				if ( confirm('입력하신 내용으로 PUSH 메시지를 발송하시겠습니까?')){
					$.ajax({
		                url: '<c:url value="/CM/PU/PU03"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                    alert("PUSH 메시지 발송이 완료되었습니다");
		                    location.href = '<c:url value="/CM/PU/PU01"/>';
		                },
		                error: function(){
		                	alert("<spring:message code='ui.create.alert.failure'/>");
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
		<a href="#none" class="home">커뮤니티</a> &gt;
		<a href="#none">푸쉬관리</a> &gt;
		<strong>PUSH 메시지 발송 내역</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>PUSH 메시지 발송 내역</h2>
			<p>회원들에게 PUSH 메시지를 발송하고 이력을 관리합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" >
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="pnsType"/>
				<input type="hidden" name="renderingYn"/>
				<input type="hidden" name="targetUserLevel"/>
				
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> PNS타입</th>
							<td>
								<select title="PNS타입" id="selPnsType">
									<option value="CO" <c:if test="${param.pnsType == 'CO'}">selected</c:if> >쿠폰</option>
									<option value="EV" <c:if test="${param.pnsType == 'EV'}">selected</c:if> >이벤트</option>
									<option value="NT" <c:if test="${param.pnsType == 'NT'}">selected</c:if> >공지사항</option>
									<option value="UP" <c:if test="${param.pnsType == 'UP'}">selected</c:if> >업데이트</option>
									<option value="NP" <c:if test="${param.pnsType == 'NP'}">selected</c:if> >새게시글</option>
									<option value="NR" <c:if test="${param.pnsType == 'NR'}">selected</c:if> >새댓글</option>
									<option value="NC" <c:if test="${param.pnsType == 'NC'}">selected</c:if> >새채팅글</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 받는사람</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optTargetUserLevel" checked="checked" value="99">
										<label for="at1">전체</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="00">
										<label for="at1">회원(흙수저)</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="01">
										<label for="at1">동수저</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="02">
										<label for="at1">은수저</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="03">
										<label for="at1">금수저</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>제목</th>
							<td>
								<input type="text" id="pnsTitle" name="pnsTitle" title="제목" placeholder="제목을 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>내용</th>
							<td>
								<textarea id="pnsCont" name="pnsCont" rows="5" cols="10" placeholder="내용을 입력 하세요.(128byte로 제한)"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 랜더링유무</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optRenderingYn" checked="checked" value="Y">
										<label for="at1">유</label>
									</li>
									<li>
										<input type="radio" name="optRenderingYn" value="N">
										<label for="at2">무</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row">연결 URL</th>
							<td>
								<input type="text" id="renderingUrl" name="renderingUrl" title="연결URL" placeholder="URL을 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row">이미지</th>
							<td>
								※ 이미지를 입력할 경우 "내용"은 한줄로 간략하게 적어주세요(이미지가 포함된 Push의 내용은 1줄 이상 표현되지 않습니다.)</br></br>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="imgFile" name="imgFile" onchange="setFilename('imageFile',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile">
								</div>
								<!-- <input type="text" id="imgUrl" name="imgUrl" title="이미지URL" placeholder="이미지 URL을 입력해 주세요."> -->								
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/CM/PU/PU01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
		</div>

	</div>
</body>
</html>