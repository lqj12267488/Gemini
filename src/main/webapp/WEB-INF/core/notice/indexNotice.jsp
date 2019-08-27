<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/11
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%--<div class="content messages npb">
    <c:forEach items="${data}" var="list">
        <div class="messages-item ${list.messagesClass} ">
            <img style="width: 35px;height: 35px;"
                 src="<%=request.getContextPath()%>/userImg/${list.photoUrl}"
                 class="img-circle img-thumbnail"/>
            <div class="messages-item-text">
                <a href="#"
                   title="${list.title}" onclick="viewNotice('${list.id}','${list.type}','${list.abc}')" class="list-text-name">
                    <c:if test="${list.title.length() < 20}">
                        【${list.typeShow}】${list.title}
                    </c:if>
                    <c:if test="${list.title.length() >= 20}">
                        【${list.typeShow}】${fn:substring(list.title, 0, 17)}..
                    </c:if>
                </a>
            </div>
            <div class="messages-item-date">${fn:substring(list.createTime, 0, 10)}</div>
        </div>
    </c:forEach>
</div>--%>

<%--循环出首页的列表--%>
<c:forEach items="${data}" var="list">
    <div class="messages-item-date">
        <div class="col-md-9">
            <c:if test="${list.title.length() < 20}">
                <a href="#" title="${list.title}" onclick="viewNotice('${list.id}','${list.type}','${list.abc}')">
                    <c:if test="${list.isDean.length() > 0}">
                        《${list.isDean}》
                    </c:if>
                    【${list.typeShow}】${list.title}
                </a>
            </c:if>
            <c:if test="${list.title.length() >= 20}">
                <a href="#" title="${list.title}" onclick="viewNotice('${list.id}','${list.type}','${list.abc}')">
                    【${list.typeShow}】${fn:substring(list.title, 0, 17)}..
                </a>
            </c:if>
        </div>
        <div class="col-md-3 tar">
            <span>${fn:substring(list.createTime, 0, 10)}</span>
        </div>
    </div>
</c:forEach>
<style>
    a:link {
    }

    /* 未访问的链接 */
    a:visited {
    }

    /* 已访问的链接 */
    a:hover {
        text-decoration: underline;
    }

    /* 当有鼠标悬停在链接上 */
    a:active {
    }

    /* 被选择的链接 */
</style>