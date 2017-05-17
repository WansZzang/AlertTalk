<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 광고관리 > Top</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/AM/PO/PO05"/>',
						data: 'seqNo=${item.seqNo}',
						error:function(data){
							alert('삭제 실패했습니다.\nresponseText : ' + data.responseText);
						},
						success:function(data){
							alert('삭제되었습니다.');
							location.href = '<c:url value="/AM/TO/TO01"/>';
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
		<a href="#none" class="home">광고관리</a> &gt;
		<a href="#none" >Top</a> &gt;
		<strong>Top 상세</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>Top 상세</h2>
			<p>Top<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="linkType"/>
				<input type="hidden" name="areaCd" value="${AREA_TYPE}"/>
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showNo" placeholder="순서를 입력해 주세요." value="${item.showNo}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" value="Y" <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if>  disabled="disabled">
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N" value="Y" <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if>  disabled="disabled">
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="title" placeholder="제목을 입력해 주세요." value="${item.title }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게시일</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value="${item.startDt }" readonly="readonly"></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value="${item.endDt }" readonly="readonly"></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>이미지</th>
							<td>
								<c:if test="${item.contImgUrl ne null }">
									<img src="${item.contImgUrl}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile" name="contImgFile" onchange="setFilename('imageFile',this);"  disabled="disabled">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> URL</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optLinkType" value="I" disabled="disabled" <c:if test="${item.linkType eq 'I'}">checked='checked'</c:if> >
										<label for="at1">내부링크</label>
									</li>
									<li>
										<input type="radio" name="optLinkType" value="O" disabled="disabled" <c:if test="${item.linkType eq 'O'}">checked='checked'</c:if> >
										<label for="at2">외부링크</label>
									</li>
								</ul>
								<input type="text" title="URL" name="adUrl" placeholder="배너를 클릭 시 이동할 URL을 입력해 주세요." value="${item.adUrl }" readonly="readonly">
							</td>
						</tr>
					</tbody>
				</table>
				<br/>
				<br/>
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"> 게임광고주 ID</th>
							<td>
								<input type="text" title="게임광고주 ID" name="adId" placeholder="ID를 입력해 주세요." readonly="readonly" value="${item.adId }">
							</td>
						</tr>
						<tr>
							<th scope="row"> 게임광고주 PW</th>
							<td>
								<input type="password" title="게임광고주 PW" name="adPw" placeholder="PW를 입력해 주세요." readonly="readonly" value="${item.adPw }">
							</td>
						</tr>
					</tbody> 
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/AM/TO/TO01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
			<a href="<c:url value="/AM/TO/TO04"/>?seqNo=${item.seqNo}" class="btn-black2">수정</a>
		</div>

	</div>

</body>
</html>