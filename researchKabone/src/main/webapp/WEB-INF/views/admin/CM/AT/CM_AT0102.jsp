<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 게임관리</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnsave').click(function(){
				
				$('input[name=country]').val($('#selCountry option:selected').val());
				$('input[name=useYn]').val($('input[name=optUseYN]:checked').val());
				$('#tipComment').val(CKEDITOR.instances.tipComment.getData());
				
				
				var form = $('form')[0];
				var formData = new FormData(form);

				$.ajax({
	                url: '<c:url value="/RM/GM/GM03"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                    alert("성공!!");
	                    location.href = '<c:url value="/RM/GM/GM02"/>?seqNo=' + result.seqNo + '&country=' + result.country;
	                },
	                error: function(){
	                	alert("등록 중 오류가 발생하였습니다.");
	                }
	            });
				
			});
			
			$('#gameSelBtn').click(function(){
				//주소록 검색창 팝업
				showLayer($(this), 'gameListPopup');
			});
		});
		
		$(document).ready(function(){
			
		});
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
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="gameSeq"/>
				<input type="hidden" name="useYn"/>
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
									<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." value="${item.gameNm }" readonly="readonly">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 사용여부</th>
							<td>
								<input type="radio" name="optUseYN" checked="checked" readonly="readonly">
								<label for="at1">
									<c:choose>
									 	<c:when test="${item.showYn eq 'Y'}">사용</c:when>
									 	<c:otherwise>미사용</c:otherwise>
									 </c:choose>
								</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="title" placeholder="제목을 입력해 주세요." value="${item.title }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 내용</th>
							<td>
								<div class="editor-area">
									<textarea id="tipComment" name="tipComment" title="내용">${item.tipComment }</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'tipComment', {
						                    width:'100%',
						                    height:'200px',
						                    readOnly:'true'
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
			<a href="<c:url value="/CM/AT/AT04"/>?seqNo=${item.seqNo}" class="btn-black2">수정</a>
		</div>

	</div>
	
	<!-- 주소록 -->
<div id="gameListPopup" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">게임리스트</h2>
			<div class="search-detail">
				<h3 class="blind">주소분류 1</h3>
				
				<!-- 
				<div class="search-select">
					
					<div class="select-row1 col3">
						<span class="search-group">
							<select title="국가" name="searchType" id="searchType" onchange="javascript:setSearchType(this.value);">
								<option value="ko">한국</option>
								<option value="us">미국</option>
								<option value="ch">중국</option>
								<option value="ja">일본</option>
							</select>
						</span>						
						<span class="search-group">
							<select title="검색대상" name="searchType2" id="searchType2" onchange="javascript:setSearchType(this.value);">
								<option value="gameNm">게임명</option>
								<option value="developer">개발사</option>
							</select>
						</span>
						<span class="search-group">
							<input type="text" placeholder="검색어를 입력해주세요." name="searchWords" id="searchWords">
						</span>
					</div>
				</div>
				
				<div class="btn-group">
					<button type="submit" class="btn-black2" id="searchBtn"><span>검색하기</span></button>
					<button type="submit" class="btn-simple2" id="resetBtn"><span>초기화</span></button>
				</div>
				<h4 class="stit">검색결과</h4>
				<div class="search-list" id="searchList">
					<ul>
						<li><input type="radio" id="sl1" name="searchList"><label for="sl1">영광굴비로 만드는 유기농 된장 개발1</label></li>
						<li><input type="radio" id="sl2" name="searchList"><label for="sl2">영광굴비로 만드는 유기농 된장 개발2</label></li>
						<li><input type="radio" id="sl3" name="searchList"><label for="sl3">영광굴비로 만드는 유기농 된장 개발3</label></li>
					</ul>
				</div>
				-->
				<div class="btn-area">
					<a href="#none" class="btn-black2" id="targetSelectBtn">확인</a>
					<a href="#none" class="btn-black2" id="targetCloseBtn" onclick="hideLayer(this, 'gameListPopup'); return false;">취소</a>
				</div>
			</div>
		</div>
		<button type="button" class="close">레이어팝업 닫기</button>
	</div>
</div>
</body>
</html>