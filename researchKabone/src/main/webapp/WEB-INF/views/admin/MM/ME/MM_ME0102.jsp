<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 사용자 관리 > 사용자 추가</title>
	
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
	
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			
			//회원정보 저장
			$('.btnUserInfoSave').click(function(){
				if (confirm("회원정보를 저장 하시겠습니까?") == false){
					return;
				}
				
				$('input[name=userType]').val($('input[name=optUserType]:checked').val());
				
				//블랙리스트면 흙수저로 강등됨 -> controller에서 처리
				/* var userType = $('input[name=userType]').val();
				if(userType == '09'){
					$('input[name=userLevel]').val('00');	
				} */				
				
				var form = $('form')[0];
				var formData = new FormData(form);
				$.ajax({
	                url: '<c:url value="/MM/ME/ME04"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	$('.wrap-loading').addClass('display-none');
	                	alert("회원정보를 저장하였습니다.");
	                	//alert("<spring:message code='ui.modify.alert.success'/>");
	                	location.reload();
	                    //location.href = '<c:url value="/MM/ME/ME01"/>';
	                },
	                error: function(){
	                	$('.wrap-loading').addClass('display-none');
	                	alert("<spring:message code='ui.modify.alert.failure'/>");
	                }
	                ,beforeSend:function(){
	                	$('.wrap-loading').removeClass('display-none');
	                }
	                ,complete:function(){
	                	$('.wrap-loading').addClass('display-none');
	                }
	            });
				
			});
		});
		
		
		$(document).ready(function(){
			//getAuthList();
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">회원정보</a> &gt;
		<strong>회원정보 상세</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>사용자 정보</h2>
			<p>사용자 정보를 추가합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="userTy" id="userTy" value="ADMIN"/>
											
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:12%;">
						<col style="width:38%;">
						<col style="width:12%;">
						<col style="width:38%;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>사용자 ID</th>
							<td>
								<input type="text" title="닉네임" name="usreId" placeholder="사용 할 ID를 입력 해 주세요.">
							</td>
							
							
							<th scope="row"><span class="required" title="필수">*</span> 패스워드를 입력해주세요.</th>
							<td>
								<input type="text" title="닉네임" name="pwd" placeholder="패스워드를 입력해 주세요.">
							</td>
						</tr>						
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 이름</th>
							<td colspan="3">
								<input type="text" title="닉네임" name="userNm" placeholder="이름을 입력해 주세요." style="width:30%;">			
							</td>
							
						</tr>
						<tr>
							<th scope="row"> 전화번호</th>
							<td>
								<input type="text" title="닉네임" name="mobNo" placeholder="전화번호를 입력해 주세요.">
							</td>
							
							
							<th scope="row"> 이메일</th>
							<td>
								<input type="text" title="닉네임" name="email" placeholder="이메일을 입력해 주세요.">
							</td>
						</tr>						
						
						<tr>
							<td colspan="4">
								<button type="button" class="btn-black2 btnUserInfoSave"><span>회원정보 저장</span></button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/MM/ME/ME01"/>" class="btn-black2">목록</a>								
		</div>

	</div>
		
		
<div class="wrap-loading display-none">
	<div> <img src="/admin/common/images/loading.gif" /> </div>
</div>		
		
</body>
</html>