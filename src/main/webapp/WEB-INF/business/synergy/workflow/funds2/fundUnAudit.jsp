
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${data}" var="list">
    <div class="messages-item-date">
        <div class="col-md-8" style="width: auto">
            <a href="#" onclick="fAudit('${list.url}','${list.tableName}', '${list.businessId}','1')">
                    ${list.name}：${list.createTime}  &nbsp;&nbsp;&nbsp;&nbsp;${list.workflowName}
            </a>
        </div>
        <%--<div class="col-md-5 tar">
            <span >${list.createTime}</span>
        </div>--%>
    </div>
</c:forEach>
<style>
    a:link {}     /* 未访问的链接 */
    a:visited {}  /* 已访问的链接 */
    a:hover {text-decoration:underline;}    /* 当有鼠标悬停在链接上 */
    a:active {}   /* 被选择的链接 */
</style>