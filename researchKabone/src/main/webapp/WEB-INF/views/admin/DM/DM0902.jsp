<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 도전과제 > 수동인증</title>
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
			
			
			$("#checkall").click(function(){
		        //클릭되었으면
		        if($("#checkall").prop("checked")){
		        	//수행한 미션은 제외
		        	$('input[name=chkSeq]').each(function(idx, item){
						var clearYn =  $(this).data('clear');
						if(clearYn != 'Y'){
							$(this).prop("checked",true);	
						}
					});
		            //$("input[name=chkSeq]").prop("checked",true);	//전체일괄처리
		            
		        }else{		            
		            $("input[name=chkSeq]").prop("checked",false);
		        }
		    })
			
			$('#btnReg').click(function(){
				if ( $('input[name=chkSeq]:checked').size() < 1 ){
					alert('등록할 미션을 선택하세요!');
					return;
				}				
				var missionSeq = $("#missionSeq").val();
				if(missionSeq == null || missionSeq == ''){
					alert('도전과제 정보가 없습니다.');
					return false;
				}
				var userNo = $("#userNo").val();
				if(userNo == null || userNo == ''){
					alert('사용자가 존재하지 않습니다.');
					return false;
				}
				
							
				
				if ( confirm("등록하시겠습니까.?[총 " + $('input[name=chkSeq]:checked').size() + " 건]")){
					var _datas = "1=1";
					$('input[name=chkSeq]:checked').each(function(idx, item){
						_datas += "&subNos=" + $(this).data('seq');
					});
					
					_datas = _datas + '&missionSeq=' + missionSeq;
					_datas = _datas + '&userNo=' + userNo;
								
					//alert('params: '+_datas);
					
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/DM/DM0903"/>',
						data: _datas,
						success:function(result){
							$('.wrap-loading').addClass('display-none');
							
							alert("<spring:message code='ui.create.alert.success'/>");
							location.reload();
						}
						,error:function(data){
							$('.wrap-loading').addClass('display-none');
							
							alert("<spring:message code='ui.create.alert.failure'/>");						
							console.log('status change fail');	
							console.log(data);
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
			
			//초기화
			$("#resetBtn").bind("click", function(){
				$('form').clearForm();
				$('searchForm').clearForm();
				
				return false;
			});
			
			//검색
			$("#searchBtn").bind("click", function(){
				$("#searchForm").attr('action', '<c:url value="/popup/DM/DM0902" />').submit();
				return false;
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
			<h2>수동인증</h2>			
		</div>
		
		<p>
			<br/>
			1. SNS타입과 이메일을 입력한 후 검색한다.<br/>
			2. 검색된 미션리스트중 수행한 미션을 선택하여 수동인증을 처리한다.  
			<br/>
		</p>
		<!--  -->
		
		<div class="search">
			<form class="search" role="form" name="searchForm" id="searchForm" method="POST">
			<input type="hidden" id="missionSeq" name="missionSeq" value="${params.missionSeq }"/>
			<input type="hidden" id="userNo" name="userNo" value="${params.userNo }"/>
			
			<fieldset>
				<legend>검색</legend>
				<!-- 상세검색 -->
				<div class="search-detail" role="popover">
					<div class="inner">
						<div class="pop-content">
							<div class="search-select">
								<div class="select-row1">
									<span class="search-group">
										<select title="SNS타입" id="snsType" name="snsType">
											<option value="g" <c:if test="${param.snsType == 'g'}">selected</c:if> >구글</option>
											<option value="f" <c:if test="${param.snsType == 'f'}">selected</c:if> >페이스북</option>
										</select>
									</span>
								</div>
								<div class="select-row2">
									<span class="search-group fullwidth">
										<input name="email" id="email" value="${param.email}" type="text" class="keyword" placeholder="이메일을 입력해주세요.">
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
			</form>
		</div>
		
		<div>
        	전체선택<input type="checkbox" id="checkall" />
    	</div>
		
		<!--  -->
		<!-- 테이블 목록 -->
		<div class="table-list-type1">
			<table>
				<caption></caption>
				<colgroup>
					<col style="width:8%;"/>
					<col style="width:14%;"/>
					<col style="width:*;"/>
					<col style="width:14%;"/>
					<col style="width:14%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">선택</th>
						<th scope="col">미션번호</th>
						<th scope="col">미션내용</th>
						<th scope="col">삭제여부</th>
						<th scope="col">수행여부</th>
					</tr>
				</thead>
				<tbody>
					
					
						
							<c:choose>
								<c:when test="${fn:length(list) > 0 }">
									<c:forEach var="item" items="${list}" varStatus="status">
										<tr>
											<td>
												<span class="chk">
													<input type="checkbox" name="chkSeq" data-seq="${item.subNo}" data-clear="${item.clearYn}" <c:if test="${item.clearYn == 'Y'}">disabled</c:if> >
												</span>
											</td>
											<td> ${item.subNo } </td>
											<td> ${item.missionContents } </td>
											<td>${item.delYn eq 'Y'?"삭제됨":"-" }</td>
											<td>${item.clearYn eq 'Y'?"수행":"-" }</td>
										</tr>
									</c:forEach>
								</c:when>
								<%-- <c:otherwise>
									<tr>
										<td colspan="2">조회 결과가 없습니다.</td>
									</tr>
								</c:otherwise> --%>
							</c:choose>
							
						
					
				</tbody>
			</table>
		</div>
		
		<div class="btn-group">
			<button class="btn-black2" id="btnReg" ><span>등록하기</span></button>			
		</div>
				
	</div>
	
<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>	
	
</body>
</html>