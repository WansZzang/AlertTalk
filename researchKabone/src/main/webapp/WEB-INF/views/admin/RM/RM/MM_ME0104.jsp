<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 회원관리 > 회원상세</title>
	
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
			
			//썸네일 초기화(회원정보 저장시 실 반영됨)
			$('.btnProfileDel').click(function(){
				if (confirm("사진을 초기화 하시겠습니까?") == false){
					return;
				}
				//흙수저
				if($('#userLevel').val() == '00'){
					$('#profile_img').attr("src", "/admin/common/images/profile-dummy.jpg");
					$('#profileImg').val("../img/profile-dummy.jpg");	
				}
				//동수저
				if($('#userLevel').val() == '01'){
					$('#profile_img').attr("src", "/admin/common/images/profile-dummy.jpg");
					$('#profileImg').val("../img/profile-dummy.jpg");	
				}
				//은수저
				if($('#userLevel').val() == '02'){
					$('#profile_img').attr("src", "/admin/common/images/profile-dummy.jpg");
					$('#profileImg').val("../img/profile-dummy.jpg");	
				}
				//금수저
				else if($('#userLevel').val() == '03'){
					$('#profile_img').attr("src", "/admin/common/images/profile-goldspoon.jpg");
					$('#profileImg').val("../img/profile-goldspoon.jpg");	
				}				
			});
			
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
			
			//본인인증 초기화
			$('.btnInitIdConfirm').click(function(){
				if (confirm("본인인증을 초기화 하시겠습니까?") == false){
					return;
				}
								
				var form = $('form')[0];
				var formData = new FormData(form);
								
				$.ajax({
	                url: '<c:url value="/MM/ME/ME0405"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	$('.wrap-loading').addClass('display-none');
	                	//alert("<spring:message code='ui.modify.alert.success'/>");
	                	alert("본인인증이 초기화 되었습니다.");
	                	location.reload();
	                },
	                error: function(){
	                	$('.wrap-loading').addClass('display-none');
	                	/* alert("<spring:message code='ui.modify.alert.failure'/>"); */
	                	alert("본인인증 초기화를 실패하였습니다.");
	                }
	                ,beforeSend:function(){
	                	$('.wrap-loading').removeClass('display-none');
	                }
	                ,complete:function(){
	                	$('.wrap-loading').addClass('display-none');
	                }
	            });
				
			});			
			
			//금수저등급 저장
			$('.btnUserLevelSave').click(function(){
				
				$('input[name=authEmail]').val($('input[name=authEmail]').val().trim());
				
				if($('input[name=authEmail]').val().trim() == ''){
					alert('인증메일을 선택 또는 입력해주세요!');
					return;
				}
				if(isValidEmail($('input[name=authEmail]').val().trim()) == false){
					alert('유효한 이메일 정보가 아닙니다.\n인증메일을 다시 입력해주세요.');
					return;
				}
				
				
				
				if (confirm("금수저 등급을 저장 하시겠습니까?") == false){
					return;
				}
				
				$('input[name=userLevel]').val($('input[name=optUserLevel]:checked').val());	//선택된 유저레벨
				$('input[name=isNewAuthEmail]').val($('input[name=optAuthEmail]:checked').data('new')); //신규인증 유무
				
				var form = $('form')[0];
				var formData = new FormData(form);
				$.ajax({
	                url: '<c:url value="/MM/ME/ME0502"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	$('.wrap-loading').addClass('display-none');
	                	alert("금수저 인증정보가 저장되었습니다.");
	                	location.reload();
	                },
	                error: function(){
	                	$('.wrap-loading').addClass('display-none');
	                	alert("금수저 인증정보 저장을 실패하였습니다.(중복된 인증메일이거나 알수없는 오류)\n인증등급이 초기화됩니다...");
	                	location.reload();
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
		
		//인증메일 radio 선택
		function emailClick(obj) {
			//신규일 경우에만 입력이 가능하도록 함
			var isNewEmail = $(obj).data('new');
			if(isNewEmail == 'N'){
				//메일입력창 비활성화
				$('input[name=authEmail]').attr('readonly',true);
			}else{
				//메일입력창 활성화
				$('input[name=authEmail]').removeAttr('readonly');
			}
			
			//선택된 메일 적용
			var authEmail = $(obj).val();
			$('input[name=authEmail]').val(authEmail);
			
		}
		
		function getAuthList(){
			
			$('.authList').empty();
			
			//var _datas = '';
			var userNo = $('input[name=userNo]').val();
			var _datas = "userNo=" + userNo;
			
			var authList = [];
			
			$.ajax({ 
				type: 'POST',
				url: '<c:url value="/MM/ME/ME05"/>',
				data: _datas,
				error:function(data){
					$('.wrap-loading').addClass('display-none');
					alert('인증정보 조회를 실패하였습니다.\n금수저등급 저장 불가 ');
					//alert('인증정보 조회실패(' + data.responseText + ')');
						
					$(".btnUserLevelSave").hide();
					
				},
				success:function(data){
					$('.wrap-loading').addClass('display-none');
					
					var isOne = true;
					
					var _html = '';	
					_html += '<ul class="radio-group">';	//ul start
					
					if (data.rCode == '0000' && data.list != null  && data.list != ''){	//성공
												
						authList = data.list; 
						
						//인증내역이 없을 경우 처리...
						if(authList.length < 1){
							//nothing...
						}
						
		                $.each(authList, function(index, value) {
		                	
							if(index == 0){	//최신 인증정보인 경우
								
								//첫번째 radio 버튼이 클릭된것처럼 적용
								$('input[name=authEmail]').attr('readonly',true);
								$('input[name=authEmail]').val(value.authEmail);
		                		
		                		_html += '	<li>';
		                		_html += '		<input type="radio" name="optAuthEmail" data-new="N" value="'+ value.authEmail +'" data-seq="'+ value.seqNo +'" checked="checked" onclick="emailClick(this);" >';
		                		_html += '		<label for="at1">' + value.authEmail + '(최신)</label>';
		                		_html += '	</li>';
		                	}else{
		                		_html += '	<li>';
		                		_html += '		<input type="radio" name="optAuthEmail" data-new="N" value="'+ value.authEmail +'" data-seq="'+ value.seqNo +'" onclick="emailClick(this);" >';
		                		_html += '		<label for="at1">' + value.authEmail + '</label>';
		                		_html += '	</li>';
		                	}
							
							isOne = false;
		                	
		                });
		                
					}else{
						//console.info("인증정보 없음");
					} 
						
					//인증내역 유무와 관계없이 "신규등록" li 를 추가한다.
					_html += '	<li>';
					if(isOne == true){
						_html += '		<input type="radio" name="optAuthEmail" data-new="Y" value="" checked="checked" onclick="emailClick(this);" >';	
					}else{
						_html += '		<input type="radio" name="optAuthEmail" data-new="Y" value="" onclick="emailClick(this);" >';
					}
					_html += '		<label for="at1">신규인증</label>';
					_html += '	</li>';
					
					_html += '</ul>';	//ul end
					
					$('.authList').append(_html);
					
				}
				,beforeSend:function(){
                	$('.wrap-loading').removeClass('display-none');
                }
                ,complete:function(){
                	$('.wrap-loading').addClass('display-none');
                }
			});
			 
		}
		
		$(document).ready(function(){
			getAuthList();
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
			<h2>회원정보</h2>
			<p>회원정보를 관리합니다.<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="userNo" value="${item.userNo }"/>
				<input type="hidden" name="userType" id="userType" value="${item.userType }"/>
				<input type="hidden" name="profileImg" id="profileImg" value="${item.profileImg }"/>
				<input type="hidden" name="userLevel" id="userLevel" value="${item.userLevel }"/>
				<input type="hidden" name="email" value="${item.email }"/>
				<input type="hidden" name="snsType" value="${item.snsType }"/>
				<input type="hidden" name="gender" value="${item.gender }"/>
				
				<input type="hidden" name="isNewAuthEmail"/>
								
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
							<th scope="row"><span class="required" title="필수">*</span> 프로필</th>
							<td colspan="3">
								<c:choose>
									<c:when test="${item.profileImg eq '../img/profile-goldspoon.jpg'}">
										<img id="profile_img" src="/admin/common/images/profile-goldspoon.jpg" style="width:100px; height:100px;"/>																			   
									</c:when>
									<c:when test="${item.profileImg eq '../img/profile-dummy.jpg'}">
										<img id="profile_img" src="/admin/common/images/profile-dummy.jpg" style="width:100px; height:100px;"/>																			   
									</c:when>
									<c:otherwise>
										<img id="profile_img" src="${item.profileImg }" style="width:100px; height:100px;"/>
									</c:otherwise>
								</c:choose>				
								<button type="button" class="btn-black2 btnProfileDel"><span>썸네일 초기화</span></button>			
								※사진 초기화 시 저장을 하셔야 실제 반영됩니다.
							</td>
						</tr>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 회원상태</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optUserType" value="01" <c:if test="${item.userType eq '01'}">checked='checked'</c:if> >
										<label for="at1">가입</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="92" <c:if test="${item.userType eq '92'}">checked='checked'</c:if> >
										<label for="at2">탈퇴</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="99" <c:if test="${item.userType eq '99'}">checked='checked'</c:if> >
										<label for="at2">강제탈퇴</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="09" <c:if test="${item.userType eq '09'}">checked='checked'</c:if> >
										<label for="at2" style="font-weight:bold;">블랙리스트</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="10" <c:if test="${item.userType eq '10'}">checked='checked'</c:if> >
										<label for="at2">커뮤니티 관리자</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="90" disabled="disabled" <c:if test="${item.userType eq '90'}" >checked='checked'</c:if> >
										<label for="at2">직원</label>
									</li>
									<li>
										<input type="radio" name="optUserType" value="99" disabled="disabled" <c:if test="${item.userType eq '99'}" >checked='checked'</c:if> >
										<label for="at2">퇴사자</label>
									</li>									
								</ul>
							</td>
							<td colspan="2">
								<span style="color:red;font-weight:bold;">※ 블랙리스트 적용시 흙수저로 강등됩니다.</span>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 닉네임</th>
							<td>
								<input type="text" title="닉네임" name="nick" placeholder="닉네임을 입력해 주세요." value="${item.nick }">								
							</td>
							
							<th scope="row"> 이름</th>
							<td>
								${item.userNm }
							</td>
						</tr>
							
						<tr>
							<th scope="row"> 이메일</th>
							<td>
								${item.email }
							</td>
							
							<th scope="row"> SNS타입</th>
							<td>
								<c:choose>
									<c:when test="${item.snsType eq 'f'}">
										페이스북
									</c:when>
									<c:when test="${item.snsType eq 'g'}">
										구글
									</c:when>											
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						<tr>
							<th scope="row"> 전화번호</th>
							<td>
								${item.mphone }
								<c:choose>
									<c:when test="${item.idConfirm eq 'Y'}">
										&nbsp;&nbsp;
										<button type="button" class="btn-red btnInitIdConfirm"><span>본인인증 초기화</span></button>
									</c:when>
								</c:choose>
							</td>
							
							<th scope="row"> 성별</th>
							<td>
								<c:choose>
									<c:when test="${item.gender eq 'm'}">
										남
									</c:when>
									<c:when test="${item.gender eq 'f'}">
										여
									</c:when>											
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
						</tr>						
						
						<tr>
							<th scope="row"> 가입일</th>
							<td>
								${item.createDt }
							</td>
							
							<th scope="row"> 수정일</th>
							<td>
								${item.modDt }
							</td>
						</tr>
						
						<tr>
							<th scope="row"> 디바이스 정보</th>
							<td colspan="3">
								OS: ${item.os } / Model: ${item.modelNm }
							</td>
						</tr>
						<tr>
							<th scope="row"> 메모</th>
							<td colspan="3">
								<textarea name="memo" cols="40" row="5" placeholder="회원의 특이사항을 기록하세요!" >${item.memo }</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<button type="button" class="btn-black2 btnUserInfoSave"><span>회원정보 저장</span></button>
								</br></br>
							</td>
						</tr>
						
						
						<!-- ---------------- 회원등급 ----------------- -->
						
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 인증등급 선택</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optUserLevel" value="00" <c:if test="${item.userLevel eq '00'}">checked='checked'</c:if> >
										<label for="at1">흙수저</label>
									</li>
									<li>
										<input type="radio" name="optUserLevel" value="01" <c:if test="${item.userLevel eq '01'}">checked='checked'</c:if> disabled="disabled" >
										<label for="at2">동수저</label>
									</li>
									<li>
										<input type="radio" name="optUserLevel" value="02" <c:if test="${item.userLevel eq '02'}">checked='checked'</c:if> >
										<label for="at3">은수저</label>
									</li>
									<li>
										<input type="radio" name="optUserLevel" value="03" <c:if test="${item.userLevel eq '03'}">checked='checked'</c:if> >
										<label for="at4">금수저</label>
									</li>
								</ul>
								
							</td>
							<td colspan="2">
								&nbsp;※등급 조정시 인증등급, 인증메일, 금액인증유무, 게임개수인증유무만 저장됩니다.
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 인증메일 선택</th>
							<td class="authList">
								<!-- 
								동적데이터
								 -->								
							</td>
							<th scope="row"><span class="required" title="필수">*</span> 인증메일 등록(신규등록)</th>
							<td>
								<input type="text" title="인증메일" name="authEmail" placeholder="금수저 인증메일을 입력해 주세요." value="${item.authEmail }">
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<button type="button" class="btn-black2 btnUserLevelSave"><span>금수저 인증정보 저장</span></button>
								</br></br>
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