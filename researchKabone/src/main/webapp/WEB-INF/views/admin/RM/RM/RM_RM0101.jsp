<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    <script>
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(chartLoad);
    	//google.charts.setOnLoadCallback(chartLoad);
		$(function(){
			
		});

		function chartLoad()
		{
			for(var nCnt = 0; nCnt < $("input[name=pollType]").length ; nCnt++)
			{
				if($("input[name=pollType]")[nCnt].value == "2" ||$("input[name=pollType]")[nCnt].value == "3")
				{
			        var data = new google.visualization.DataTable();
			        
			        var strArr = $("input[name=pollResult]")[nCnt].value.split('|');
	
			        data.addColumn('string', '설문 조사');
			        data.addColumn('number', 'Slices');
			        data.addRows([
			          ['매우 그렇다', strArr[0]*1],
			          ['그렇다',  strArr[1]*1],
			          ['보통',  strArr[2]*1],
			          ['그렇지 않다',  strArr[3]*1],
			          ['전혀 그렇지 않다',  strArr[4]*1],
			        ]);
		
			        // Set options for Anthony's pie chart.
			        var options = {title:'설문 그래프'};
		
			        // Instantiate and draw the chart for Anthony's pizza.
			        var chart = new google.visualization.PieChart(document.getElementById($("input[name=pollType]")[nCnt].parentNode.childNodes[3].childNodes[3].id));
			        
			        chart.draw(data, options);
				}
				else if($("input[name=pollType]")[nCnt].value == "4" )
				{
					var iHtml = "";
					var strArr = $("input[name=pollResult]")[nCnt].value.split('|');
					
					iHtml += "<div class='table-form3'><table><caption></caption><colgroup><col style='width:100%;'></colgroup><tbody>"

					
					for(var nSubCnt = 0 ; nSubCnt < strArr.length ; nSubCnt++)
					{
						iHtml += "<tr><td>"+strArr[nSubCnt]+"</td></tr>"
					}

					iHtml += "</tbody></table></div>"
					
					$("input[name=pollResult]")[nCnt].parentNode.childNodes[3].innerHTML = iHtml;
				}
				else if($("input[name=pollType]")[nCnt].value == "5" )
				{
					var iHtml = "";
					var strArr = $("input[name=pollResult]")[nCnt].value.split('|');
					
					iHtml += "<div class='table-form3'><table><caption></caption><colgroup><col style='width:100%;'></colgroup><tbody>"

					
					for(var nSubCnt = 0 ; nSubCnt < strArr.length ; nSubCnt++)
					{
						iHtml += "<tr><td>"+strArr[nSubCnt]+"</td></tr>"
					}

					iHtml += "</tbody></table></div>"
					
					$("input[name=pollResult]")[nCnt].parentNode.childNodes[3].innerHTML = iHtml;
				}
			}
		}
	</script>
		<div class="table-form2">
			<table>
				<caption></caption>
				<colgroup>
					<col style="width:100%;">
				</colgroup>
				<tbody>
				<c:forEach items="${pollDetailList}" var="list">
					<tr>
						<th scope="row" >
							<span style="float: left;">${list.pollDesc}</span><br><br>
						</th>
					</tr>
					<c:if test="${list.pollType == 2 || list.pollType == 3 }">
					<tr>
						<input type="hidden" name="pollType" value="${list.pollType}">
						<td>
							<input type="hidden" name="pollResult" value="${list.pollResult}">
							<div id="${list.pollDetailSeq}" class="chartResult" style="width: 50%; min-height:300px;"></div>
						</td>
					</tr>
					</c:if>
					<c:if test="${list.pollType == 4 }">
					<tr>
						<input type="hidden" name="pollType" value="${list.pollType}">
						<td>
						<div>
							<input type="hidden" name="pollResult" value="${list.pollResult}">
							<div  id="${list.pollDetailSeq}" style="width: 100%; min-height:100px;">
							</div>
						</div>
						</td>
					</tr>
					</c:if>
					<c:if test="${list.pollType == 5 }">
					<tr>
						<input type="hidden" name="pollType" value="${list.pollType}">
						<td>
						<div>
							<input type="hidden" name="pollResult" value="${list.pollResult}">
							<div  id="${list.pollDetailSeq}" style="width: 100%; min-height:100px;">
							</div>
						</div>
						</td>
					</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>