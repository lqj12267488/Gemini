<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <span style="font-size: 14px">&nbsp;</span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div id="associationTable"  class="controls" style="width: auto"></div>
        </div>
        <div class="modal-footer">
            <div class="form-row">
                <div class="col-md-12" style="text-align: center">
                    <br>
                    流程轨迹：
                    <c:forEach items="${nodes}" var="node">
                        <c:choose>
                            <c:when test="${node.nodeId == '-1'}">
                                <c:if test="${node.nodeId == cuurentNodeId}">
                                    <span style="font-size: 14px">办结</span>
                                </c:if>
                                <c:if test="${node.nodeId != cuurentNodeId}">
                                    办结
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${node.nodeId == cuurentNodeId}">
                                    <span style="font-size: 16px">${node.nodeName}</span>
                                </c:if>
                                <c:if test="${node.nodeId != cuurentNodeId}">
                                    ${node.nodeName}
                                </c:if>
                                <c:if test="${node.nodeOrder != size}">
                                    <span class=" icon-arrow-right"></span>
                                </c:if>

                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
            <div style="text-align: center">
                <br>
                <h4>流程日志</h4>
                <c:forEach items="${workflowLog}" var="log">
                                <span style="font-size: 18px">${log.cuurentNodeId}：${log.handleName}
                                    <c:if test="${empty log.handleTime}">
                                        ${log.createTime}
                                    </c:if>
                                    <c:if test="${not empty log.handleTime}">
                                        ${fn:substring(log.handleTime, 0, 19)}
                                    </c:if>
                                </span><br/>
                    <c:if test="${empty log.remark}">
                        无<br/>
                    </c:if>
                    <c:if test="${not empty log.remark}">
                        ${log.remark}<br/>
                    </c:if>
                </c:forEach>
            </div>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>

    </div>
</div>
<input id="tableName" hidden value="${tableName}">
<input id="businessId" hidden value="${businessId}">
<input id="termWorkflow" hidden>

<script>
    var handleName = "";
    var personId = "";
    $("#associationTable").load('<%=request.getContextPath()%>${url}', {
        url: '<%=request.getContextPath()%>'+'${url}',
        tableName: '${tableName}',
        id: '${businessId}',
        businessId: '${businessId}',
        flag: '${flag}'
    }, function () {

    })
</script>
