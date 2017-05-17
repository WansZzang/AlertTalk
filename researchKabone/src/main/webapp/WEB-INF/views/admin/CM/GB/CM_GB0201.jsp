<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 댓글게임 관리 > 댓글 관리(쿠폰/도전과제)</title>
	<script>
		$(function(){
				
			//체크 삭제는 대댓글에서 사용
			/* 
			$('.btnDel').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('삭제할 댓글를 선택하세요.');
				}else{
					if ( confirm("삭제하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건](대댓글이 있을 경우 동일하게 적용됩니다.)")){
						var _datas = "1=1";
						$('input[name=chkSeq]:checked').each(function(idx, item){
							_datas += "&seqNos=" + $(this).data('seq');
						});
						
						$.ajax({ 
							type: 'POST',
							url: '<c:url value="/CM/GB/GB0205"/>',
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
		 	*/
		 	
		 	//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				fnPageDateInit();
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/CM/GB/GB0201" />?depth=1').submit();
				return false;
			});
			
			//대댓글 보기
			$(document).on('click', '.btnReReplyView', function(){
				var gameSeq = $(this).data('gameseq');
				var commentSeq = $(this).data('seq');
				var depth = 2;
				
				window.open('<c:url value="GB0201" />?gameSeq=' + gameSeq 
						+ '&commentSeq=' + commentSeq + '&depth=' + 2 + '&parentId=' + 2, '_blank');
				
			});
			
			//20161004 ycyu add > 이벤트 해제
			$(document).on('click', '.btnEventRelease', function(){
				var _seqNo = $(this).data('seq');
				var _topYn = $(this).data('topyn');
				var _depth = $(this).data('depth');
				var _datas = "seqNo=" + _seqNo + "&topYn=N";
				
				if ( confirm('댓글의 이벤트를 해제 하시겠습니까?')){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/CM/GB/GB0203"/>',
						data: _datas,
						error:function(data){
							alert("<spring:message code='ui.modify.alert.failure'/>");
							console.log('status change fail');	
							console.log(data);
						},
						success:function(result){
							alert("<spring:message code='ui.modify.alert.success'/>");
							location.reload();
						}
					});	
				}
				
			});
			
			//show/hide
			$(document).on('click', '.btnDisplay', function(){
				var _seqNo = $(this).data('seq');
				var _showYn = $(this).data('showyn');
				var _depth = $(this).data('depth');
				var noti = '숨기기';
				if(_showYn == 'Y'){
					_showYn = 'N';
				}else{
					_showYn = 'Y';
					noti = '보이기';
				}
				var _datas = "seqNo=" + _seqNo + "&showYn=" + _showYn + "&depth=" + _depth;
				
				if ( confirm('댓글을 ' + noti + ' 하시겠습니까?(대댓글이 있을 경우 동일하게 적용됩니다.)')){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/CM/GB/GB0204"/>',
						data: _datas,
						error:function(data){
							alert("<spring:message code='ui.modify.alert.failure'/>");
							console.log('status change fail');	
							console.log(data);
						},
						success:function(result){
							alert("<spring:message code='ui.modify.alert.success'/>");
							location.reload();
						}
					});	
				}
				
			});
			
			$('.btnDelReply').click(function(){
		 		var _seqNo = $(this).data('seq');
		 		var _datas = "seqNo=" + _seqNo;
		 		if ( confirm('댓글을 삭제 하시겠습니까?(대댓글이 있을 경우 동일하게 적용됩니다.)')){
		 			$.ajax({ 
						type: 'POST',
						url: '<c:url value="/CM/GB/GB0205"/>',
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
		 		
			});
			
			//댓글등록 팝업
			$(document).on('click', '.btnRegReply', function(){
				var gameSeq = $(this).data('gameseq');
				var commentSeq = $(this).data('seq');
				var depthUserNo = $(this).data('userno');
				
				//alert(gameSeq + ", " + commentSeq + ", " + depthUserNo);
				
				$('#popupIfrm').ready(function () {
					showLayer($('.btnRegReply'), 'commentRegPop');
				});
				
				$('#popupIfrm').attr('src', '<c:url value="/popup/CM/GB/GB0301"/>?gameSeq=' + gameSeq 
						+ '&commentSeq=' + commentSeq + '&depthUserNo=' + depthUserNo + '&depth=' + 2 + '&parentId=' + 2);
				
			});
			
			$("#checkall").click(function(){
		        //클릭되었으면
		        if($("#checkall").prop("checked")){
		        	$("input[name=chkSeq]").prop("checked",true);	//전체일괄처리		            
		        }else{		            
		            $("input[name=chkSeq]").prop("checked",false);
		        }
		    });
			
			//20161020 ycyu add > 유저정보 연동
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
	<p class="location">
		<a href="#none" class="home">커뮤니티</a> &gt;
		<strong>댓글 관리(쿠폰/도전과제)</strong>
	</p>
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>댓글 관리(쿠폰/도전과제)<c:if test="${params.gameNm != null and params.gameNm != ''}"> - <font color="blue">${params.gameNm}</font></c:if> </h2>
			<p>댓글을 관리합니다.<span class=""></span></p>
		</div>
		<!-- search -->
		<div class="search">
			<form class="search" role="form" name="searchForm" id="searchForm" method="POST">
			<input type="hidden" id="gameSeq" name="gameSeq" value="${params.gameSeq }"/>
			<input type="hidden" id="gameNm" name="gameNm" value="${params.gameNm }"/>
			
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
											<option value="Y" <c:if test="${param.showYn == 'Y'}">selected</c:if> >노출</option>
											<option value="N" <c:if test="${param.showYn == 'N'}">selected</c:if> >비노출</option>
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
											<option value="2" <c:if test="${param.searchType2 == '2'}">selected</c:if> >댓글</option>
											<option value="3" <c:if test="${param.searchType2 == '3'}">selected</c:if> >닉네임</option>
											<option value="4" <c:if test="${param.searchType2 == '4'}">selected</c:if> >이메일</option>
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
				<!-- <button type="button" class="btn-simple excel" id="excelBtn"><span>EXCEL</span></button> -->
			</fieldset>
			<div class="total-status">
				<em class="total">Total : </em>
				<span class="value">${totalRecordCount}</span>
				<em class="page">Page : </em>
				<span class="value"><span class="curr">${currentPage}</span>/${totalPageCount}</span>
				
				</br>
				
			</div>
			
			
			</form>
		</div>
		<div class="ar">
			<span style="color:red;">※ 대댓글보기, 작성자 클릭시 새창으로 이동합니다.</span>
		</div>
		<!-- 테이블 목록 -->
		<div class="table-list-type1">
			<table>
				<caption></caption>
				<colgroup>
					<col style="width:5%;"/>
					<col style="width:8%;"/>
					<col style="width:*;"/>
					<col style="width:10%;"/>
					<col style="width:10%;"/>
					<col style="width:15%;"/>
					<col style="width:8%;"/>
					<col style="width:8%;"/>
					<col style="width:5%;"/>
					<col style="width:5%;"/>
					
				</colgroup>
				<thead>
					<tr>
						<!-- 
						<th scope="col">
							<div>
	        					<input type="checkbox" id="checkall" />
	    					</div>
						</th>
						 -->
						<th scope="col">No.</th>
						<th scope="col">게임명</th>
						<th scope="col">댓글</th>
						<th scope="col">대댓글 보기</th>
						<th scope="col">대댓글 달기</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
						<th scope="col">수정일</th>
						<th scope="col">이벤트</th>
						<th scope="col">노출여부</th>
						<!-- <th scope="col">삭제</th>	 -->
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0 }">
							<c:forEach var="item" items="${list}" varStatus="status">
								<%-- <tr <c:if test="${item.depth == 1 }">bgcolor='#E4F7BA'</c:if> > --%>
								<tr <c:if test="${item.topYn eq 'Y' }">bgcolor='#E4F7BA'</c:if> >
									<%-- 
									<td>
										<span class="chk"><input type="checkbox" name="chkSeq" data-seq="${item.seqNo}"></span>
									</td>
									 --%>
									<td>${item.seqNo}</td>
									<td>${item.gameNm }</td>
									<td>
										<c:if test="${item.depth == 1}">${item.comment }</c:if>
										<c:if test="${item.depth == 2}">&crarr;</c:if>										
									</td>
									<td>
										<button class="btn-red btnReReplyView" data-gameseq="${item.gameSeq}" data-seq="${item.seqNo}"><span>(${item.replyCount})대댓글보기</span></button>																				
										<%-- <button class="btn-red btnReReplyView" data-gameseq="${item.gameSeq}" data-seq="${item.seqNo}"><span>대댓글보기</span></button> --%>
									</td>
									<td>
										<button class="btn-black2 btnRegReply" data-gameseq="${item.gameSeq}" data-seq="${item.seqNo}" data-userno="${item.userNo}"><span>대댓글달기</span></button>
									</td>
									<td class="userview" style="cursor:poiniter" data-userno="${item.userNo}">
										<a href="#" > 
											${item.nick }(${item.userLevel })
											</br>${item.email }(${item.snsType })
										</a>
									</td>
									<td>${item.createDt }</td>
									<td>${item.modDt }</td>
									<td>
										<c:choose>
											<c:when test="${item.topYn eq 'Y' }">
												<button class="btn-blue btnEventRelease" data-seq="${item.seqNo}" data-topyn="${item.topYn}" data-depth="${item.depth}">
													<span>해제</span>
												</button>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>	
									</td>
									<td>
										<c:choose>
											<c:when test="${item.showYn eq 'Y' }">
												<button class="btn-red btnDisplay" data-seq="${item.seqNo}" data-showyn="${item.showYn}" data-depth="${item.depth}">
													<span>숨기기</span>
												</button>
											</c:when>
											<c:when test="${item.showYn eq 'N' }">
												<button class="btn-black2 btnDisplay" data-seq="${item.seqNo}" data-showyn="${item.showYn}" data-depth="${item.depth}">
													<span>보이기</span>
												</button>
											</c:when>
											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</td>
									<!-- 20161027 ycyu del > 
										mysql Auto_Increment시 최신데이터가 삭제될 경우 빈자리 seq_no를 생성하는 문제가 있어서 1뎁스일 경우 seq_no와 comment_seq가 같지 않아지는 현상이 있음
										따라서 게임댓글의 경우 삭제는 하지 말고 show/hide만 처리할것!
									 -->
									<%-- 
									<td>
										<button class="btn-black2 btnDelReply" data-seq="${item.seqNo}"><span>삭제</span></button>
									</td> 
									--%>																		
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

		<div class="btn-area al">
			<!-- <a href="#" class="btn-black2 btnDel">삭제</a> -->
			<!-- <a href="#" class="btn-black2 btnAdd">등록</a> -->
		</div>
		
		<!-- 페이징 -->
		<%@include file="/WEB-INF/views/include/paging.jsp" %>

	</div>
	
<div id="commentRegPop" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">대댓글달기</h2>
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
	
	
</body>
</html>