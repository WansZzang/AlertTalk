<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

<head>
	<title>홈 > 금수저 쿠폰 > 예정게임</title>
	
	<style type="text/css">
		.wrap-loading{
			position:fixed;
			left:0;
			right:0;
			top:0;
			bottom:0;
			background: rgba(0,0,0,0,2);
			filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');
		}
		.wrap-loading div{
			position:fixed;
			top:50%;
			left:50%;
			margin-left:-21px;
			margin-top:-21px; 
		}
		.display-none{
			display:none;
		}	
	</style>
	
	<script>
		$(function(){
			//등록하기
			$('.btnAdd').click(function(){
				location.href = '<c:url value="/GM/CS/CS03"/>';
			});
			
			//상세페이지
			$(document).on('click','table > tbody > tr > td:nth-child(4)', function(){
				var _seqNo = $(this).data('seq');
				
				location.href = '<c:url value="/GM/CS/CS04"/>?seqNo=' + _seqNo;
			});
			
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				var listType = $('input[name=listType]').val();
				if(listType == 1){
					$("#searchForm").attr('action', '<c:url value="/GM/CS/CS01" />').submit();	
				}else{
					$("#searchForm").attr('action', '<c:url value="/GM/CS/CS11" />').submit();
				}
				
				return false;
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				var listType = $('input[name=listType]').val();
				if(listType == 1){
					$("#searchForm").attr('action', '<c:url value="/GM/CS/CS06" />?areaCd=PO&listType=1').submit();
				}else{
					$("#searchForm").attr('action', '<c:url value="/GM/CS/CS06" />?areaCd=PO&listType=2').submit();
				}
				return false;
			});
			
			
			//예정게임 노출순서 변경
			$("#sortSaveBtn").bind("click", function(){
				var obj = document.getElementsByClassName("view");
								
				var _datas = "1=1";
				if( obj.length >= 2 ){
			    	var orderList = "";
			    	for(var i=0; i<obj.length; i++){
			    		_datas += "&seqNos=" + obj[i].getAttribute('data-seq');
			    	}
			    	
			    	$.ajax({ 
						type: 'POST',
						url: '<c:url value="/GM/CS/CS07"/>',
						data: _datas,
						error:function(data){
							$('.wrap-loading').addClass('display-none');
							var _errData = $.parseJSON(xhr.responseText);
							
		                	alert("저장중 오류가 발생하였습니다.\n(원인:" + _errData.error.message + ")");
		                	alert(xhr.responseText);
		                	alert(data.message);			                	
						},
						success:function(result){
							$('.wrap-loading').addClass('display-none');
							alert("저장 되었습니다.");		
							location.reload();
						}
						,beforeSend:function(){
		                	$('.wrap-loading').removeClass('display-none');
		                }
		                ,complete:function(){
		                	$('.wrap-loading').addClass('display-none');
		                }
					});
			    	
			   	}else{
			   		alert('저장할 리스트 개수가 부족합니다. 2개 이상일 경우 저장이 가능합니다.');
			   	}
				
				return false;
			});
			
		});
		
		$(document).ready(function(){
			//드래그앤드랍
			var listType = $('input[name=listType]').val();
			if(listType == 1 && isMobile() == 'nomobile'){
				$("table").tableDnD({
					onDragClass: "dragRow"
				});
			}
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">금수저 쿠폰</a> &gt;
		<strong>예정게임</strong>
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>예정게임</h2>
			<p>예정게임을 관리합니다.<span class=""></span></p>
		</div>
		
		<input type="hidden" name="listType" value="${params.listType }"/>
		
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
											<option value="Y" <c:if test="${params.showYn == 'Y'}">selected</c:if> >노출</option>
											<option value="N" <c:if test="${params.showYn == 'N'}">selected</c:if> >비노출</option>
										</select>
									</span>
								</div>
								<div class="select-row2">
									<span class="search-group">
										<select title="기준기간" name="searchTermBasisType" id="searchTermBasisType">
											<option value="">기준기간</option>
											<option value="1" <c:if test="${params.searchTermBasisType == '1'}">selected</c:if> >등록일</option>
										</select>
									</span>
									<span class="search-group">
										<select title="검색기간" name="searchTermType" id="searchTermType" onchange="javascript:setSearchTermType(this.value);">
											<option value="">검색기간</option>
											<option value="1" <c:if test="${params.searchTermType == '1'}">selected</c:if> >전체기간</option>
											<option value="2" <c:if test="${params.searchTermType == '2'}">selected</c:if> >어제</option>
											<option value="3" <c:if test="${params.searchTermType == '3'}">selected</c:if> >오늘</option>
											<option value="4" <c:if test="${params.searchTermType == '4'}">selected</c:if> >1주일</option>
											<option value="5" <c:if test="${params.searchTermType == '5'}">selected</c:if> >1개월</option>
											<option value="6" <c:if test="${params.searchTermType == '6'}">selected</c:if> >3개월</option>
											<option value="7" <c:if test="${params.searchTermType == '7'}">selected</c:if> >6개월</option>
											<option value="8" <c:if test="${params.searchTermType == '8'}">selected</c:if> >1년</option>
											<option value="9" <c:if test="${params.searchTermType == '9'}">selected</c:if> >직접입력</option>
										</select>
									</span>
									<span class="search-group"><input type="text" id="searchStartDt" name="searchStartDt" title="날짜선택" class="hasDatepicker" value="${fn:substring(params.searchStartDt,0,10)}"></span>
									<span class="search-p"> ~ </span>
									<span class="search-group"><input type="text" id="searchEndDt" name="searchEndDt" title="날짜선택" class="hasDatepicker" value="${fn:substring(params.searchEndDt,0,10)}"></span>
								</div>
								<div class="select-row3">
									<span class="search-group">
										<select title="검색대상" name="searchType2" id="searchType2">
											<option value="">검색대상</option>
											<option value="1" <c:if test="${params.searchType2 == '1'}">selected</c:if> >게임명</option>
										</select>
									</span>
									<span class="search-group fullwidth">
										<input name="searchWords" id="searchWords" value="${params.searchWords}" type="text" class="keyword" placeholder="검색어를 입력해주세요.">
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
				
				<div class="ar">
					<a href="#" class="btn-black2 btnAdd">등록하기</a>
					&nbsp;&nbsp;
					<c:if test="${params.listType == 1}">
						<button type="button" class="btn-blue" id="sortSaveBtn"><span>노출순서 저장</span></button>
						&nbsp;&nbsp;
					</c:if>
					<button type="button" class="btn-simple excel" id="excelBtn"><span>EXCEL</span></button>
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
					<col style="width:5%;"/>
					<col style="width:5%;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
					<col style="width:*;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
					<col style="width:5%;"/>
					<col style="width:8%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">등급</th>
						<th scope="col">썸네일</th>
						<th scope="col">게임명</th>
						<th scope="col">라이브예정</th>
						<th scope="col">설명</th>
						<th scope="col">등록일자</th>
						<th scope="col">노출기간</th>
						<th scope="col">등록자</th>
						<th scope="col">노출순서</th>
						<th scope="col">노출여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td>
										${item.seqNo}
										<c:if test="${today > item.endDt }">
											</br>(종료)
										</c:if>
									</td>		
									<td>
										<c:choose>
											<c:when test="${item.ageLimit == 0}">
												<img src="/admin/common/images/main_visual_icon1.png" style="width:40px;"/>
											</c:when>
											<c:when test="${item.ageLimit == 12}">
												<img src="/admin/common/images/main_visual_icon2.png" style="width:40px;"/>
											</c:when>
											<c:when test="${item.ageLimit == 15}">
												<img src="/admin/common/images/main_visual_icon3.png" style="width:40px;"/>
											</c:when>
											<c:when test="${item.ageLimit == 18}">
												<img src="/admin/common/images/main_visual_icon4.png" style="width:40px;"/>
											</c:when>
											<c:otherwise>
												?
											</c:otherwise>
										</c:choose>				
									</td>					
									<td><img <c:if test="${item.thumbUrl ne null and item.thumbUrl ne '' }">src="${item.thumbUrl}"</c:if> style="width:50px"></td>
									<td class="view" data-seq="${item.seqNo}"><a href="#">${item.gameNm}</a></td>
									<td>${item.schedule }</td>
									<td>${item.discription }</td>
									<td>${item.createDt }</td>
									<td>${item.startDt }</br>~${item.endDt }</td>
									<td>${item.modRegId}</td>
									<td>${item.showOrder}</td>
									<td>${item.showYn eq 'Y'?"노출":"비노출" }</td>
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

		<!-- <div class="btn-area ar">
			<a href="#" class="btn-black2 btnAdd">등록</a>
		</div> -->
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
	

<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>
	
	
</body>
</html>