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
	<title>홈 > 도전과제</title>
	
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
			$('.btnAdd').click(function(){
				location.href = '<c:url value="/DM/DM03"/>';
			});
			
			
			$(document).on('click','table > tbody > tr > td:nth-child(5)', function(){
				var _seqNo = $(this).data('seq');
				
				location.href = '<c:url value="/DM/DM04"/>?seqNo=' + _seqNo;
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
					$("#searchForm").attr('action', '<c:url value="/DM/DM01" />').submit();
				}else if(listType == 2){
					$("#searchForm").attr('action', '<c:url value="/DM/DM11" />').submit();
				}else if(listType == 3){
					$("#searchForm").attr('action', '<c:url value="/DM/DM21" />').submit();
				}else{
					$("#searchForm").attr('action', '<c:url value="/DM/DM31" />').submit();
				}
				
				return false;
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				var listType = $('input[name=listType]').val();
				if(listType == 1){
					$("#searchForm").attr('action', '<c:url value="/DM/DM06?listType=1" />').submit();	
				}else if(listType == 2){
					$("#searchForm").attr('action', '<c:url value="/DM/DM06?listType=2" />').submit();
				}else if(listType == 3){
					$("#searchForm").attr('action', '<c:url value="/DM/DM06?listType=3" />').submit();
				}else{
					$("#searchForm").attr('action', '<c:url value="/DM/DM06?listType=4" />').submit();
				}
							
				return false;
			});
			
			//20161026 ycyu add > 캠페인 노출순서 변경
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
						url: '<c:url value="/DM/DM1010"/>',
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
			
			$(document).on('click', '.btnRegMenualCert', function(){
				var missionSeq = $(this).data('seq');
				
				//alert(missionSeq);
								
				$('#popupIfrm').ready(function () {
					showLayer($('.btnRegMenualCert'), 'menualCertPop');
				});
				$('#popupIfrm').attr('src', '<c:url value="/popup/DM/DM0902"/>?missionSeq=' + missionSeq); 
			});
		});
		
		$(document).ready(function(){
			
			//20161026 ycyu add > 드래그앤드랍
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
		<a href="#none" class="home">도전과제</a> 
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>도전과제</h2>
			<p>도전과제를 관리합니다.<span class=""></span></p>
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
											<option value="2" <c:if test="${params.searchType2 == '2'}">selected</c:if> >게임명</option>
											<option value="1" <c:if test="${params.searchType2 == '1'}">selected</c:if> >제목</option>
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
					<col style="width:5%;"/>
					<col style="width:8%;"/>
					<col style="width:*;"/>
					<col style="width:8%;"/>
					<col style="width:8%;"/>
					<col style="width:8%;"/>
					<col style="width:5%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:5%;"/>
					<col style="width:8%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">등급</th>
						<th scope="col">이미지</th>
						<th scope="col">게임명</th>
						<th scope="col">제목</th>
						<th scope="col">등록일자</th>
						<th scope="col">유효기간</th>
						<th scope="col">노출기간</th>
						<th scope="col">등록자</th>
						<th scope="col">노출여부</th>
						<th scope="col">노출순서</th>
						<th scope="col">참여수</th>
						<th scope="col">수동인증</th>
						<th scope="col">코드1</th>
						<th scope="col">코드2</th>
						<th scope="col">코드3</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="mission" items="${list}" varStatus="status">
								<tr>
									<%-- <td>${mission.seqNo}</td> --%>
									<td>										
										${mission.seqNo}</br>
										<c:if test="${mission.recommendYn eq 'Y' }">
											(추천)</br>
										</c:if>
										<c:if test="${today > mission.endDt }">
											(종료)</br>
										</c:if>
									</td>
									<td>
										<c:choose>
											<c:when test="${mission.ageLimit == 0}">
												<img src="/admin/common/images/main_visual_icon1.png" style="width:40px;"/>
											</c:when>
											<c:when test="${mission.ageLimit == 12}">
												<img src="/admin/common/images/main_visual_icon2.png" style="width:40px;"/>
											</c:when>
											<c:when test="${mission.ageLimit == 15}">
												<img src="/admin/common/images/main_visual_icon3.png" style="width:40px;"/>
											</c:when>
											<c:when test="${mission.ageLimit == 18}">
												<img src="/admin/common/images/main_visual_icon4.png" style="width:40px;"/>
											</c:when>
											<c:otherwise>
												?
											</c:otherwise>
										</c:choose>
									
									</td>
									<td><img src="${mission.game.gameThumUrl }" style="width:60px;"/></td>
									<td>${mission.game.gameNm }</td>
									<td class="view" data-seq="${mission.seqNo}"><a href="#">${mission.missionTitle}</a></td>
									<td>${mission.createDt }</td>
									<td>${mission.validDt }</td>
									<td>
										${mission.startDt }
										<br />~${mission.endDt }
									</td>
									<td>${mission.modRegId}</td>
									<td>${mission.showYn eq 'Y'?"노출":"비노출" }</td>
									<td>${mission.showOrder }</td>
									<td>${mission.missionCompCnt}</td>
									<td>
										<button class="btn-black2 btnRegMenualCert" data-seq="${mission.seqNo}"><span>수동인증</span></button>
									</td>	
									
									<td>
										<c:choose>
											<c:when test="${mission.coupon.codeType1Yn eq 'Y' && mission.coupon.codeType1Tcnt > 0 }">
												${mission.coupon.codeType1Ucnt}/${mission.coupon.codeType1Tcnt}
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${mission.coupon.codeType2Yn eq 'Y' && mission.coupon.codeType2Tcnt > 0 }">
												${mission.coupon.codeType2Ucnt}/${mission.coupon.codeType2Tcnt}
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${mission.coupon.codeType3Yn eq 'Y' && mission.coupon.codeType3Tcnt > 0 }">
												${mission.coupon.codeType3Ucnt}/${mission.coupon.codeType3Tcnt}
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
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

		<!-- <div class="btn-area ar">
			<a href="#" class="btn-black2 btnAdd">등록</a>
		</div> -->
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
	
<div id="menualCertPop" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">도전과제 > 수동인증</h2>
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

<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>

</body>
</html>