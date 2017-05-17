<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 도전과제</title>
	<style>
		.col-lg-6{
			position: relative;
		    min-height: 1px;
		    padding-right: 15px;
		    padding-left: 15px;
		}
		.input-group{
			position: relative;
		    display: table;
		    border-collapse: separate;
		}
	</style>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			//20161028 ycyu exp > 사용안함 > 도전과제 등록화면 진입시 자동으로 팝업되도록 변경함
			//게임선택
			$('#gameSelBtn').click(function(){
				$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
				showLayer($(this), 'gameListPopup');
			});
			
			$('.btnsave').click(function(){
				
				if ( valid() ){
					
					var _mission = [];
					
					$('td.missionItems').each(function(){
						var _delYn = $(this).find('input[type=radio]:checked').val();
						var _contents = $(this).find('input[name=missionContents]').val();
						var _refId = $(this).find('input[name=refId]').val();
						
						var _item = {
							'subNo' : $(this).data('subno'),
							'missionContents' : _contents,
							'refId' : _refId,
							'delYn' : _delYn
						};
						
						_mission.push(_item);
					});
					
					$('#notiMsg').val(CKEDITOR.instances.notiMsg.getData());
					
					var makeObj = {
						'missionTitle' : $('input[name=missionTitle]').val() ,
						'showYn' : $('input[name=optShowYN]:checked').val(),
						'recommendYn' : $('input[name=optRcmdYN]:checked').val(),
						'gameSeq': $('input[name=gameSeq]').val(),
						'showOrder' : $('input[name=showOrder]').val(),
						'validDt' : $('input[name=validDt]').val(),
						'startDt' : $('input[name=startDt]').val(),
						'endDt' : $('input[name=endDt]').val(),
						'items' : _mission,
						'missionType' : $('input[name=optMissionType]:checked').val(),
						'notiMsg' : $('#notiMsg').val(),
						'recvEmail' : $('input[name=recvEmail]').val()
						, 'ageLimit' : $('input[name=ageLimit]').val()
					};
					
					
					$.ajax({
		                url: '<c:url value="/DM/DM03"/>',
		                data: JSON.stringify(makeObj),
		                contentType:"application/json; charset=UTF-8",
		                type: 'POST',
		                success: function(result){
		                	alert("<spring:message code='ui.create.alert.success'/>");
		                    location.href = '<c:url value="/DM/DM01"/>';
		                },
		                error: function(){
		                	alert("<spring:message code='ui.create.alert.failure'/>");
		                }
		            });
				}
			});
			
			$('td.missionItems input[type=radio]').click(function(){
				var _delYn = $(this).val();
				
				if ( _delYn == 'Y'){
					$(this).parent().parent().parent().parent().find('input[name=missionContents]').val('');
					$(this).parent().parent().parent().parent().find('input[name=refId]').val('');
				}
				
			});
			
			//20161028 ycyu add > 도전과제 리스트를 선택하지 않았을 경우 닫기
			$('.btnPopClose2').click(function(e){
				history.back();
			});
			
		});
		
		function valid(){
			
			if ( $('input[name=gameSeq]').val() == ''){
				alert('게임을 선택하세요.')
				return false;
			}
			
			if ( $('input[name=optShowYN]:checked').val() == 'Y' && $('input[name=showOrder]').val() == ''){
				alert('노출순서를  입력하세요.')
				return false;
			}
			
			if ( $('input[name=recvEmail]').val() == ''){
				alert('이메일을 입력하세요.')
				return false;
			}
			//20161019 ycyu del > 사용안함
			/* 
			$('#notiMsg').val(CKEDITOR.instances.notiMsg.getData());
			if ( $('textarea[name=notiMsg]').val() == ''){
				alert('공지문구를 입력하세요.')
				return false;
			}
			 */
			if ( $('input[name=validDt]').val() == ''){
				alert('유효기간을 입력하세요.')
				return false;
			}
			
			if ( $('input[name=startDt]').val() == ''){
				alert('게시기간 시작일자를 입력하세요.')
				return false;
			}
			
			if ( $('input[name=endDt]').val() == ''){
				alert('게시기간 종료일자를 입력하세요.')
				return false;
			}
			
			if ( $('input[name=missionTitle]').val() == ''){
				alert('제목을 입력하세요.')
				return false;
			}
			
			var isMissionItemCount = 0;
			var isValid = true;
			$('td.missionItems').each(function(){
				if ( $(this).find('input[type=radio]:checked').val() == 'N'){
					isMissionItemCount++;
					if ( $(this).find('input[name=missionContents]').val() == '' ){
						isValid = false;
						return false;
					}
				}
			});
			
			if ( isMissionItemCount < 10){
				alert('미션은 10개 모두 입력하셔야 합니다.');
				return false;
			}
			
			if ( !isValid ){
				alert('미션사용시 미션명을 입력하세요.');
				return false;
			}
		
			return true;
		}
		
		function selectGame(_seqNo, _lang, _gameName, _gamePacNm){
			$('input[name=gameNm]').val(_gameName);
			$('input[name=gameSeq]').val(_seqNo);
			
			$('#popupIfrm').attr('src','');
			//close popup
			$('.btnPopClose').click();
		}		
		//게임등급정보
		function selectGameAgeLimit(_ageLimit){
			$('input[name=ageLimit]').val(_ageLimit);			
		}
		
		//20161028 ycyu add > 도전과제 등록페이지 진입시 자동으로 게임리스트 팝업 노출
		function ShowPopupGameList(){
			$('h2.tit').text('도전과제등록 > 게임리스트');
			$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
			$('.btnPopClose2').show();
			showLayer($(this), 'gameListPopup');
		}
		
		$(document).ready(function(){
			ShowPopupGameList();
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">도전과제</a> &gt;
		<strong>도전과제  등록</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>도전과제  등록</h2>
			<p>도전과제를 등록합니다..<span class=""></span></p>
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="showYn"/>
				<input type="hidden" name="gameSeq"/>
				<input type="hidden" name="recommendYn"/>
				<input type="hidden" name="missionType"/>
								
				<input type="hidden" name="ageLimit"/>
				
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게임명</th>
							<td>
								<div class="addr-input">
									<input type="text" title="패키지명" name="gameNm" placeholder="게임을 선택해 주세요." readonly="readonly">
									<a href="#none" class="btn-gray" id="gameSelBtn" style="display:none;">게임선택</a> <!-- 20161028 ycyu del > 최초 진입시 선택하도록 변경-->
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showOrder" placeholder="숫자로 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" checked="checked" value="Y">
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N" checked="checked">
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
										<input type="radio" name="optRcmdYN" checked="checked" value="Y">
										<label for="at1">추천</label>
									</li>
									<li>
										<input type="radio" name="optRcmdYN" value="N" checked="checked">
										<label for="at2">추천안함</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr style="display:none;">	<!-- 20161019 ycyu mod > 타입 사용안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 타입</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optMissionType" value="00">
										<label for="at1">자동</label>
									</li>
									<li>
										<input type="radio" name="optMissionType" checked="checked" value="09">
										<label for="at2">수동</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 이메일</th>
							<td>
								<input type="text" title="이메일" name="recvEmail" placeholder="도전과제 인증샷을 받을 이메일 주소를 입력해 주세요">
							</td>
						</tr>
						
						<tr style="display:none;">	<!-- 20161019 ycyu mod > 공지문구 사용안함 -->
							<th scope="row"><span class="required" title="필수">*</span> 공지문구</th>
							<td>
								<div class="editor-area">
									<textarea id="notiMsg" name="notiMsg" title="공지문구"></textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'notiMsg', {
						                    width:'100%',
						                    height:'200px',
						                    filebrowserImageUploadUrl: '<c:url value="/DM/upload/ckImage"/>'
							                ,fontSize_defaultLabel:'12px'
						                });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>유효기간</th>
							<td>
								<input type="text" id="validDt" name="validDt" title="유효기간" class="hasDatepicker" value="">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span>게시기간</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value=""></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value=""></span>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 제목</th>
							<td>
								<input type="text" title="제목" name="missionTitle" placeholder="제목을 입력해 주세요(24자 이내)">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 1_미션</th>
							<td class="missionItems" data-subno="1">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse1" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse1" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 2_미션</th>
							<td class="missionItems" data-subno="2">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse2" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse2" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="missionContents" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 3_미션</th>
							<td class="missionItems" data-subno="3">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse3" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse3" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 4_미션</th>
							<td class="missionItems" data-subno="4">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse4" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse4" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 5_미션</th>
							<td class="missionItems" data-subno="5">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse5" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse5" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 6_미션</th>
							<td class="missionItems" data-subno="6">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse6" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse6" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 7_미션</th>
							<td class="missionItems" data-subno="7">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse7" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse7" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 8_미션</th>
							<td class="missionItems" data-subno="8">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse8" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse8" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 9_미션</th>
							<td class="missionItems" data-subno="9">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse9" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse9" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 10_미션</th>
							<td class="missionItems" data-subno="10">
								<ul class="radio-group">
									<li>
										<input type="radio" name="missionIUse10" value="N" checked="checked">
										<label for="at1">사용</label>
									</li>
									<li>
										<input type="radio" name="missionIUse10" value="Y" >
										<label for="at2">사용안함</label>
									</li>
								</ul>
								<div class="input-group">
									<input type="text" title="미션" name="missionContents" placeholder="미션명을 입력해 주세요(50자 이내)" style="width:500px;">
									<input type="text" title="RefId" name="refId" placeholder="ReferenceId" style="display:none;">
								</div>
							</td>
						</tr>
					</tbody> 
				</table>
			</form>
		</div> 

		<div class="btn-area ar">
			<a href="<c:url value="/DM/DM01"/>" class="btn-black2">목록</a>
			<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
		</div>

	</div>
<div id="gameListPopup" class="modal-pop">
	<div class="modal-cotainer">
		<div class="modal-content">
			<!-- content -->
			<h2 class="tit">게임리스트</h2>
			<div class="search-detail">
				<h3 class="blind"> </h3>
				<div>
					<iframe id="popupIfrm" src="" style="width:100%;height:800px;border:0;frameborder:0;"></iframe>
				</div>
			</div>
		</div>
		<button type="button" class="close btnPopClose">레이어팝업 닫기</button>
		<button type="button" class="close btnPopClose2">레이어팝업 닫기</button><!-- 20161028 ycyu add -->
	</div>
</div>
</body>
</html>