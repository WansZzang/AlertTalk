<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 금수저쿠폰</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/GM/GM09"/>',
						data: 'seqNo=${item.seqNo}',
						error:function(data){
							alert("<spring:message code='ui.delete.alert.failure'/>\n" + data.responseText);
						},
						success:function(data){
							alert("<spring:message code='ui.delete.alert.success'/>");
							
							var viewType = $('input[name=viewType]').val();
		                	if(viewType == '01'){
		                		location.href = '<c:url value="/GM/GM01"/>';
		                	}
		                	else if(viewType == '02'){
		                    	location.href = '<c:url value="/GM/MS01"/>';
		                    }
						}
					});
				}
			});
			
			$('#gameSelBtn').click(function(){
				//게임정보 수정불가
				/* 
				//게임리스트 팝업
				$('h2.tit').text('게임 리스트');
				$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
				showLayer($(this), 'listPopup');
				 */
			});
			
			$('#ChkCodeType1Yn').click(function(){
				if ( $(this).is(':checked')){
					$('input[name=optCodeType1]').removeAttr('disabled');
					$('input[name=codeType1Nm]').removeAttr('readonly');
				}else{
					$('input[name=optCodeType1]').attr('disabled', true);
					$('input[name=codeType1Nm]').attr('readonly', true);
				}
				$('input[name=optCodeType1]').removeAttr('checked',false);
				$('input[name=codeType1Nm]').val('');
			});
			
			$('input[name=optCodeType1]').click(function(){
				$('input[name=codeType1Nm]').val($(this).data('text'));
			});
			
			$('input[name=optCodeType2]').click(function(){
				$('input[name=codeType2Nm]').val($(this).data('text'));
			});
			
			$('input[name=optCodeType3]').click(function(){
				$('input[name=codeType3Nm]').val($(this).data('text'));
			});
			
			$('#ChkCodeType2Yn').click(function(){
				if ( $(this).is(':checked')){
					$('input[name=optCodeType2]').removeAttr('disabled');
					$('input[name=codeType2Nm]').removeAttr('readonly');
				}else{
					$('input[name=optCodeType2]').attr('disabled', true);
					$('input[name=codeType2Nm]').attr('readonly', true);
				}
				
				$('input[name=optCodeType2]').removeAttr('checked',false);
				$('input[name=codeType2Nm]').val('');
			});
			
			$('#ChkCodeType3Yn').click(function(){
				if ( $(this).is(':checked')){
					$('input[name=optCodeType3]').removeAttr('disabled');
					$('input[name=codeType3Nm]').removeAttr('readonly');
				}else{
					$('input[name=optCodeType3]').attr('disabled', true);
					$('input[name=codeType3Nm]').attr('readonly', true);
				}
				
				$('input[name=optCodeType3]').removeAttr('checked');
				$('input[name=codeType3Nm]').val('');
			});
			
			$('.btnsave').click(function(e){
				
				// 20160609 ycyu add > 유저레벨타입 가져오기
				if(CheckUserLevel() == false){
					alert("유저레벨을 선택하세요.");
					return;
				}
				
				var benefitSummS = $('input[name=benefitSummS]').val();
				if(benefitSummS.length > 13){
					alert("혜택요약이 너무 깁니다. 최대 13자리까지 입력하세요.");
					return;
				}
				var benefitCost = $('input[name=benefitCost]').val();
				if(benefitCost.length > 5){
					alert("혜택금액이 너무 깁니다. 최대 5자리까지 입력하세요.");
					return;
				}
				
				
				// 20160609 ycyu add > 화면타입 체크값 가져오기
				$('input[name=viewType]').val($('input[name=optViewType]:checked').val());
				
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				$('input[name=recommendYn]').val($('input[name=optRcmdYN]:checked').val());
				
				$('input[name=codeType1Yn]').val($('#ChkCodeType1Yn').is(":checked")?"Y":"N");
				$('input[name=codeType2Yn]').val($('#ChkCodeType2Yn').is(":checked")?"Y":"N");
				$('input[name=codeType3Yn]').val($('#ChkCodeType3Yn').is(":checked")?"Y":"N");
				
				$('input[name=country]').val($('#selCountry option:selected').val());
				$('input[name=useYn]').val($('input[name=optUseYN]:checked').val());
				
				$('#codeMethod').val(CKEDITOR.instances.codeMethod.getData());
				$('#benefitSumm').val(CKEDITOR.instances.benefitSumm.getData());
				$('#benefitDetail').val(CKEDITOR.instances.benefitDetail.getData());
				$('#review').val(CKEDITOR.instances.review.getData());
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				if( $('#frmact').valid() && validWithOutJquery() ) {
					$.ajax({
		                url: '<c:url value="/GM/GM04"/>',
		                processData: false,
		                contentType: false,
		                data: formData,
		                type: 'POST',
		                success: function(result){
		                	alert("<spring:message code='ui.modify.alert.success'/>");
		                    
		                    var viewType = $('input[name=viewType]').val();
		                	if(viewType == '01'){
		                		location.href = '<c:url value="/GM/GM01"/>';
		                	}
		                	else if(viewType == '02'){
		                    	location.href = '<c:url value="/GM/MS01"/>';
		                    }
		                    
		                },
		                error: function(data){
		                	var errorObj = $.parseJSON(data.responseText);
		                	alert("<spring:message code='ui.modify.alert.failure'/>" + "\n원인:" + errorObj.error.message);
		                }
		            });
				}
				
			});
			
			$('#frmact').validate({
				debug: false,
		        onfocusout: false,
		        rules: {
		            gameNm : {
		            	required: true
		            },
		            showOrder : {
		            	required : true
		            },
		            developerEmail : {
		            	required: true
		            },
		            codeMethod : {
		            	required: true
		            },
		            benefitSumm : {
		            	required: true
		            },
		            benefitSummS : {
		            	required: true
		            },
		            benefitCost : {
		            	required: true
		            },
		            validDt : {
		            	required: true
		            },
		            startDt : {
		            	required: true
		            },
		            endDt : {
		            	required: true
		            },
		            
		            review : {
		            	required: true
		            }
		        }, messages: {
		            gameNm: {
		                required: '게임을 선택하세요.'
		            },
		            showOrder : {
		            	required : '노출순서를 입력하세요.'
		            },
		            developerEmail : {
		            	required: '게임사를 입력하세요.'
		            },
		            codeMethod : {
		            	required: '코드사용방법을 입력하세요.'
		            },
		            benefitSumm : {
		            	required: '혜택을 입력하세요.'
		            },
		            benefitSummS : {
		            	required: '혜택요약을 입력하세요.'
		            },
		            benefitCost : {
		            	required: '혜택금액을 입력하세요.'
		            },
		            validDt : {
		            	required: '유효기간을 입력하세요.'
		            },
		            startDt : {
		            	required: '시작일을 입력하세요.'
		            },
		            endDt : {
		            	required: '종료일을 입력하세요.'
		            },
		            
		            review : {
		            	required: '리뷰를 입력하세요.'
		            }
		        }, errorPlacement: function(error, element) {
		            // do nothing
		        }, invalidHandler: function(form, validator) {
		             var errors = validator.numberOfInvalids();
		             if (errors) {
		                 alert(validator.errorList[0].message);
		                 validator.errorList[0].element.focus();
		             }          
		        }
			});
			
		});
		
		// 20160609 ycyu add > 유저레벨 데이터화
		function CheckUserLevel(){
			if ( $('input[name=chkUserLevel]:checked').size() < 1 ){
				return false;
			}else{
				var uls = ["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"];
				
				$('input[name=chkUserLevel]:checked').each(function(idx, item){
					var codeSeq = $(this).data('codeseq');
					//var codeValue = $(this).data('codevalue');					
					uls[codeSeq-1] = 1;					
				});
				
				var userLevelType = uls.join('');
				$('input[name=userLevelType]').val(userLevelType);				
			}
			
			return true;
		}
		
		function validWithOutJquery(){
			
			//코드발급사용여부 체크
			if ( !$('#ChkCodeType1Yn').is(':checked') && !$('#ChkCodeType1Yn').is(':checked') && !$('#ChkCodeType1Yn').is(':checked') ){
				alert('코드발급 버큰은 최소 1개 이상 사용하셔야 합니다.');
				return false;
			}
			
			if ( $('input[name=codeType1Nm]').val() == '' &&  $('input[name=codeType1Nm]').val() == '' && $('input[name=codeType1Nm]').val() == '' ){
				alert('코드발급 버큰명은 최소 1개 이상 등록하셔야 합니다.');
				return false;
			}
			return true;
			
		}
		
		//사용안함
		/* 
		function selectGame(_seqNo, _lang, _gameName, _gamePacNm){
			$('input[name=gameNm]').val(_gameName);
			$('input[name=gameSeq]').val(_seqNo);
			
			$('#popupIfrm').attr('src','');
			//close popup
			$('.btnPopClose').click();
		}
		 */
		$(document).ready(function(){
			
		});
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">금수저 쿠폰</a> &gt;
		<strong>
			<c:if test="${item.viewType == '01'}">금수저쿠폰 수정</c:if>
			<c:if test="${item.viewType == '02'}">도전과제쿠폰 수정</c:if>
		</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>
				<c:if test="${item.viewType == '01'}">금수저쿠폰 수정</c:if>
				<c:if test="${item.viewType == '02'}">도전과제쿠폰 수정</c:if>
			</h2>
			<p>
				<c:if test="${item.viewType == '01'}">금수저쿠폰</c:if>
				<c:if test="${item.viewType == '02'}">도전과제쿠폰</c:if> 정보를 수정합니다.
				<span class=""></span>
			</p>
			
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="seqNo" value="${item.seqNo }"/>
				<input type="hidden" name="gameSeq" value="${item.gameSeq }"/>
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="recommendYn"/>
				<input type="hidden" name="codeType1Yn"/>
				<input type="hidden" name="codeType2Yn"/>
				<input type="hidden" name="codeType3Yn"/>
				
				<!-- 20160609 ycyu add > 화면타입 변수-->
				<input type="hidden" name="viewType" value="${item.viewType }"/>
				<input type="hidden" name="viewSeq" value="${item.viewSeq }"/>
				<input type="hidden" name="userLevelType" value="${item.userLevelType }"/>
				
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
					
						<!-- 20160609 ycyu add > 화면타입 영역 -->
						<tr style="display:none;"><!-- 20161025 ycyu mod > 화면타입 노출안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 화면타입</th>
							<td class="viewTypes">
								<ul class="radio-group">
									<c:choose>
										<c:when test="${fn:length(viewTypeCodes) > 0 }">
											<c:forEach var="viewItem" items="${viewTypeCodes}" varStatus="status">
												<li>
													<input type="radio" name="optViewType" <c:if test="${item.viewType eq viewItem.codeValue}">checked='checked'</c:if> value="${viewItem.codeValue }" disabled="disabled" >
													<label for="at1">${viewItem.codeNm }</label>
												</li>								
											</c:forEach>
										</c:when>
										<c:otherwise>
											화면타입을 가져올수 없습니다.
										</c:otherwise>
									</c:choose>
									
									<!-- 도전과제 선택시 도전과제타이틀 표시해야 함  -->
									<!-- <input type="text" id="viewNm" readonly="readonly" placeholder="도전과제 선택시 미션타이틀이 표시됩니다." > -->
									
								</ul>								
							</td>
						</tr>						
						
						<!-- 20160609 ycyu add > 유저레벨 영역 -->
						<tr style="display:none;"><!-- 20161025 ycyu mod > 유저레벨 노출안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 유저레벨</th>
							<td class="levelTypes">
								<ul class="radio-group">
									<c:choose>
										<c:when test="${fn:length(userLevelCodes) > 0 }">
											<c:forEach var="userItem" items="${userLevelCodes}" varStatus="status">
												<span class="chk">
													<!-- 20161018 ycyu mod > viewType과 user level에 따라 체크되고 사용자가 선택하지 못하도록 변경-->
													<input type="checkbox" name="chkUserLevel" value="${userItem.codeValue}"
														<c:if test="${ (item.viewType eq '01' && userItem.codeValue eq '03') || (item.viewType eq '02' && userItem.codeValue eq '02') }">checked='checked'</c:if> disabled="disabled"  
														data-codevalue="${userItem.codeValue}" data-codeseq="${userItem.codeSeq}" >
													<%-- <input type="checkbox" name="chkUserLevel" value="${userItem.codeValue}" data-codevalue="${userItem.codeValue}" data-codeseq="${userItem.codeSeq}" <c:if test="${userItem.yn eq 'Y'}">checked='checked'</c:if> > --%>
													${userItem.codeNm }
												</span>
											</c:forEach>
										</c:when>
										<c:otherwise>
											유저레벨을 가져올수 없습니다.
										</c:otherwise>
									</c:choose>
								</ul>								
							</td>
						</tr>
					
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게임명</th>
							<td>
								<div class="addr-input">
									<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly" value="${item.game.gameNm }">
									<!-- <a href="#none" class="btn-gray" id="gameSelBtn">게임선택</a> -->
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showOrder" placeholder="숫자로 입력해 주세요." value="${item.showOrder }">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if> value="Y" >
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if> value="N" >
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 추천여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optRcmdYN" <c:if test="${item.recommendYn eq 'Y'}">checked='checked'</c:if> value="Y" >
										<label for="at1">추천</label>
									</li>
									<li>
										<input type="radio" name="optRcmdYN" <c:if test="${item.recommendYn eq 'N'}">checked='checked'</c:if> value="N" >
										<label for="at2">추천안함</label>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 혜택요약 </th>
							<td>								
								<input type="text" title="혜택요약" name="benefitSummS" placeholder="혜택 요약 내용을 입력해 주세요.(최대 13자)" value="${item.benefitSummS }">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 혜택금액 </th>
							<td>								
								<input type="text" title="혜택금액" name="benefitCost" placeholder="혜택 금액 내용을 입력해 주세요.(최대 5자)" value="${item.benefitCost }">
							</td>
						</tr>
						
						<tr>
							<th scope="row" rowspan="3"><span class="required" title="필수">*</span> 코드발급 버튼 </th>
							<td>
								<ul class="check-group">
									<li>
										<input type="checkbox" id="ChkCodeType1Yn" <c:if test="${item.codeType1Yn eq 'Y'}">checked='checked'</c:if> >
										<label for="ChkCodeType1Yn">사용</label>
									</li>
								</ul>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optCodeType1" <c:if test="${item.codeType1Nm eq '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="Y" data-text="금수저 쿠폰 참여하기">
										<label for="at1">금수저 쿠폰 참여하기</label>
									</li>
									<li>
										<input type="radio" name="optCodeType1" <c:if test="${item.codeType1Nm ne '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="N" data-text="">
										<label for="at2">기타</label>
									</li>
								</ul>
								<input type="text" title="코드발급버튼" name="codeType1Nm" value="${item.codeType1Nm}" placeholder="코드발급버튼 제목명을 입력해 주세요.(10 자 이내)">
							</td>
						</tr>
						<tr>
							<td>
								<ul class="check-group">
									<li>
										<input type="checkbox" id="ChkCodeType2Yn" <c:if test="${item.codeType2Yn eq 'Y'}">checked='checked'</c:if> >
										<label for="chkCoupon3">사용</label>
									</li>
								</ul>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optCodeType2" <c:if test="${item.codeType2Nm eq '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="Y" disabled="disabled" data-text="금수저 쿠폰 참여하기">
										<label for="at1">금수저 쿠폰 참여하기</label>
									</li>
									<li>
										<input type="radio" name="optCodeType2" <c:if test="${item.codeType2Nm ne '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="N" disabled="disabled" data-text="">
										<label for="at2">기타</label>
									</li>
								</ul>
								<input type="text" title="코드발급버튼" name="codeType2Nm" value="${item.codeType2Nm}" readonly="readonly" placeholder="코드발급버튼 제목명을 입력해 주세요.(10 자 이내)">
							</td>
						</tr>
						<tr>
							<td>
								<ul class="check-group">
									<li>
										<input type="checkbox" id="ChkCodeType3Yn" <c:if test="${item.codeType3Yn eq 'Y'}">checked='checked'</c:if>>
										<label for="chkCoupon3">사용</label>
									</li>
								</ul>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optCodeType3" <c:if test="${item.codeType3Nm eq '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="Y" disabled="disabled" data-text="금수저 쿠폰 참여하기">
										<label for="at1">금수저 쿠폰 참여하기</label>
									</li>
									<li>
										<input type="radio" name="optCodeType3" <c:if test="${item.codeType3Nm ne '금수저 쿠폰 참여하기'}">checked='checked'</c:if> value="N" disabled="disabled" data-text="">
										<label for="at2">기타</label>
									</li>
								</ul>
								<input type="text" title="코드발급버튼" name="codeType3Nm" value="${item.codeType3Nm}" readonly="readonly" placeholder="코드발급버튼 제목명을 입력해 주세요.(10 자 이내)">
							</td>
						</tr> 
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게임사에 문의</th>
							<td>
								※ 이메일 주소 또는 URL을 입력해주세요.(URL입력시 반드시 http 또는 https가 포함되어야 합니다.)</br>
								<input type="text" title="게임사에 문의" name="developerEmail" placeholder="이메일 주소 또는 URL을 입력해 주세요." value="${item.developerEmail}">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 코드사용방법</th>
							<td>
								<div class="editor-area">
									<textarea id="codeMethod" name="codeMethod" title="코드사용방법" >${item.codeMethod}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'codeMethod', {
						                    width:'100%',
						                    height:'700px',
						                    filebrowserImageUploadUrl: '<c:url value="/GM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                    });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 혜택</th>
							<td>
								<div class="editor-area">
									<textarea id="benefitSumm" name="benefitSumm" title="혜택" >${item.benefitSumm}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'benefitSumm', {
						                    width:'100%',
						                    height:'50px'
						                    ,fontSize_defaultLabel:'12px'
						                    });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>유효기간</th>
							<td>
								<input type="text" id="validDt" name="validDt" title="유효기간" class="hasDatepicker" value="${item.validDt}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게시기간</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value="${item.startDt}" readonly="readonly"></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value="${item.endDt}" readonly="readonly"></span>
							</td>
						</tr>
						<tr style="display:none;"><!-- 20161025 ycyu mod > 이벤트혜택 사용안함 -->
							<th scope="row"> 이벤트혜택(사용안함)</th>
							<td>
								<div class="editor-area">
									<textarea id="benefitDetail" name="benefitDetail" title="이벤트혜택">${item.benefitDetail}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'benefitDetail', {
						                    width:'100%',
						                    height:'200px',
						                    filebrowserImageUploadUrl: '<c:url value="/GM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                    });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게임리뷰</th>
							<td>
								<div class="editor-area">
									<textarea id="review" name="review" title="게임리뷰">${item.review}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'review', {
						                    width:'100%',
						                    height:'700px',
						                    filebrowserImageUploadUrl: '<c:url value="/GM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                    });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게임광고주ID</th>
							<td>
								<input type="text" title="게임광고주 ID" name="adId" placeholder="ID를 입력해 주세요." value="${item.adId }" >
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게임광고주 PW</th>
							<td>
								<input type="password" title="게임광고주 PW" name="adPw" placeholder="PW를 입력해 주세요." value="${item.adPw }" >
							</td>
						</tr>
						<tr>
							<th scope="row">메모</th>
							<td>
								<textarea id="memo" name="memo" rows="5" cols="10" placeholder="캠페인 진행사항, 캠페인 이슈, 일정변동, 광고 집행금액등 운영상 필요한 내용을 메모하시기 바랍니다. (광고주는 메모에 입력된 내용을 볼 수 없습니다.)">${item.memo }</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="btn-area ar">
			<%-- <a href="<c:url value="/GM/GM01"/>" class="btn-black2">목록</a> --%>
			<a href="javascript:history.back();" class="btn-black2">목록</a>
			
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
			<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
		</div>

	</div>
<div id="listPopup" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">리스트</h2>
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