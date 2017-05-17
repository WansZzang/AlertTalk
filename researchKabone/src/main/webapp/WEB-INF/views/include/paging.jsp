<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="custom" uri="/tlds/custom-taglib"%>
 
<c:set var="page" value="1" />
<c:if test="${!empty param.currentPage}"><c:set var="page" value="${param.currentPage}" /></c:if>
<c:set var="indexPerPage" value="10" />
<c:if test="${!empty param.indexPerPage}"><c:set var="indexPerPage" value="${param.indexPerPage}" /></c:if>
<div class="paging">	
    <custom:paging name="paging" recordsPerPage="${recordsPerPage}" totalRecordCount="${totalRecordCount}" currentPage="${page}" indexPerPage="${indexPerPage}">
		<span class="pre">
        <%-- First --%>
        <c:if test="${!empty paging.firstPage.href}">
            <a href="${paging.firstPage.href}" class="first"><img src="/admin/common/images/bu-paging-pre1.gif" alt="처음 페이지"></a>
        </c:if>
 
        <%-- Prev --%>
        <c:if test="${!empty paging.previousPage.href}">
            <a href="${paging.previousPage.href}" class="prev"><img src="/admin/common/images/bu-paging-pre2.gif" alt="이전 페이지"></a>
        </c:if>
 		</span>
        <%-- Numbering --%>
        <span class="list">
            <c:forEach var="numbering" items="${paging.pages}" varStatus="status">
              <c:choose>
                <c:when test="${numbering.index eq paging.currentPage}">
                    <strong>${numbering.index}</strong>
                </c:when>
    
                <c:otherwise>
                    <a href="${numbering.href}" title="${numbering.index} 페이지">${numbering.index}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>
        </span>
        <span class="nxt">
        <%-- Next --%>
        <c:if test="${!empty paging.nextPage.href}">
            <a href="${paging.nextPage.href}" class="next"><img src="/admin/common/images/bu-paging-nxt2.gif" alt="다음 페이지"></a>
        </c:if>
 
        <%-- Last --%>
        <c:if test="${!empty paging.lastPage.href}">
            <a href="${paging.lastPage.href}" class="last"><img src="/admin/common/images/bu-paging-nxt1.gif" alt="마지막 페이지"></a>
        </c:if>
        </span>
    </custom:paging>
</div>