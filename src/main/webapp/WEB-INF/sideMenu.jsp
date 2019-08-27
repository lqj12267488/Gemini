<%--
  Created by IntelliJ IDEA.
  User: EDZ
  Date: 2018/10/15
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach items="${menus}" var="menu">
    <li>
        <c:choose>
            <c:when test="${fn:length(menu.menuList)>0}">
                <a class="menu-content" href="javascript:void(0)" id="${menu.resourceid}">
                    <i class="icon-align-justify"></i>${menu.resourcename}
                </a>
                <c:set var="menus" value="${menu.menuList}" scope="request"/>
                <ul parent="${menu.resourceid}" class="menu-item">
                    <jsp:include page="sideMenu.jsp"/>
                </ul>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0)" class="menu" url="${menu.resourceurl}">
                        ${menu.resourcename}
                </a>
            </c:otherwise>
        </c:choose>
    </li>
</c:forEach>
