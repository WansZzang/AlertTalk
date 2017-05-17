<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 푸쉬관리 > PUSH 메시지 발송 내역</title>
	<script>
		$(function(){
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/CM/PU/PU01" />').submit();
				return false;
			});
			
			$(document).on('click','tr > td:nth-child(4)', function(){
				var _pnsId = $(this).data('seq');
				
				location.href = '<c:url value="/CM/PU/PU02"/>?pnsId=' + _pnsId;
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/CM/PU04" />').submit();			
				return false;
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
		<!-- search -->
		<div class="search">
			<form class="search" role="form" name="searchForm" id="searchForm" method="POST">	
			<fieldset>
				<legend>검색</legend>
				<!-- 상세검색 -->
				<div class="search-detail" role="popover">
					<div class="inner">
						<div class="pop-content">
							<div class="search-select">
								<div class="select-row1">
									<span class="search-group">
										<select title="PNS타입" name="pnsType" id="pnsType">
											<option value="">PNS타입</option>
											<option value="CO" <c:if test="${param.pnsType == 'CO'}">selected='selected'</c:if> >쿠폰</option>
											<option value="EV" <c:if test="${param.pnsType == 'EV'}">selected='selected'</c:if> >이벤트</option>
											<option value="NT" <c:if test="${param.pnsType == 'NT'}">selected='selected'</c:if> >공지사항</option>
											<option value="UP" <c:if test="${param.pnsType == 'UP'}">selected='selected'</c:if> >업데이트</option>
											<option value="NP" <c:if test="${param.pnsType == 'NP'}">selected='selected'</c:if> >새게시글</option>
											<option value="NR" <c:if test="${param.pnsType == 'NR'}">selected='selected'</c:if> >새댓글</option>
											<option value="NC" <c:if test="${param.pnsType == 'NC'}">selected='selected'</c:if> >새채팅글</option>
										</select>
									</span>
									<span class="search-group">
										<select title="전송상태" name="sendStat" id="sendStat">
											<option value="">전송상태</option>
											<option value="W" <c:if test="${param.sendStat == 'W'}">selected</c:if> >대기</option>
											<option value="S" <c:if test="${param.sendStat == 'S'}">selected</c:if> >발송</option>
											<option value="F" <c:if test="${param.sendStat == 'F'}">selected</c:if> >실패</option>
											<option value="E" <c:if test="${param.sendStat == 'E'}">selected</c:if> >대상없음</option>
										</select>
									</span>
								</div>
								<div class="select-row2">
									<span class="search-group">
										<select title="기준기간" name="searchTermBasisType" id="searchTermBasisType">
											<option value="">기준기간</option>
											<option value="1" <c:if test="${param.searchTermBasisType == '1'}">selected</c:if> >등록일</option>
										</select>
									</span>
									<span class="search-group">
										<select title="검색기간" name="searchTermType" id="searchTermType" onchange="javascript:setSearchTermType(this.value);">
											<option value="">검색기간</option>
											<option value="1" <c:if test="${param.searchTermType == '1'}">selected</c:if> >전체기간</option>
											<option value="2" <c:if test="${param.searchTermType == '2'}">selected</c:if> >어제</option>
											<option value="3" <c:if test="${param.searchTermType == '3'}">selected</c:if> >오늘</option>
											<option value="4" <c:if test="${param.searchTermType == '4'}">selected</c:if> >1주일</option>
											<option value="5" <c:if test="${param.searchTermType == '5'}">selected</c:if> >1개월</option>
											<option value="6" <c:if test="${param.searchTermType == '6'}">selected</c:if> >3개월</option>
											<option value="7" <c:if test="${param.searchTermType == '7'}">selected</c:if> >6개월</option>
											<option value="8" <c:if test="${param.searchTermType == '8'}">selected</c:if> >1년</option>
											<option value="9" <c:if test="${param.searchTermType == '9'}">selected</c:if> >직접입력</option>
										</select>
									</span>
									<span class="search-group"><input type="text" id="searchStartDt" name="searchStartDt" title="날짜선택" class="hasDatepicker" value="${fn:substring(param.searchStartDt,0,10)}"></span>
									<span class="search-p"> ~ </span>
									<span class="search-group"><input type="text" id="searchEndDt" name="searchEndDt" title="날짜선택" class="hasDatepicker" value="${fn:substring(param.searchEndDt,0,10)}"></span>
								</div>
								<div class="select-row3">
									<span class="search-group">
										<select title="검색대상" name="searchType2" id="searchType2">
											<option value="">검색대상</option>
											<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >제목</option>
											<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >내용</option>
										</select>
									</span>
									<span class="search-group fullwidth">
										<input name="searchWords" id="searchWords" value="${param.searchWords}" type="text" class="keyword" placeholder="검색어를 입력해주세요.">
									</span>
									<div class="btn-group">
										<button type="submit" class="btn-black2 popover-close" id="searchBtn"><span>검색하기</span></button>
										<button type="submit" class="btn-simple2" id="resetBtn"><span>초기화</span></button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //상세검색 -->
				<button type="button" class="btn-simple excel" id="excelBtn"><span>EXCEL</span></button>
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
					<col style="width:15%;"/>
					<col style="width:10%;"/>
					<col style="width:*;"/>
					<col style="width:15%;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">PNS 타입</th>
						<th scope="col">받는사람(그룹)</th>
						<th scope="col">PNS(메시지)제목</th>
						<th scope="col">발송일시</th>
						<th scope="col">발송건수</th>
						<th scope="col">전송상태</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr data-pnsid="${item.pnsId}" >
									<td>${item.pnsId}</td> 
									<td>
									 	<c:choose>
									 		<c:when test="${item.pnsType eq 'CO' }">쿠폰</c:when>
									 		<c:when test="${item.pnsType eq 'EV' }">이벤트</c:when>
									 		<c:when test="${item.pnsType eq 'NT' }">공지사항</c:when>
									 		<c:when test="${item.pnsType eq 'UP' }">업데이트</c:when>
									 		<c:when test="${item.pnsType eq 'NP' }">새게시글</c:when>
									 		<c:when test="${item.pnsType eq 'NR' }">새댓글</c:when>
									 		<c:when test="${item.pnsType eq 'NC' }">새채팅글</c:when>
									 	</c:choose>
									</td>
									<td>
										<c:choose>
									 		<c:when test="${item.targetUserLevel eq '00' }">회원(흙수저)</c:when>
									 		<c:when test="${item.targetUserLevel eq '01' }">동수저</c:when>
									 		<c:when test="${item.targetUserLevel eq '02' }">은수저</c:when>
									 		<c:when test="${item.targetUserLevel eq '03' }">금수저</c:when>
									 		<c:when test="${item.targetUserLevel eq '99' }">전체</c:when>
									 	</c:choose> 
									</td>
									<td data-seq="${item.pnsId}" ><a href="#" >${item.pnsTitle }</a></td>
									<td>${item.createDt }</td>
									<td>${item.sendCnt }</td>
									<td>
										<!-- W: 대기, S: 발송, F: 실패 , E: 대상없음 -->
										<c:choose>
									 		<c:when test="${item.sendStat eq 'W' }">대기</c:when>
									 		<c:when test="${item.sendStat eq 'S' }">발송</c:when>
									 		<c:when test="${item.sendStat eq 'F' }">실패</c:when>
									 		<c:when test="${item.sendStat eq 'E' }">대상없음</c:when>
									 	</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7">조회 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<div class="btn-area ar">
			<a href="/CM/PU/PU03" class="btn-black2">등록하기</a>
		</div>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
</body>
</html>