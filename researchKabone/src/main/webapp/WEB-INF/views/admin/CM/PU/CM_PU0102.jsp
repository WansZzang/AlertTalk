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
								<select title="PNS타입" id="selPnsType" disabled="disabled">
									<option value="CO" <c:if test="${item.pnsType == 'CO'}">selected='selected'</c:if> >쿠폰</option>
									<option value="EV" <c:if test="${item.pnsType == 'EV'}">selected='selected'</c:if> >이벤트</option>
									<option value="NT" <c:if test="${item.pnsType == 'NT'}">selected='selected'</c:if> >공지사항</option>
									<option value="UP" <c:if test="${item.pnsType == 'UP'}">selected='selected'</c:if> >업데이트</option>
									<option value="NP" <c:if test="${item.pnsType == 'NP'}">selected='selected'</c:if> >새게시글</option>
									<option value="NR" <c:if test="${item.pnsType == 'NR'}">selected='selected'</c:if> >새댓글</option>
									<option value="NC" <c:if test="${item.pnsType == 'NC'}">selected='selected'</c:if> >새채팅글</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 받는사람</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optTargetUserLevel" value="99" <c:if test="${item.targetUserLevel == '99'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at1">전체</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="00" <c:if test="${item.targetUserLevel == '00'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at1">회원(흙수저)</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="01" <c:if test="${item.targetUserLevel == '01'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at1">동수저</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="02" <c:if test="${item.targetUserLevel == '02'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at1">은수저</label>
									</li>
									<li>
										<input type="radio" name="optTargetUserLevel" value="03" <c:if test="${item.targetUserLevel == '03'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at1">금수저</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>제목</th>
							<td>
								<input type="text" id="pnsTitle" name="pnsTitle" title="제목" placeholder="제목을 입력해 주세요." value="${item.pnsTitle }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>내용</th>
							<td>
								<textarea id="pnsCont" name="pnsCont" rows="5" cols="10" placeholder="내용을 입력 하세요.(128byte로 제한)" disabled="disabled">${item.pnsCont }</textarea>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 랜더링유무</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optRenderingYn" value="Y" <c:if test="${item.renderingYn == 'Y'}">checked='checked'</c:if> disabled="disabled">
										<label for="at1">유</label>
									</li>
									<li>
										<input type="radio" name="optRenderingYn" value="N" <c:if test="${item.renderingYn == 'N'}">checked='checked'</c:if> disabled="disabled">
										<label for="at2">무</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row">연결 URL</th>
							<td>
								<input type="text" id="renderingUrl" name="renderingUrl" title="연결URL" placeholder="URL을 입력해 주세요." value="${item.renderingUrl}" disabled="disabled">
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 URL</th>
							<td>
								<input type="text" id="imgUrl" name="imgUrl" title="이미지URL" placeholder="이미지 URL을 입력해 주세요." value="${item.imgUrl}" disabled="disabled">
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