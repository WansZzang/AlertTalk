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
	<title>홈 > 도전과제 > 인증</title>
	
	<style>
        /* 미리보기 스타일 셋팅 */
        #preview{
            z-index: 9999;
            position:absolute;
            border:0px solid #ccc;
            background:#333;
            padding:1px;
            display:none;
            color:#fff;
        }
    </style>
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
			//-------------------------------------------------------------------
			// 이미지 미리보기
			//-------------------------------------------------------------------
			var xOffset = 10;
            var yOffset = 30; 
			$(document).on("mouseover",".thumbnail",function(e){ //마우스 오버시
            	
				$("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='400px' /></p>"); //보여줄 이미지를 선언                       
                $("#preview")
                	.css("top",(e.pageY - xOffset) + "px")
                    .css("left",(e.pageX + yOffset) + "px")
                    .fadeIn("fast"); //미리보기 화면 설정 셋팅
            });
                 
            $(document).on("mousemove",".thumbnail",function(e){ //마우스 이동시
                $("#preview")
                    .css("top",(e.pageY - xOffset) + "px")
                    .css("left",(e.pageX + yOffset) + "px");
            });
                 
            $(document).on("mouseout",".thumbnail",function(){ //마우스 아웃시
                $("#preview").remove();
            });

			$(document).on("click",".thumbnail",function(e){ //마우스 클릭시
	            	$('#popupIfrm').ready(function () {
						showLayer($('.thumbnail'), 'thumbPop');
					});
					$('#popupIfrm').attr('src', $(this).attr("src"));
	            });


			//-------------------------------------------------------------------
			
			
			$("#checkall").click(function(){
		        //클릭되었으면
		        if($("#checkall").prop("checked")){
		        	$("input[name=chkSeq]").prop("checked",true);	//전체일괄처리		            
		        }else{		            
		            $("input[name=chkSeq]").prop("checked",false);
		        }
		    });
						
			//인증처리 > 1건
			$(document).on('click', '.btnCertComp', function(){
				//var missionSeq = $(this).data('seq');
				
			});
			
			//인증처리 > 다수
			$('.btnMissionComp').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('인증할 항목을 선택하세요.');
				}else{
					if ( confirm("인증하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건]")){
												
						var _datas = "1=1";
						$('input[name=chkSeq]:checked').each(function(idx, item){
							_datas += "&seqNos=" + $(this).data('seq');
							_datas += "&note="+this.parentNode.parentNode.parentNode.childNodes[23].childNodes[1].value;
							_datas += "&pnsToken="+this.parentNode.parentNode.parentNode.childNodes[1].value;
							_datas += "&nick="+this.parentNode.parentNode.parentNode.childNodes[3].value;
							_datas += "&missionSeq="+this.parentNode.parentNode.parentNode.childNodes[25].value;
							_datas += "&missionTitle="+this.parentNode.parentNode.parentNode.childNodes[27].value;
						});
						
						_datas += "&clearYn=Y";
						
						$.ajax({ 
							type: 'POST',
							url: '<c:url value="/DM/CT05"/>',
							data: _datas,
							error:function(data){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.create.alert.failure'/>");
								console.log('status change fail');	
								console.log(data);
							},
							success:function(result){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.create.alert.success'/>");
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
				}
			});
			
			//반려처리 > 다수
			$('.btnMissionFail').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('반려처리 할 항목을 선택하세요.');
				}else{
					if ( confirm("반려처리 하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건]")){
						
						var _datas = "1=1";
						$('input[name=chkSeq]:checked').each(function(idx, item){
							_datas += "&seqNos=" + $(this).data('seq');
							_datas += "&note="+this.parentNode.parentNode.parentNode.childNodes[23].childNodes[1].value;
							_datas += "&pnsToken="+this.parentNode.parentNode.parentNode.childNodes[1].value;
							_datas += "&nick="+this.parentNode.parentNode.parentNode.childNodes[3].value;
							_datas += "&missionSeq="+this.parentNode.parentNode.parentNode.childNodes[25].value;
							_datas += "&missionTitle="+this.parentNode.parentNode.parentNode.childNodes[27].value;
						});
						
						_datas += "&clearYn=F";
						
						
						
						$.ajax({ 
							type: 'POST',
							url: '<c:url value="/DM/CT05"/>',
							data: _datas,
							error:function(data){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.create.alert.failure'/>");
								console.log('status change fail');	
								console.log(data);
							},
							success:function(result){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.create.alert.success'/>");
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
				}
			});
			
			//삭제처리 > 다수
			$('.btnMissionDel').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('삭제 할 항목을 선택하세요.');
				}else{
					if ( confirm("삭제 하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건]")){
						
						var _datas = "1=1";
						$('input[name=chkSeq]:checked').each(function(idx, item){
							_datas += "&seqNos=" + $(this).data('seq');
						});
						
						$.ajax({ 
							type: 'POST',
							url: '<c:url value="/DM/CT06"/>',
							data: _datas,
							error:function(data){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.delete.alert.failure'/>");
								console.log('status change fail');	
								console.log(data);
							},
							success:function(result){
								$('.wrap-loading').addClass('display-none');
								
								alert("<spring:message code='ui.delete.alert.success'/>");
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
				}
			});
			
			/* 
			//상세
			$(document).on('click','table > tbody > tr > td:nth-child(4)', function(){
				var _seqNo = $(this).data('seq');
				
				location.href = '<c:url value="/DM/CT04"/>?seqNo=' + _seqNo;
			});
			 */
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/DM/CT01" />').submit();
				return false;
			});
			
			//excel
			/* $("#excelBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/DM/DM06" />').submit();			
				return false;
			}); */
			
			
			
			
		});
		
		$(document).ready(function(){
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">도전과제 인증</a> 
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>도전과제 인증</h2>
			<p>사용자의 도전과제 수행결과를 인증처리합니다.<span class=""></span></p>
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
										<!-- 
										N: 인증요청상태
										F: 인증실패(반려)
										Y: 인증완료상태
										 -->
										<select title="인증여부" id="clearYn" name="clearYn">
											<option value="">전체</option>
											<option value="Y" <c:if test="${param.clearYn == 'Y'}">selected</c:if> >인증</option>
											<option value="N" <c:if test="${param.clearYn == 'N'}">selected</c:if> >비인증</option>
											<option value="F" <c:if test="${param.clearYn == 'F'}">selected</c:if> >반려</option>
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
											<option value="1" <c:if test="${param.searchType2 == '1'}">selected</c:if> >도전과제명</option>
											<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >닉네임</option>
											<option value="3" <c:if test="${param.searchType2 == '3'}">selected</c:if> >이메일</option>
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
			
		</div>
		
		
		
		<!-- 테이블 목록 -->
		<div class="table-list-type1">
			
			<table>
				<caption></caption>
				<colgroup>
					<col style="width:3%;"/>
					<col style="width:5%;"/>
					<col style="width:5%;"/>
					<col style="width:12%;"/>
					<col style="width:10%;"/>
					<col style="width:7%;"/>
					<col style="width:10%;"/>
					<col style="width:7%;"/>
					<col style="width:*;"/>
					<col style="width:18%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<div>
	        					<input type="checkbox" id="checkall" />
	    					</div>
	    				</th>
						<th scope="col">No.</th>
						<th scope="col">상태</th>
						<th scope="col">도전과제명</th>
						<th scope="col">등록일자</th>
						<th scope="col">닉네임</th>
						<th scope="col">이메일</th>
						<th scope="col">등급</th>
						<th scope="col">이미지's</th>
						<th scope="col">반려 사유<br>사유 미작성시 기본메시지 발송 (사유 10자 이내)</th>
						
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr <c:if test="${item.clearYn eq 'N' }">bgcolor='#E4F7BA'</c:if> <c:if test="${item.clearYn eq 'F' }">bgcolor='#FFD8D8'</c:if> >
									<input name="pnsToken" id="pnsToken" value="${item.pnsToken}" type="hidden" >
									<input name="nick" id="nick" value="${item.nick }" type="hidden" >
									<td>
										<!-- 
										N: 인증요청상태
										F: 인증실패(반려)
										Y: 인증완료상태
										 -->
										<c:if test="${item.clearYn eq 'N' or item.clearYn eq 'F' }">
											<span class="chk"><input type="checkbox" name="chkSeq" data-seq="${item.seqNo}"></span>
										</c:if>
									</td>
									<td>										
										${item.seqNo}
									</td>
									<td>
										<c:if test="${item.clearYn eq 'Y' }">
											인증
										</c:if>
										<c:if test="${item.clearYn eq 'N' }">
											비인증
										</c:if>
										<c:if test="${item.clearYn eq 'F' }">
											반려
										</c:if>										
									</td>
									<td>${item.missionTitle }</td>
									<td>${item.createDt }</td>
									<td 
										<c:if test="${item.email eq 'fatmouse4@gmail.com' or item.email eq 'matury7845@gmail.com' or item.email eq 'yghong101@gmail.com' or item.email eq 'ynabark@gmail.com' }"> 
											bgcolor='#FFBB00'
										</c:if> 
									>
										${item.nick }
									</td>
									<td>${item.email } ( ${item.snsType } )</td>
									<td>
										<c:if test="${item.userLevel eq '00' }">
											흙수저
										</c:if>
										<c:if test="${item.userLevel eq '02' }">
											은수저
										</c:if>
										<c:if test="${item.userLevel eq '03' }">
											금수저
										</c:if>										
									</td>
									<td>
										<c:if test="${item.imgUrl1 ne null and item.imgUrl1 ne ''}">
											<img src="${item.imgUrl1}" style="width:100px; float:left;" class="thumbnail"/>								
										</c:if>
										<c:if test="${item.imgUrl2 ne null and item.imgUrl2 ne ''}">
											<img src="${item.imgUrl2}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl3 ne null and item.imgUrl3 ne ''}">
											<img src="${item.imgUrl3}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl4 ne null and item.imgUrl4 ne ''}">
											<img src="${item.imgUrl4}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl5 ne null and item.imgUrl5 ne ''}">
											<img src="${item.imgUrl5}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										</br>
										<c:if test="${item.imgUrl6 ne null and item.imgUrl6 ne ''}">
											<img src="${item.imgUrl6}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl7 ne null and item.imgUrl7 ne ''}">
											<img src="${item.imgUrl7}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl8 ne null and item.imgUrl8 ne ''}">
											<img src="${item.imgUrl8}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl9 ne null and item.imgUrl9 ne ''}">
											<img src="${item.imgUrl9}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
										<c:if test="${item.imgUrl10 ne null and item.imgUrl10 ne ''}">
											<img src="${item.imgUrl10}" style="width:100px; float:left;" class="thumbnail"/>
										</c:if>
									</td>
									<td>
										<input name="note" id="note" value="" type="text" class="note" placeholder="57분 도전과제 반려되었습니다.(사유:틀린 인증 샷)" maxlength="10">
									</td>
									<input name="missionSeq" id="missionSeq" value="${item.missionSeq }" type="hidden" >
									<input name="missionTitle" id="missionTitle" value="${item.missionTitle }" type="hidden" >
									<%-- <td>
										<button class="btn-black2 btnCertComp" data-seq="${item.seqNo}"><span>인증</span></button>
									</td> --%>
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
		
		
		<div class="btn-area al">
			<a href="#" class="btn-black2 btnMissionComp">인증하기</a>
			<a href="#" class="btn-red btnMissionFail">반려처리</a>
			
			&nbsp;&nbsp;<a href="#" class="btn-red btnMissionDel">삭제처리</a>			
		</div>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>
		
		

	</div>

<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>	
	

<div id="thumbPop" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<div class="search-detail">
				<h3 class="blind"> </h3>
				<div>
					<img id="popupIfrm" src="" style="width:100%;height:100%; float:center;border:0;frameborder:0;" />
				</div>
			</div>
		</div>
		<button type="button" class="close btnPopClose"></button>
	</div>
</div>		
	
</body>
</html>