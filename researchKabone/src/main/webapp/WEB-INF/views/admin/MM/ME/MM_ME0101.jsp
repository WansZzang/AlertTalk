<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 사용자 관리 > 사용자 목록</title>
	<script>
		$(function(){
			
			//상세보기(탈퇴, 재가입, 수정가능)
			$(document).on('click','table > tbody > tr > td:nth-child(1)', function(){
				var _userId = $(this).data('userid');
				//alert(_userNo);
				location.href = '<c:url value="/MM/ME/ME02"/>?userId=' + _userId;
			});
			
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/MM/ME/ME01" />').submit();
				return false;
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/MM/ME/ME06" />').submit();			
				return false;
			});
			
			//20161026 ycyu add > IMEI조회
			$(document).on('click', '.btnSearchIMEI', function(){
				
				var imei = $(this).data('imei');
				if(imei == null || imei == ""){
					alert("유효하지 않은 IMEI정보입니다.(null 또는 없음)");
					return false;
				}
				
				window.open('<c:url value="ME01" />?imei=' + imei, '_blank');
			});
		});
		
		$(document).ready(function(){
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">사용자 관리</a> 
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>사용자 관리</h2>
			<p>사용자를 관리합니다.<span class=""></span></p>
		</div>
		<!-- search -->
		<%-- <div class="search">
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
										<select title="회원상태" id="userTy" name="userTy">
											<option value="">회원상태</option>
											<option value="01" <c:if test="${param.userTy == 'ADMIN'}">selected</c:if> >관리자</option>
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
											<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >EMAIL</option>
											<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >닉네임</option>
											<option value="3" <c:if test="${param.searchType2 == '3'}">selected</c:if> >전화번호</option>
											<option value="4" <c:if test="${param.searchType2 == '4'}">selected</c:if> >이름</option>
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
				<!-- <button type="button" class="btn-simple excel" id="excelBtn"><span>EXCEL</span></button> -->
			</fieldset>
			<div class="total-status"> 
				<em class="total">Total : </em>
				<span class="value">${totalRecordCount}</span>
				<em class="page">Page : </em>
				<span class="value"><span class="curr">${currentPage}</span>/${totalPageCount}</span>
			</div>
			</form>
		</div> --%>
		<div class="ar">
			<span style="color:red;">※ ID 클릭시 수정 화면으로 이동합니다.</span>
		</div>
		<!-- 테이블 목록 -->
		<div class="table-list-type1">
			<table>
				<caption></caption>
				<colgroup>
					<col style="width:15%;"/>
					<col style="width:15%;"/>
					<col style="width:15%;"/>
					<col style="width:15%;"/>
					<col style="width:20%;"/>
					<col style="width:20%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">사용자 ID</th>
						<th scope="col">이름</th>
						<th scope="col">EMAIL</th>
						<th scope="col">전화번호</th>
						<th scope="col">가입일</th>
						<th scope="col">수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td data-userid="${item.userId}"><a href="#">${item.userId}</a>
									</td>
									<td>${item.userNm}
									</td>
									<td>${item.email }</td>
									<td>${item.mobNo }</td>
									<td>${item.regDtm}</td>
									<td>${item.modDtm}</td>
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
			<a href="#" class="btn-black2 btnAdd">사용자 등록</a>
		</div>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
</body>
</html>