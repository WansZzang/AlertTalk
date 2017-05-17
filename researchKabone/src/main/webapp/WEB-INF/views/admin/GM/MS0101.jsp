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
	<title>홈 > 금수저쿠폰</title>
	
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
			$(document).on('click','tr > td:nth-child(4)', function(){
				var _seqNo = $(this).data('seq');
				
				location.href = '<c:url value="/GM/GM04"/>?seqNo=' + _seqNo;
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
					$("#searchForm").attr('action', '<c:url value="/GM/MS01" />').submit();	
				}else if(listType == 2){
					$("#searchForm").attr('action', '<c:url value="/GM/MS11" />').submit();	
				}else if(listType == 3){
					$("#searchForm").attr('action', '<c:url value="/GM/MS21" />').submit();	
				}else{
					$("#searchForm").attr('action', '<c:url value="/GM/MS31" />').submit();
				}
				
				return false;
			});
			
			//쿠폰등록
			$(document).on('click', '.btnRegCoupon', function(){
					
				var _gameCouponSeq = $(this).data('seq');
				var _codeType = $(this).data('codetype');
				
				$('#popupIfrm').ready(function () {
					showLayer($('.btnRegCoupon'), 'couponRegPop');
				});
				$('#popupIfrm').attr('src', '<c:url value="/popup/GM/GM05"/>?gameCouponSeq=' + _gameCouponSeq + '&codeType=' + _codeType);
			});
			
			//20161013 ycyu add > 쿠폰이관
			$(document).on('click', '.btnCouponMove', function(){
				
				var viewType = $(this).data('viewtype');
				var seqNo = $(this).data('seq');
				var gameSeq = $(this).data('gameseq');
				var destGameCouponSeq = $(this).data('destseq');
				var couponCnt = $(this.parentNode.childNodes[1]).val();	//이관할 쿠폰개수
				var gameNm = $(this).data('gamenm');
				
				if(couponCnt == null || couponCnt == '' || couponCnt == 0){
					alert("이관할 쿠폰개수를 입력하세요!");
						
					return false;
				}
				
				var viewNm = "금수저캠페인";
				var viewNm2 = "도전과제캠페인"; 
				if(viewType == "02"){
					viewNm = "도전과제캠페인";
					viewNm2 = "금수저캠페인";
				}
				
				if(destGameCouponSeq == null || destGameCouponSeq == ""){
					alert(viewNm2 + "이 없습니다!");
					return false;
				}
				
				//var cfmMsg = "[" + gameNm + "]\r\n" + viewNm + "의 쿠폰 " + couponCnt + " 개를\r\n" + viewNm2 + "으로 이관하시겠습니까?"
				var cfmMsg = "[" + gameNm + "]\r\n " + viewNm + " 에서 " + viewNm2 + " 으로 쿠폰이동 ( " + couponCnt + " 개 )\r\n"+ " 하시겠습니까?";
				
				if(confirm(cfmMsg)){
					var _datas = "1=1";
					_datas += '&viewType=' + viewType;
					_datas += '&seqNo=' + seqNo;
					_datas += '&gameSeq=' + gameSeq;
					_datas += '&destGameCouponSeq=' + destGameCouponSeq;
					_datas += '&couponCnt=' + couponCnt;
					//alert(_datas);
					
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/GM/GM10"/>',
						data: _datas,
						error:function(data){
							$('.wrap-loading').addClass('display-none');
							var _errData = $.parseJSON(xhr.responseText);
		                	alert("이관 중 오류가 발생하였습니다.\n(원인:" + _errData.error.message + ")");
		                	alert(xhr.responseText);
		                	alert(data.message);
		                	
						},
						success:function(result){
							$('.wrap-loading').addClass('display-none');
							alert("이관되었습니다.");		
							location.reload();
						}
						,beforeSend:function(){
		                	$('.wrap-loading').removeClass('display-none');
		                }
		                ,complete:function(){
		                	$('.wrap-loading').addClass('display-none');
		                }
					});
				}
				
			});
			
			//excel
			$("#excelBtn").bind("click", function(){
				var listType = $('input[name=listType]').val();
				if(listType == 1){
					$("#searchForm").attr('action', '<c:url value="/GM/GM06?viewType=02&listType=1" />').submit();	
				}else if(listType == 2){
					$("#searchForm").attr('action', '<c:url value="/GM/GM06?viewType=02&listType=2" />').submit();	
				}else if(listType == 3){
					$("#searchForm").attr('action', '<c:url value="/GM/GM06?viewType=02&listType=3" />').submit();	
				}else{
					$("#searchForm").attr('action', '<c:url value="/GM/GM06?viewType=02&listType=4" />').submit();
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
			    		//alert(obj[i].getAttribute('data-seq'));		
			    		_datas += "&seqNos=" + obj[i].getAttribute('data-seq');
			    	}
			    	
			    	//alert(_datas);
			    	
			    	$.ajax({ 
						type: 'POST',
						url: '<c:url value="/GM/GM1010"/>',
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
			//20161013 ycyu add > 쿠폰등록/수정/삭제 결과에 따른 parent window 갱신후 쿠폰등록 팝업시 이전 검색필터가 그대로 남아 있어서 parent window 갱신시 팝업을 초기화하도록 함
			$('#popupIfrm').attr('src','');
			
			//20161027 ycyu del > 도전과제캠페인은 도전과제의 순서에 따름
			//20161024 ycyu add > 드래그앤드랍
			/* var listType = $('input[name=listType]').val();
			if(listType == 1 && isMobile() == 'nomobile'){
				$("table").tableDnD({
					onDragClass: "dragRow"
				});
			} 
			*/
		});
		
		//20161013 ycyu add > 숫자만 입력받기
		function InpuOnlyNumber(obj){
		    if (event.keyCode >= 48 && event.keyCode <= 57) { //숫자키만 입력
		        return true;
		    } else {
		        event.returnValue = false;
		    }
		}
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">금수저쿠폰</a> &gt;
		<strong>
			<c:if test="${params.viewType == '01'}">금수저쿠폰 목록</c:if>
			<c:if test="${params.viewType == '02'}">도전과제쿠폰 목록</c:if>
		</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>
				<c:if test="${params.viewType == '01'}">금수저 쿠폰</c:if>
				<c:if test="${params.viewType == '02'}">도전과제 쿠폰</c:if>
			</h2>
			<p>
				<c:if test="${params.viewType == '01'}">금수저쿠폰</c:if>
				<c:if test="${params.viewType == '02'}">도전과제쿠폰</c:if>을 관리합니다.
				<span class=""></span>
			</p>
		</div>
		
		<input type="hidden" name="listType" value="${params.listType }"/>
		
		<!-- search -->
		<div class="search">
			<form class="search" role="form" name="searchForm" id="searchForm" method="POST">
			<input type="hidden" name="viewType" value="${params.viewType }"/>
			<fieldset>
				<legend>검색</legend>
				<!-- 상세검색 -->
				<div class="search-detail" role="popover">
					<div class="inner">
						<div class="pop-content"> 
							<div class="search-select">
								<div class="select-row1">
									<%-- 
									<span class="search-group">
										<select title="뷰타입" name="viewType" id="viewType">
											<option value="">전체</option>
											<option value="01" <c:if test="${params.viewType == '01'}">selected</c:if> >금수저쿠폰</option>
											<option value="02" <c:if test="${params.viewType == '02'}">selected</c:if> >도전과제</option>
										</select>
									</span>
									 --%>
									<span class="search-group">
										<select title="노출여부" name="showYn" id="showYn">
											<option value="">전체</option>
											<option value="Y" <c:if test="${params.showYn == 'Y'}">selected</c:if> >노출</option>
											<option value="N" <c:if test="${params.showYn == 'N'}">selected</c:if> >비노출</option>
										</select>
									</span>
									<span class="search-group">
										<select title="추천여부" name="recommendYn" id="recommendYn">
											<option value="">전체</option>
											<option value="Y" <c:if test="${params.recommendYn == 'Y'}">selected</c:if> >추천</option>
											<option value="N" <c:if test="${params.recommendYn == 'N'}">selected</c:if> >추천안함</option>
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
											<option value="2" <c:if test="${params.searchType2 == '2'}">selected</c:if> >개발사</option>
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
					<a href="/GM/GM03?viewType=${params.viewType}" class="btn-black2">등록하기</a> 
					&nbsp;&nbsp;
					<!-- 20161026 ycyu del > 도전과제캠페인은 노출순서가 필요없음, 도전과제리스트 순서에 따라 노출됨 -->
					<%-- 
					<c:if test="${params.listType == 1}">
						<button type="button" class="btn-black2" id="sortSaveBtn"><span>노출순서 저장</span></button>
					</c:if> 
					--%>
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
					<col style="width:*;"/>
					<col style="width:5%;"/>
					<col style="width:5%;"/>
					<col style="width:5%;"/>
					<col style="width:6%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:7%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:4%;"/>
					<col style="width:10%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">등급</th>
						<th scope="col">이미지</th>
						<th scope="col">게임명</th>
						<th scope="col">개발사</th>
						<th scope="col">등록일자</th>
						<th scope="col">유효기간</th>
						<th scope="col">노출기간</th>
						<th scope="col">등록자</th>
						<th scope="col">노출여부</th>
						<th scope="col">노출순서</th>
						<th scope="col">코드1</th>
						<th scope="col">코드1<br />평균￦</th>
						<th scope="col">코드2</th>
						<th scope="col">코드2<br />평균￦</th>
						<th scope="col">코드3</th>
						<th scope="col">코드3<br />평균￦</th>
						<th scope="col">다운로드<br />클릭수</th>
						<th scope="col">쿠폰이관</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
								<%-- 
								<tr <c:if test="${item.viewType eq '02' }">bgcolor='#E4F7BA'</c:if> > 
								--%>
									<td>	
										<c:if test="${item.viewType eq '02' }">
											도전과제</br>
										</c:if>
										${item.seqNo}</br>
										<c:if test="${item.recommendYn eq 'Y' }">
											(추천)</br>	
										</c:if>										
										<c:if test="${today > item.endDt }">
											(종료)</br>
										</c:if>
										<c:if test="${item.soldoutType1 eq 'Y' }">
											(SOLDOUT)
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
									<td><img src="${item.game.gameThumUrl }" style="width:60px;"/></td>
									<td class="view" data-seq="${item.seqNo}"><a href="#">${item.game.gameNm }</a></td>
									<td>${item.game.developer }</td>
									<td>${item.createDt }</td>
									<td>${item.validDt }</td>
									<td>${item.startDt }</br>~${item.endDt }</td>
									<td>${item.modRegId }</td>
									<td>${item.showYn eq 'Y' ? "노출":"비노출" }</td>
									<td>${item.showOrder}</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType1Yn eq 'Y' && item.codeType1Ucnt == 0 && item.codeType1Tcnt == 0 }">
												<button class="btn-black2 btnRegCoupon" data-seq="${item.seqNo}" data-codetype="1" ><span>코드등록</span></button>
											</c:when>
											<c:when test="${item.codeType1Yn eq 'Y' && item.codeType1Tcnt > 0 }">
												<a href="#" class="btnRegCoupon" data-seq="${item.seqNo}" data-codetype="1">${item.codeType1Ucnt}/${item.codeType1Tcnt}</a>											
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType1Yn eq 'Y' && item.codeType1Tcnt > 0 }">
												<fmt:formatNumber value="${item.avrPay1}" groupingUsed="true"/>											
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType2Yn eq 'Y' && item.codeType2Ucnt == 0 && item.codeType2Tcnt == 0 }">
												<button class="btn-black2 btnRegCoupon" data-seq="${item.seqNo}" data-codetype="2"><span>코드등록</span></button>
											</c:when>
											<c:when test="${item.codeType2Yn eq 'Y' && item.codeType2Tcnt > 0 }">
												<a href="#" class="btnRegCoupon" data-seq="${item.seqNo}" data-codetype="2">${item.codeType2Ucnt}/${item.codeType2Tcnt}</a>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType2Yn eq 'Y' && item.codeType12cnt > 0 }">
												<fmt:formatNumber value="${item.avrPay2}" groupingUsed="true"/>											
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType3Yn eq 'Y' && item.codeType3Ucnt == 0 && item.codeType3Tcnt == 0 }">
												<button class="btn-black2 btnRegCoupon" data-seq="${item.seqNo}" data-codetype="3"><span>코드등록</span></button>
											</c:when>
											<c:when test="${item.codeType3Yn eq 'Y' && item.codeType3Tcnt > 0 }">
												<a href="#" class="btnRegCoupon" data-seq="${item.seqNo}" data-codetype="3">${item.codeType3Ucnt}/${item.codeType3Tcnt}</a>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${item.codeType3Yn eq 'Y' && item.codeType3Tcnt > 0 }">
												<fmt:formatNumber value="${item.avrPay3}" groupingUsed="true"/>											
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<td>${item.installCnt }</td>
									<td>
										<c:if test="${item.codeType1Yn eq 'Y' && item.codeType1Tcnt > 0 && today <= item.endDt}">
											<input name="couponCnt" id="couponCnt" type="text" style="text-align: right; width:100%;" maxlength=4 onkeyPress="InpuOnlyNumber(this);" placeholder="개">
											</br>
											<c:choose>
												<c:when test="${item.viewType eq '01'}">
													<button class="btn-silver btnCouponMove" style="width:100%;" data-viewtype="${item.viewType}" data-seq="${item.seqNo}" data-gameseq="${item.gameSeq}" data-destseq="${item.destGameCouponSeq}" data-gamenm="${item.game.gameNm }" ><span>> 도전과제로 이관</span></button>
												</c:when>
												<c:when test="${item.viewType eq '02'}">
													<button class="btn-gold btnCouponMove" style="width:100%;" data-viewtype="${item.viewType}" data-seq="${item.seqNo}" data-gameseq="${item.gameSeq}" data-destseq="${item.destGameCouponSeq}" data-gamenm="${item.game.gameNm }" ><span>> 금수저로 이관</span></button>
												</c:when>
												<c:otherwise>
													-
												</c:otherwise>
											</c:choose>
											
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="11">조회 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<%-- <div class="btn-area ar">
			<a href="/GM/GM03?viewType=${params.viewType}" class="btn-black2">등록하기</a> 
		</div> --%>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>
		
	</div>
<div id="couponRegPop" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">쿠폰등록/발급내역</h2>
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