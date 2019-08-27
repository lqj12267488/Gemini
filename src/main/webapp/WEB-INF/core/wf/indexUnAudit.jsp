<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/11
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${data}" var="list">
    <div class="messages-item-date">
    <div class="col-md-7">
        <a href="#"
           onclick="loadAudit('${list.url}','${list.tableName}', '${list.businessId}','1','${list.abc}','${list.state}','${list.editUrl}')">
                ${list.name}：<c:if test="${list.state == 3} && ${list.tableName !='T_ZW_REPAIR'}">【驳回】</c:if>${list.workflowName}
        </a>
    </div>
    <div class="col-md-5 tar">
        <span>${list.createTime}</span>
    </div>

</c:forEach>
<%--<div class="content list">
    <c:forEach items="${data}" var="list">
        <div class="list-item" >
            <div class="list-info">
                <img style="height: 50px;width: 50px;" src="<%=request.getContextPath()%>/userImg/${list.photoUrl}" class="img-circle img-thumbnail"/>
            </div>
            <div class="list-text">
                <a href="#"
                   onclick="loadAudit('${list.url}','${list.tableName}', '${list.businessId}','1','${list.abc}','${list.state}','${list.editUrl}')" class="list-text-name">
                        ${list.name}：<c:if test="${list.state == 3 and list.tableName !='T_ZW_REPAIR'}">【驳回】</c:if>${list.workflowName}
                </a>
                <p>${list.createTime}</p>
            </div>
        </div>
    </c:forEach>
</div>--%>
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