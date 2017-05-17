<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>홈 > 커뮤니티 > 커뮤니티 관리 > 게시글등록(수정)</title>
	
	<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
	<script>
		$(function(){
			$('.btnsave').click(function(){
				
				if(valid())
				{
					var form = $('form')[0];	//FormData parameter에 담아줌				
					var formData = new FormData(form);
					
					if ( confirm('입력하신 내용으로 게시글을 등록하시겠습니까?')){
						$.ajax({
			                url: '<c:url value="/CM/UF/UF0303"/>',
			                processData: false,
			                contentType: false,
			                data: formData,
			                type: 'POST',
			                success: function(result){
			                    alert("등록 되었습니다");
			                    
			                  	//20161020 ycyu add > 커뮤니티리스트 제거로 인해 게시글쓰기 기능을 게시글관리 페이지로 이동되었음, 따라서 등록후 게시글관리 페이지로 이동하도록 수정함
			                  	location.href = '<c:url value="/CM/UF/UF02"/>';
			                    //location.href = '<c:url value="/CM/UF/UF03"/>';			                    
			                },
			                error: function(){
			                	alert("<spring:message code='ui.create.alert.failure'/>");			                	
			                }
			            });
					}
				}
			});
			
			$('.btnmod').click(function(){
				
				if(valid())
				{
					var form = $('form')[0];	//FormData parameter에 담아줌				
					var formData = new FormData(form);
					
					if ( confirm('입력하신 내용으로 게시글을 수정하시겠습니까?')){
						$.ajax({
			                url: '<c:url value="/CM/UF/UF0305"/>',
			                processData: false,
			                contentType: false,
			                data: formData,
			                type: 'POST',
			                success: function(result){
			                    alert("수정 되었습니다");
			                    location.href = '<c:url value="/CM/UF/UF02"/>';
			                },
			                error: function(){
			                	alert("<spring:message code='ui.create.alert.failure'/>");			                	
			                }
			            });
					}
				}
			});
			
		});
		
		//20160929 ycyu mod > 매니저가 등록했을때 빼고 수정이 안됐었음, 그외에도 수정이 가능하도록 변경함
		function valid(){
			var targetId = $(':radio[name="targetList"]:checked').val();
			var userNo = $("#userNo").val();
			if(userNo == null || userNo == ''){
				if(targetId == null || targetId == ''){
					alert('닉네임을 선택하세요!');
					return false;
				}else{
					$("#userNo").val(targetId);
				}	
			}else{
				if(targetId != null && targetId != ''){
					$("#userNo").val(targetId);
				}
			}
			
			
			var isDisplay = $(':radio[name="isDisplay"]:checked').val();
			if(isDisplay == null || isDisplay == ''){
				alert('보이기/숨기기를 선택하세요!');
				return false;
			}else{
				$("#showYn").val(isDisplay);
			}
			
			
			$('#comment').val(CKEDITOR.instances.comment.getData());
			if ( $('textarea[name=comment]').val() == ''){
				alert('게시글을 입력하세요.')
				return false;
			}else{
				$('#comment').val(CKEDITOR.instances.comment.getData());
			}
			
			var isEvent = $(':radio[name="isEvent"]:checked').val();
			if(isEvent == null || isEvent == ''){
				alert('이벤트 여부를 선택하세요.!');
				return false;
			}else{
				$("#topYn").val(isEvent);
			}
			
			return true;
		}
		
		
		$(document).ready(function(){
			
		});
		
	</script>
</head>
<body>
	<!-- localtion -->
	<p class="location">
		<a href="#none" class="home">커뮤니티</a> &gt; <strong>게시글 등록(수정)</strong>
	</p>
	
	<div class="inner-cont">
		<div class="title-area">
			<!-- Title -->
			<h2>게시글  등록(수정)<c:if test="${params.gameNm != null and params.gameNm != ''}"> - <font color="blue">${params.gameNm}</font></c:if> </h2>
			<p>게시글을 등록(수정)합니다.<span class=""></span></p>
		</div>
		
		
		<div class="table-form2">
			<form id="frmact" method="post">
				<input type="hidden" name="seqNo" id="seqNo" value="${params.seqNo }"/>
				<input type="hidden" name="showYn" id="showYn" value="${params.showYn }"/>
				<input type="hidden" name="communitySeq" id="communitySeq" value="${params.communitySeq }"/>
				<input type="hidden" name="userNo" id="userNo" value="${params.userNo }"/>
				<input type="hidden" name="contImgUrl1" id="contImgUrl1" value="${params.contImgUrl1 }"/>
				<input type="hidden" name="contImgUrl2" id="contImgUrl2" value="${params.contImgUrl2 }"/>
				<input type="hidden" name="contImgUrl3" id="contImgUrl3" value="${params.contImgUrl3 }"/>
				<input type="hidden" name="contImgUrl4" id="contImgUrl4" value="${params.contImgUrl4 }"/>
				<input type="hidden" name="contImgUrl5" id="contImgUrl5" value="${params.contImgUrl5 }"/>
				<input type="hidden" name="contImgUrl6" id="contImgUrl6" value="${params.contImgUrl6 }"/>
				<input type="hidden" name="contImgUrl7" id="contImgUrl7" value="${params.contImgUrl7 }"/>
				<input type="hidden" name="contImgUrl8" id="contImgUrl8" value="${params.contImgUrl8 }"/>
				<input type="hidden" name="contImgUrl9" id="contImgUrl9" value="${params.contImgUrl9 }"/>
				<input type="hidden" name="contImgUrl10" id="contImgUrl10" value="${params.contImgUrl10 }"/>
				<input type="hidden" name="topYn" id="topYn" value="${params.topYn }"/>
				<table>
					<caption></caption>
					<colgroup>
						<col style="width:13%;">
						<col style="width:*;">
					</colgroup>
					<tbody>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 이벤트 여부 </th>
							<td>
								<input type="radio" id="sl1" name="isEvent" value="N" checked="checked" <c:if test="${params.topYn eq 'N'}">checked='checked'</c:if> > 일반
								<input type="radio" id="sl1" name="isEvent" value="Y" <c:if test="${params.topYn eq 'Y'}">checked='checked'</c:if> > 이벤트
							
								<c:if test="${modify ne 'Y'}">
								<%-- <c:if test="${topYn ne 'Y' or modify ne 'Y'}"> --%>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ※ 날짜선택: <input type="datetime" id="createDt" name="createDt" title="날짜선택" class="hasDatepicker" value="${params.createDt }" 
									placeholder="이벤트성 게시글 등록시 등록날짜를 변경할수 있습니다." >
									
								</c:if>
							</td>	
						</tr>
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 보이기/숨기기</th>
							<td>
								<input type="radio" id="sl1" name="isDisplay" value="Y" checked="checked" <c:if test="${params.showYn eq 'Y'}">checked='checked'</c:if> > 보이기
								<input type="radio" id="sl1" name="isDisplay" value="N" <c:if test="${params.showYn eq 'N'}">checked='checked'</c:if> > 숨기기
							</td>
						</tr>												
						
						<c:choose>
							<c:when test="${fn:length(users) > 0 }">
								<c:forEach var="item" items="${users}" varStatus="status">
									<tr>
										<th scope="row"><span class="required" title="필수">*</span> 닉네임(택1)</th>
										<td>
											<input type="radio" id="sl1" name="targetList" value="${item.userNo }"  
												<c:if test="${item.userNo eq params.userNo}"> checked='checked'</c:if>
												<c:if test="${modify eq 'Y'}"> disabled='disabled'</c:if> 
											> &nbsp;&nbsp;&nbsp;
											<img src="${item.profileImg }" style="width:50px;"/> &nbsp;&nbsp;&nbsp;
											${item.nick}
										</td>												
									</tr>
								</c:forEach>
							</c:when>									
						</c:choose>
						
						<tr>
							<th scope="row"><span class="required" title="필수">*</span> 게시글</th>
							<td>
								<div class="editor-area">
									<textarea id="comment" name="comment" title="게시글" >${params.comment }</textarea>
									<script type="text/javascript">
						                CKEDITOR.replace( 'comment', {
						                    width:'100%'
						                    ,height:'200px'
							                ,fontSize_defaultLabel:'12px'
						                });
					                </script>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 1</th>
							<td>
								<c:if test="${params.contImgUrl1 ne null and params.contImgUrl1 ne ''}">
									<img src="${params.contImgUrl1}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile1" name="contImgFile1" onchange="setFilename('imageFile1',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile1">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 2</th>
							<td>
								<c:if test="${params.contImgUrl2 ne null and params.contImgUrl2 ne ''}">
									<img src="${params.contImgUrl2}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile2" name="contImgFile2" onchange="setFilename('imageFile2',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile2">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 3</th>
							<td>
								<c:if test="${params.contImgUrl3 ne null and params.contImgUrl3 ne ''}">
									<img src="${params.contImgUrl3}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile3" name="contImgFile3" onchange="setFilename('imageFile3',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile3">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 4</th>
							<td>								
								<c:if test="${params.contImgUrl4 ne null and params.contImgUrl4 ne '' }">
									<img src="${params.contImgUrl4}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile4" name="contImgFile4" onchange="setFilename('imageFile4',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile4">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 5</th>
							<td>
								<c:if test="${params.contImgUrl5 ne null  and params.contImgUrl5 ne ''}">
									<img src="${params.contImgUrl5}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile5" name="contImgFile5" onchange="setFilename('imageFile5',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile5">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 6</th>
							<td>
								<c:if test="${params.contImgUrl6 ne null  and params.contImgUrl6 ne ''}">
									<img src="${params.contImgUrl6}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile6" name="contImgFile6" onchange="setFilename('imageFile6',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile6">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 7</th>
							<td>
								<c:if test="${params.contImgUrl7 ne null  and params.contImgUrl7 ne ''}">
									<img src="${params.contImgUrl7}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile7" name="contImgFile7" onchange="setFilename('imageFile7',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile7">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 8</th>
							<td>
								<c:if test="${params.contImgUrl8 ne null  and params.contImgUrl8 ne ''}">
									<img src="${params.contImgUrl8}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile8" name="contImgFile8" onchange="setFilename('imageFile8',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile8">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 9</th>
							<td>
								<c:if test="${params.contImgUrl9 ne null and params.contImgUrl9 ne '' }">
									<img src="${params.contImgUrl9}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile9" name="contImgFile9" onchange="setFilename('imageFile9',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile9">
								</div>								
							</td>
						</tr>
						<tr>
							<th scope="row">이미지 10</th>
							<td>
								<c:if test="${params.contImgUrl10 ne null  and params.contImgUrl10 ne ''}">
									<img src="${params.contImgUrl10}" style="width:100px;"/>								
								</c:if>
								<div class="input-file">
									<label class="btn-gray">
										파일첨부
										<input type="file" id="contImgFile10" name="contImgFile10" onchange="setFilename('imageFile10',this);">
									</label>
									<input type="text" readonly="readonly" title="이미지" id="imageFile10">
								</div>								
							</td>
						</tr>
						
					</tbody> 
				</table>
			</form>
		</div> 

		<div class="btn-area ar">
			<a href="<c:url value="/CM/UF/UF03"/>" class="btn-black2">목록</a>
			<c:if test="${modify eq 'Y'}">
				<button type="button" class="btn-black2 btnmod"><span>수정</span></button>
			</c:if>
			<c:if test="${modify ne 'Y'}">
				<button type="button" class="btn-black2 btnsave"><span>저장</span></button>
			</c:if> 
			
			
		</div>

	</div>

</body>
</html>