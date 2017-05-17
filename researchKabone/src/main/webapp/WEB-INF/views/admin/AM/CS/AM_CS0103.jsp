<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 금수저쿠폰 > 예정게임</title>
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('#gameSelBtn').click(function(){
				//게임 검색창 팝업
				$('#popupIfrm').attr('src', '<c:url value="/popup/RM/GM/GM01"/>');
				showLayer($(this), 'gameListPopup');
			});
			//등록>저장
			$('.btnsave').click(function(){
				//multi form일 경우 null을 수용하지 않으므로 default값을 설정한다.
				if ( $('input[name=seqNo]').val() == ''){
					$('input[name=seqNo]').val(0);
				}
				if ( $('input[name=gameSeq]').val() == ''){
					$('input[name=gameSeq]').val(0);
				}
				if ( $('input[name=gamePacNm]').val() == ''){
					$('input[name=gamePacNm]').val("");
				}				
				
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				
				if ( $('input[name=gameNm]').val() == ''){
					alert('게임명이 입력되지 않았거나 게임이 선택되지 않았습니다.');
					return false;
				}
				
				if ( $('input[name=schedule]').val() == ''){
					alert('라이브예정 문구를 입력하세요.');
					return false;
				}
				
				$('#discription').val(CKEDITOR.instances.discription.getData());
				if ( $('textarea[name=discription]').val() == ''){
					alert('설명을 입력하세요.');
					return false;
				}
				
				$('input[name=ageLimit]').val($('input[name=optAgeLimit]:checked').val());
				
				
				/* if ( $('input[name=thumbUrl]').val() == '' && $('input[name=thumbImgFile]').val() == ''){
					alert('썸네일 이미지를 선택하세요.');
					return false;
				} */
				
				/* if ( $('input[name=imgUrl]').val() == '' && $('input[name=contImgFile]').val() == ''){
					alert('상세 이미지를 선택하세요.');
					return false;
				} */

				var form = $('form')[0];
				var formData = new FormData(form);
				
				$.ajax({
	                url: '<c:url value="/GM/CS/CS03"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                   alert("<spring:message code='ui.create.alert.success'/>");
	                    location.href = '<c:url value="/GM/CS/CS01"/>';
	                },
	                error: function(){
	                	alert("<spring:message code='ui.create.alert.failure'/>");
	                }
	            });
				
			});
			
			//수정>저장
			$('.btnsave2').click(function(){
				
				$('input[name=showYn]').val($('input[name=optShowYN]:checked').val());
				
				if ( $('input[name=gameNm]').val() == ''){
					alert('게임명이 입력되지 않았거나 게임이 선택되지 않았습니다.');
					return false;
				}

				if ( $('input[name=schedule]').val() == ''){
					alert('라이브예정 문구를 입력하세요.');
					return false;
				}
				
				$('#discription').val(CKEDITOR.instances.discription.getData());
				if ( $('textarea[name=discription]').val() == ''){
					alert('설명을 입력하세요.');
					return false;
				}
				
				$('input[name=ageLimit]').val($('input[name=optAgeLimit]:checked').val());

				/* if ( $('input[name=thumbUrl]').val() == '' && $('input[name=thumbImgFile]').val() == ''){
					alert('썸네일 이미지를 선택하세요.');
					return false;
				} */
						
				/* if ( $('input[name=imgUrl]').val() == '' && $('input[name=contImgFile]').val() == ''){
					alert('상세 이미지를 선택하세요.');
					return false;
				} */
				
				var form = $('form')[0];
				var formData = new FormData(form);
				
				$.ajax({
	                url: '<c:url value="/GM/CS/CS04"/>',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                   alert("<spring:message code='ui.modify.alert.success'/>");
	                    location.href = '<c:url value="/GM/CS/CS01"/>';
	                },
	                error: function(){
	                	alert("<spring:message code='ui.modify.alert.failure'/>");
	                }
	            });
				
			});
			//삭제
			$('.btnDel').click(function(){
				if ( confirm("삭제하시겠습니까?")){
					$.ajax({ 
						type: 'POST',
						url: '<c:url value="/GM/CS/CS05"/>',
						data: 'seqNo=${item.seqNo}',
						error:function(data){
							alert("<spring:message code='ui.delete.alert.failure'/>");
						},
						success:function(data){
							alert("<spring:message code='ui.delete.alert.success'/>");
							location.href = '<c:url value="/GM/CS/CS01"/>';
						}
					});
				}
			});
			
			
		});
		

		function selectGame(_seqNo, _lang, _gameName, _gamePacNm){
			$('input[name=gameNm]').val(_gameName);
			$('input[name=gameSeq]').val(_seqNo);
			$('input[name=gamePacNm]').val(_gamePacNm);
			
			$('#popupIfrm').attr('src','');
			//close popup
			$('.btnPopClose').click();
		}
		//게임등급정보
		function selectGameAgeLimit(_ageLimit){
			$('input[name=ageLimit]').val(_ageLimit);		
			
			//게임선택시 게임등급은 자동설정된다.
			if(_ageLimit == 0){
				$("input[name=optAgeLimit]").eq(0).prop("checked",true);
			}else if(_ageLimit == 12){
				$("input[name=optAgeLimit]").eq(1).prop("checked",true);
			}else if(_ageLimit == 15){
				$("input[name=optAgeLimit]").eq(2).prop("checked",true);
			}else if(_ageLimit == 18){
				$("input[name=optAgeLimit]").eq(3).prop("checked",true);
			}
			
			//게임을 선택한 이후에는 등급을 수정할수 없음
			$("input[name=optAgeLimit]").prop("disabled",true);	
			
		}
		//게임리스트 팝업에서 썸네일 수신 
		function selectGameThumbnail(_thumbnailUrl){
			$('input[name=thumbUrl]').val(_thumbnailUrl);
			$("#thumbnail").attr("src", _thumbnailUrl);
		}
		
		$(document).ready(function(){
			var gameSeq = $('input[name=gameSeq]').val();
			if(gameSeq != null && gameSeq != 0){
				//게임을 선택한 이후에는 등급을 수정할수 없음
				$("input[name=optAgeLimit]").prop("disabled",true);	
			}
			
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">금수저쿠폰</a> &gt;
		<a href="#none" >예정게임</a> &gt;
		<c:if test="${modify ne 'Y'}">
			<strong>예정게임 등록</strong>
		</c:if>
		<c:if test="${modify eq 'Y'}">
			<strong>예정게임 수정</strong>
		</c:if>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<c:if test="${modify ne 'Y'}">
				<h2>예정게임 등록</h2>
				<p>예정게임을 등록합니다.<span class=""></span></p>	
			</c:if>
			<c:if test="${modify eq 'Y'}">
				<h2>예정게임 수정</h2>
				<p>예정게임을 수정합니다.<span class=""></span></p>
			</c:if>
			
		</div>
		
		<div class="table-form2">
			<form id="frmact" method="post" enctype="multipart/form-data">
				<input type="hidden" name="seqNo" value="${item.seqNo}"/>
				<input type="hidden" name="showYn" value="${item.showYn}"/>
				<input type="hidden" name="gameSeq" value="${item.gameSeq}"/>
				<input type="hidden" name="gamePacNm" value="${item.gamePacNm}"/>
				<input type="hidden" name="imgUrl" value="${item.imgUrl }"/>
				<input type="hidden" name="thumbUrl" value="${item.thumbUrl }"/>
				
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
									<input type="text" title="게임명" name="gameNm" value="${item.gameNm }" placeholder="게임을 선택해 주세요.">
									<c:if test="${item.gameSeq eq null or item.gameSeq eq 0}">
										<a href="#none" class="btn-gray" id="gameSelBtn">게임선택</a>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출여부</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optShowYN" checked="checked" value="Y" <c:if test="${item.showYn eq 'Y'}">checked='checked'</c:if>>
										<label for="at1">노출</label>
									</li>
									<li>
										<input type="radio" name="optShowYN" value="N" <c:if test="${item.showYn eq 'N'}">checked='checked'</c:if>>
										<label for="at2">미노출</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 노출순서</th>
							<td>
								<input type="text" title="노출순서" name="showOrder" value="${item.showOrder }" placeholder="순서를 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 라이브예정</th>
							<td>
								<input type="text" title="라이브예정" name="schedule" value="${item.schedule }" placeholder="라이브예정 문구를 입력해 주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 설명</th>
							<td>
								<div class="editor-area">
									<textarea id="discription" name="discription" title="설명">${item.discription}</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'discription', {
						                    width:'100%',
						                    height:'100px',
						                    fontSize_defaultLabel:'12px'
						                    , enterMode : CKEDITOR.ENTER_BR
						                });
					                </script>
					                <!--
					                	CKEDITOR > P 태그를 BR 태그로 변경 
					                		-> enterMode : CKEDITOR.ENTER_BR
					                 -->
								</div>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게시일</th>
							<td>
								<span class="search-group">시작일 : <input type="text" id="startDt" name="startDt" title="날짜선택" class="hasDatepicker" value="${item.startDt }"></span>
								<span class="search-p"> ~ </span>
								<span class="search-group">종료일 : <input type="text" id="endDt" name="endDt" title="날짜선택" class="hasDatepicker" value="${item.endDt }"></span>
							</td>
						</tr>
						
						<tr>
							<th scope="row"> 썸네일</th>
							<td>								
								<img id="thumbnail" <c:if test="${item.thumbUrl ne null and item.thumbUrl ne '' }">src="${item.thumbUrl}"</c:if> style="width:100px;"/>								
								
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="thumbImgFile" name="thumbImgFile" onchange="setFilename('thumbFile',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="thumbFile" placeholder="미등록시 default 이미지로 등록됩니다.">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"> 이미지</th>
							<td>								
								<img id="detailImg" <c:if test="${item.imgUrl ne null and item.imgUrl ne '' }">src="${item.imgUrl}"</c:if> style="width:200px;"/>								
								
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile" name="contImgFile" onchange="setFilename('imageFile',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 이용등급</th>
							<td>
								<ul class="radio-group">
									<li>
										<input type="radio" name="optAgeLimit" checked="checked" <c:if test="${item.ageLimit == 0}">checked="checked"</c:if> value="0">
										<label for="at1">
											<img src="/admin/common/images/main_visual_icon1.png" style="width:50px;"/>
										</label>
									</li>
									<li>
										<input type="radio" name="optAgeLimit" <c:if test="${item.ageLimit == 12}">checked="checked"</c:if> value="12">
										<label for="at2">
											<img src="/admin/common/images/main_visual_icon2.png" style="width:50px;"/>
										</label>
									</li>
									<li>
										<input type="radio" name="optAgeLimit" <c:if test="${item.ageLimit == 15}">checked="checked"</c:if> value="15">
										<label for="at3">
											<img src="/admin/common/images/main_visual_icon3.png" style="width:50px;"/>
										</label>
									</li>
									<li>
										<input type="radio" name="optAgeLimit" <c:if test="${item.ageLimit == 18}">checked="checked"</c:if> value="18">
										<label for="at4">
											<img src="/admin/common/images/main_visual_icon4.png" style="width:50px;"/>
										</label>
									</li>
								</ul>
								</br>※ 게임선택으로 등록된 예정게임의 이용등급은 게임관리에서 수정이 가능합니다. 
							</td>
						</tr>
						
					</tbody>
				</table>
				
			</form>
		</div>

		<div class="btn-area ar">
			<a href="<c:url value="/GM/CS/CS01"/>" class="btn-black2">목록</a>
			
			<c:if test="${modify ne 'Y'}">
				<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
			</c:if>
			<c:if test="${modify eq 'Y'}">
				<button type="button" class="btn-black2 btnsave2"><span>저장</span></button>
				<button type="button" class="btn-black2 btnDel"><span>삭제</span></button>
			</c:if>
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
	</div>
</div>
</body>
</html>