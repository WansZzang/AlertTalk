<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>팝업 > 미션리스트</title>
	<script>
		$(function(){
			$(document).on('click','.useyn', function(){
				var _seqNo = $(this).parent().parent().data('seq');
				var _missionName = $(this).parent().parent().data('title');
				var _validDt = $(this).parent().parent().data('vdt');
				var _startDt = $(this).parent().parent().data('sdt');
				var _endDt = $(this).parent().parent().data('edt');
				
				var _gameSeq = $(this).parent().parent().data('gameseq');
				var _gameNm = $(this).parent().parent().data('gamenm');
				var _goldCouponSeq = $(this).parent().parent().data('gcouponseq');
				
				parent.selectMission(_seqNo, _missionName, _validDt, _startDt, _endDt, _gameSeq, _gameNm, _goldCouponSeq);		
				
				var _ageLimit = $(this).parent().parent().data('age');
				parent.selectGameAgeLimit(_ageLimit);
				
			});
			
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/popup/DM/DM01" />').submit();
				return false;
			});
		});
		
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	
	<div class="inner-cont">
		<form class="search" role="form" name="searchForm" id="searchForm" method="POST">
		<!-- search -->
		<fieldset>
			<legend>검색</legend>
			<!-- 상세검색 -->
			<div class="search-detail" role="popover">
				<div class="inner">
					<div class="pop-content">
						<div class="search-select">
							<div class="select-row1">
								<span class="search-group">
									<select title="검색대상" name="searchType2" id="searchType2">
										<option value="">검색대상</option>
										<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >미션타이틀</option>
										<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >게임명</option>
									</select>
								</span>
								<span class="search-group fullwidth">
									<input name="searchWords" id="searchWords" value="${param.searchWords}" type="text" class="keyword" placeholder="검색어를 입력해주세요.">
								</span>
								<div class="btn-group">
									<button type="submit" class="btn-black2 popover-close" id="searchBtn"><span>검색하기</span></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
		<div class="total-status">
			<em class="total">Total : </em>
			<span class="value">${totalRecordCount}</span>
			<em class="page">Page : </em>
			<span class="value"><span class="curr">${currentPage}</span>/${totalPageCount}</span>
		</div>
		</form>
	</div>

	<!-- 테이블 목록 -->
	<div class="table-list-type1">
		<table>
			<caption></caption>
			<colgroup>
				<col style="width:8%;"/>
				<col style="width:8%;"/>
				<col style="width:15%;"/>
				<col style="width:*;"/>
				<col style="width:15%;"/>
				<col style="width:12%;"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">이미지</th>
					<th scope="col">게임명</th>
					<th scope="col">타이틀</th>
					<th scope="col">등록일자</th>
					<th scope="col">등록자</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${fn:length(list) > 0 }">
						<c:forEach var="item" items="${list}" varStatus="status">
							<tr data-seq="${item.seqNo}" data-title="${item.missionTitle }" data-vdt="${item.validDt }" data-sdt="${item.startDt }" data-edt="${item.endDt }" 
								data-gameseq="${item.gameSeq }" data-gamenm="${item.game.gameNm }" data-gcouponseq="${item.coupon.seqNo }" data-age="${item.game.ageLimit }" >
							
								<td><input type="radio" name="rdoUseYn" value="Y" class="useyn" /></td>
								<td><img src="${item.game.gameThumUrl }" style="width:60px;"/></td>
								<td>${item.game.gameNm }</td>
								<td>${item.missionTitle }</td>
								<td>${item.createDt }</td>
								<td>${item.modRegId }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">조회 결과가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<!-- 페이징 -->
	<%@include file="/WEB-INF/views/include/paging.jsp" %>

</body>
</html>