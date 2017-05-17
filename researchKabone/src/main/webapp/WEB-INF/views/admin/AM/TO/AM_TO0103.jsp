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
			$('#gameSelBtn').click(function(){
				//주소록 검색창 팝업
				$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
				showLayer($(this), 'gameListPopup');
			});
			$('.btnsave').click(function(){
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				$('input[name=linkType]').val($('input[name=optLinkType]:checked').val());
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				if ( $('input[name=title]').val() == ''){
					alert('제목을 입력하세요.');
					return false;
				}
				
				if ( $('input[name=contImgFile]').val() == ''){
					alert('이미지를 선택하세요..');
					return false;
				}
				
				if ( $('input[name=adUrl]').val() == ''){
					alert('URL을 입력하세요.');
					return false;
				}

				$.ajax({
	                url: '<c:url value="/AM/PO/PO03"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                    alert("성공!!");
	                    location.href = '<c:url value="/AM/TO/TO02"/>?seqNo=' + result.seqNo;
	                },
	                error: function(){
	                	alert("등록 중 오류가 발생하였습니다.");
	                }
	            });
				
			});
			
		});
		function selectGame(_seqNo, _lang, _gameName, _gamePacNm){
			$('input[name=gameNm]').val(_gameName);
			$('input[name=gameSeq]').val(_seqNo);
			
			$('#popupIfrm').attr('src','');
			//close popup
			$('.btnPopClose').click();
		}
		$(document).ready(function(){
			
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">광고관리</a> &gt;
		<a href="#none" >Top</a> &gt;
		<strong>Top 등록</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>Top 등록</h2>
			<p>Top을 등록합니다..<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="linkType"/>
				<input type="hidden" name="areaCd" value="${AREA_TYPE}"/>
				<input type="hidden" name="gameSeq"/>
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
									<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly">
									<a href="#none" class="btn-gray" id="gameSelBtn">게임선택</a>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showNo" placeholder="순서를 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" checked="checked" value="Y">
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N">
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="title" placeholder="제목을 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게시일</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value=""></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value=""></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>이미지</th>
							<td>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile" name="contImgFile" onchange="setFilename('imageFile',this);">
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
										<input type="radio" name="optLinkType" checked="checked" value="I">
										<label for="at1">내부링크</label>
									</li>
									<li>
										<input type="radio" name="optLinkType" value="O">
										<label for="at2">외부링크</label>
									</li>
								</ul>
								<input type="text" title="URL" name="adUrl" placeholder="배너를 클릭 시 이동할 URL을 입력해 주세요.">
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
								<input type="text" title="게임광고주 ID" name="adId" placeholder="ID를 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"> 게임광고주 PW</th>
							<td>
								<input type="password" title="게임광고주 PW" name="adPw" placeholder="PW를 입력해 주세요.">
							</td>
						</tr>
					</tbody> 
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/AM/TO/TO01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
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