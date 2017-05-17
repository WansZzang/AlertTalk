<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 광고관리 > Content</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnsave').click(function(){
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				$('input[name=linkType]').val($('input[name=optLinkType]:checked').val());
				$('#cont').val(CKEDITOR.instances.cont.getData());
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				if ( $('input[name=title]').val() == ''){
					alert('제목을 입력하세요.');
					return false;
				}
				
				
				if ( $('input[name=contImgUrl]').val() == ''){
					alert('이미지를 선택하세요.');
					return false;
				}
				
				if ( $('#cont').val() == ''){
					alert('내용을 입력하세요.');
					return false;
				}
				
				if ( $('input[name=adUrl]').val() == ''){
					alert('URL을 입력하세요.');
					return false;
				}
				
				$.ajax({
	                url: '<c:url value="/AM/PO/PO04"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                    alert("<spring:message code='ui.modify.alert.success'/>");
	                    location.href = '<c:url value="/AM/CO/CO01"/>';
	                },
	                error: function(){
	                	alert("<spring:message code='ui.modify.alert.failure'/>");
	                }
	            });
				
			});
			
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/AM/PO/PO05"/>',
						data: 'seqNo=${item.seqNo}',
						error:function(data){
							//alert('삭제 실패했습니다.\nresponseText : ' + data.responseText);
							alert("<spring:message code='ui.delete.alert.failure'/>");
						},
						success:function(data){
							alert("<spring:message code='ui.delete.alert.success'/>");
							location.href = '<c:url value="/AM/CO/CO01"/>';
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
		<a href="#none" >Content</a> &gt;
		<strong>Content 등록</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>Content 등록</h2>
			<p>Content을 등록합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="linkType"/>
				<input type="hidden" name="areaCd" value="${AREA_TYPE}"/>
				<input type="hidden" name="seqNo" value="${item.seqNo}"/>
				<input type="hidden" name="contImgUrl" value="${item.contImgUrl }"/>
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
								<input type="text" title="노출순서" name="showNo" placeholder="순서를 입력해 주세요." value="${item.showNo}" >
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" value="Y" <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if> >
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N" <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if> >
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="title" placeholder="제목을 입력해 주세요." value="${item.title }" >
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게시일</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value="${item.startDt }" ></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value="${item.endDt }" ></span>
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
										<input type="file" id="contImgFile" name="contImgFile" onchange="setFilename('imageFile',this);" >
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile" >
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 내용</th>
							<td>
								<div class="editor-area">
									<textarea id="cont" name="cont" title="내용">${item.cont}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'cont', {
						                    width:'100%',
						                    height:'200px'
							                ,fontSize_defaultLabel:'12px'
						                });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> URL</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optLinkType" value="I" <c:if test="${item.linkType eq 'I'}">checked='checked'</c:if> >
										<label for="at1">내부링크</label>
									</li>
									<li>
										<input type="radio" name="optLinkType" value="O" <c:if test="${item.linkType eq 'O'}">checked='checked'</c:if> >
										<label for="at2">외부링크</label>
									</li>
								</ul>
								<input type="text" title="URL" name="adUrl" placeholder="배너를 클릭 시 이동할 URL을 입력해 주세요." value="${item.adUrl }" >
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
								<input type="text" title="게임광고주 ID" name="adId" placeholder="ID를 입력해 주세요."  value="${item.adId }">
							</td>
						</tr>
						<tr>
							<th scope="row"> 게임광고주 PW</th>
							<td>
								<input type="password" title="게임광고주 PW" name="adPw" placeholder="PW를 입력해 주세요."  value="${item.adPw }">
							</td>
						</tr>
					</tbody> 
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/AM/CO/CO01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
			<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
		</div>

	</div>

</body>
</html>