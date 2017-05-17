<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>금수저 쿠폰-쿠폰등록/발급내역</title>
	
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
			
			//20161013 ycyu add > 검색기능 추가
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/popup/GM/GM05" />').submit();
				return false;
			});
			
			//이하 쿠폰 CRUD 영역
			$('#crudForm').submit(function(e){
				 e.preventDefault();
			});
			$('#btnUpload').click(function(){
				if ( $('input[name=excelfile]').val() != ''){
					var form = $('form')[0];
					//FormData parameter에 담아줌
					var formData = new FormData(form);
					
					$.ajax({
		                url: '<c:url value="/popup/GM/GM06"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                	$('.wrap-loading').addClass('display-none');
		                    alert("업로드가 성공하였습니다.");
		                    parent.document.location.reload();
		                    //location.reload();
		                },
		                error: function(xhr, status, error){
		                	$('.wrap-loading').addClass('display-none');
		                	var _errData = $.parseJSON(xhr.responseText);
		                	alert("등록 중 오류가 발생하였습니다.\n[원인:" + _errData.error.message + "]");
		                }
		                ,beforeSend:function(){
		                	$('.wrap-loading').removeClass('display-none');
		                }
		                ,complete:function(){
		                	$('.wrap-loading').addClass('display-none');
		                }
		            });
				}else{
					alert('업로드할 파일을 선택하세요.');
				}
				
			});
			
			$('#btnReplaceUpload').click(function(){
				if ( $('input[name=excelfile]').val() != ''){
					var form = $('form')[0];
					//FormData parameter에 담아줌
					var formData = new FormData(form);

					$.ajax({
		                url: '<c:url value="/popup/GM/GM07"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                	$('.wrap-loading').addClass('display-none');
		                	alert("교체가 성공하였습니다.");
		                    location.reload();
		                },
		                error: function(xhr, status, error){
		                	$('.wrap-loading').addClass('display-none');
		                	var _errData = $.parseJSON(xhr.responseText);
		                	alert("교체 중 오류가 발생하였습니다.\n(원인:" + _errData.error.message + ")");
		                	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		                }
		                ,beforeSend:function(){
		                	$('.wrap-loading').removeClass('display-none');
		                }
		                ,complete:function(){
		                	$('.wrap-loading').addClass('display-none');
		                }
		            });
				}else{
					alert('업로드할 파일을 선택하세요.');
				}
				
			});
			
			$('#btnDeleteUpload').click(function(){
				
				if ( confirm("쿠폰을 삭제하시겠습니까.?") ){
					var form = $('form')[0];
					//FormData parameter에 담아줌
					var formData = new FormData(form);

					$.ajax({
		                url: '<c:url value="/popup/GM/GM08"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                	$('.wrap-loading').addClass('display-none');
		                	alert("<spring:message code='ui.delete.alert.success'/>");
		                    
		                    location.reload();
		                    parent.document.location.reload();
		                },
		                error: function(xhr, status, error){
		                	$('.wrap-loading').addClass('display-none');
		                	var _errData = $.parseJSON(xhr.responseText);
		                	alert("<spring:message code='ui.delete.alert.failure'/>\n" + _errData);
		                	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
				$("#searchForm").attr('action', '<c:url value="/popup/GM/GM0609" />').submit();
				
				return false;
			});
			
			//20161028 ycyu add > 유저정보 연동
			$('.userview').click(function(){
				var _userNo = $(this).data('userno');
				window.open('<c:url value="/MM/ME/ME04" />?userNo=' + _userNo, '_blank');
			});
			
		});
		
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>Excel규격</h2>
			<p>
				1. 파일의 첫번째 sheet에 작성합니다.<br/>
				2. 데이터 입력시 첫번째 컬럼만 이용하며<br/>
				3. 첫번째 행부터 쿠폰난수를 입력합니다.<br/>
				<span class=""></span>
			</p>
		</div>
		<!-- search -->
		<div >
			<!-- 20161013 ycyu mod > from명칭 변경 -->
			<form role="form" name="crudForm" id="crudForm" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="gameCouponSeq" value="${params.gameCouponSeq }"/>
				<input type="hidden" name="codeType" value="${params.codeType }"/>
				
				<div class="inner">
					<div>
						<div class="input-file">
							<label class="btn-gray">
								파일첨부
								<input type="file" name="excelfile" onchange="setFilename('excelText',this);" placeholder="업로드할 파일을 선택하세요.">
							</label>
							<input type="text" readonly="readonly" title="게임APK" id="excelText">
						</div>
					</div>
					<div class="btn-group">
					
						<c:set var="regBtnFlag" 		value=""/>
						<c:set var="replaceBtnFlag" 	value=""/>
						<c:set var="delBtnFlag" 		value=""/>
						<%-- 
						<c:if test="${ (param.codeType eq '1' && item.codeType1Tcnt > 0) || (param.codeType eq '2' && item.codeType2Tcnt > 0) || (param.codeType eq '3' && item.codeType3Tcnt > 0) }">
							<c:set var="regBtnFlag" value="disabled='disabled'"/>
						</c:if>
						 --%>
						<c:if test="${ (param.codeType eq '1' && item.codeType1Tcnt == 0) || (param.codeType eq '2' && item.codeType2Tcnt == 0) || (param.codeType eq '3' && item.codeType3Tcnt == 0) }">
							<c:set var="replaceBtnFlag" value="disabled='disabled'"/>
							<c:set var="delBtnFlag" value="disabled='disabled'"/>
						</c:if>
						
						<c:choose>
							<c:when test="${ (param.codeType eq '1' && item.codeType1Tcnt > 0) || (param.codeType eq '2' && item.codeType2Tcnt > 0) || (param.codeType eq '3' && item.codeType3Tcnt > 0) }">
								<button class="btn-black2 " id="btnUpload" ><span>추가하기</span></button>
							</c:when>
							<c:otherwise>
								<button class="btn-black2 " id="btnUpload" ><span>등록하기</span></button>
							</c:otherwise>
						</c:choose>
						<%-- 
						<button class="btn-black2 " id="btnUpload" ${regBtnFlag} ><span>등록하기</span></button>
						 --%>
						<button class="btn-black2 " id="btnReplaceUpload" ${replaceBtnFlag } ><span>코드교체</span></button>
						<button class="btn-black2 " id="btnDeleteUpload" ${delBtnFlag } ><span>쿠폰코드삭제</span></button>
					</div>
				</div>
				<br/><br/>
			</form>
			
			<!-- 20161013 ycyu add > 검색기능 추가 -->
			<form class="search" role="form" name="searchForm" id="searchForm" method="POST">
				<input type="hidden" name="gameCouponSeq" value="${params.gameCouponSeq }"/>
				<input type="hidden" name="codeType" value="${params.codeType }"/>	
				<div class="title-area">
					<!-- Title -->
					<h2>검색</h2>
				</div>
				<!-- search -->
				<fieldset>
					<legend>검색</legend>
					<!-- 상세검색 -->
					<div class="search-detail" role="popover">
						<div class="inner">
							<div class="pop-content">
								<div class="search-select">
									<div class="select-row1">
										<!-- 쿠폰코드, 닉네임, 이메일로 검색 -->
										<span class="search-group">
											<select title="검색대상" name="searchType2" id="searchType2">
												<option value="">검색대상</option>
												<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >닉네임</option>
												<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >이메일</option>
												<option value="3" <c:if test="${param.searchType2 == '3'}">selected</c:if> >쿠폰코드</option>
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
		
		</br>
		
		<!-- 테이블 목록 -->
		<div class="table-list-type1">
			<table id='coupon_table'>
				<caption></caption>
				<colgroup>
					<col style="width:*;"/>
					<col style="width:5%;"/>
					<col style="width:10%;"/>
					<col style="width:4%;"/>
					<col style="width:15%;"/>
					<col style="width:17%;"/>
					<col style="width:15%;"/>
					<col style="width:15%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">쿠폰코드</th>
						<th scope="col">상태</th>
						<th scope="col">닉네임</th>
						<th scope="col">성별</th>
						<th scope="col">전화번호</th>
						<th scope="col">계정</th>
						<th scope="col">인증</th>
						<th scope="col">발급일시</th>						
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr>
									<td>${item.couponCd}</td>
									<td>
										<c:choose>
											<c:when test="${item.provideYn eq 'Y'}">
												<c:choose>
													<c:when test="${item.useYn eq 'Y'}">
														사용
													</c:when>
													<c:otherwise>
														미사용
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												미발급
											</c:otherwise>
										</c:choose>																					
									</td>
									<td>${item.nick}</td>
									<td>
										<c:choose>
											<c:when test="${item.gender eq 'm'}">
												남
											</c:when>
											<c:when test="${item.gender eq 'f'}">
												여
											</c:when>
										</c:choose>
									</td>
									<td>${item.mphone}</td>
									<td class="userview" style="cursor:poiniter" data-userno="${item.userNo}">
										<c:if test="${item.provideYn eq 'Y'}">
											<a href="#" > 
												${item.email}(${item.snsType})
											</a>
										</c:if>
									</td>
									<td>${item.authEmail}</td>
									<td>
										<c:if test="${item.provideYn eq 'Y'}">
											${item.recvDt}
										</c:if>
									</td>									
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="2">조회 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>
		
	</div>
	
	
<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>
	
	
</body>
</html>