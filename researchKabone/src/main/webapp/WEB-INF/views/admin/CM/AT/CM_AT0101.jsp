<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 공략정보</title>
	<script>
		$(function(){
			$('.btnAdd').click(function(){
				location.href = '<c:url value="/CM/AT/AT03"/>';
			});
			
			$('.btnDel').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('삭제할 공략정보를 선택하세요.');
				}else{
					if ( confirm("삭제하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건]")){
						var _datas = "1=1";
						$('input[name=chkSeq]:checked').each(function(idx, item){
							_datas += "&seqNos=" + $(this).data('seq');
						});
						
						$.ajax({ 
							type: 'POST',
							url: '<c:url value="/CM/AT/AT05"/>',
							data: _datas,
							error:function(data){
								alert("<spring:message code='ui.delete.alert.failure'/>");
								console.log('status change fail');	
								console.log(data);
							},
							success:function(result){
								alert("<spring:message code='ui.delete.alert.success'/>");
								location.reload();
							}
						});	
					}
				}
			});
			
			$(document).on('click','tr > td:nth-child(4)', function(){
				var _seqNo = $(this).data('seq');
				
				location.href = '<c:url value="/CM/AT/AT04"/>?seqNo=' + _seqNo;
			});
			
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/CM/AT/AT01" />').submit();
				return false;
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/CM/AT06" />').submit();			
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
		<strong>공략정보</strong>
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>공략정보</h2>
			<p>공략정보를 관리합니다.<span class=""></span></p>
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
										<select title="노출여부" id="showYn" name="showYn">
											<option value="">전체</option>
											<option value="Y" <c:if test="${param.showYn == 'Y'}">selected</c:if> >사용</option>
											<option value="N" <c:if test="${param.showYn == 'N'}">selected</c:if> >미사용</option>
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
											<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >게임명</option>
											<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >개발사</option>
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
					<col style="width:8%;"/>
					<col style="width:15%;"/>
					<col style="width:*;"/>
					<col style="width:10%;"/>
					<col style="width:15%;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">선택</th>
						<th scope="col">No.</th>
						<th scope="col">게임명</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
						<th scope="col">노출여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td>
										<span class="chk"><input type="checkbox" name="chkSeq" data-seq="${item.seqNo}"></span>
									</td>
									<td>${item.seqNo}</td>
									<td>${item.gameNm }</td>
									<td data-seq="${item.seqNo}"><a href="#">${item.title}</a></td>
									<td>${item.modRegId}</td>
									<td>${item.createDt }</td>
									<td>${item.oneSpoonCnt }</td>
									<td>${item.showYn eq 'Y'?"노출":"비노출" }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="8">조회 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<div class="btn-area ar">
			<a href="#" class="btn-black2 btnDel">삭제</a>
			<a href="#" class="btn-black2 btnAdd">등록</a>
		</div>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
</body>
</html>