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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body>
<div class="mui-inner-wrap">
    <header class="mui-bar mui-bar-nav">
        <a id="back" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 id="title" class="mui-title">待办事项</h1>
    </header>
    <div class="mui-content">
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div id="business"></div>
            <div id="file" class="form-row">
                <div class="col-md-3 tar"style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;">
                    附件
                </div>
            </div>
            <div style="text-align: center;height:25px;" id="noticflag">
                <center>
                    <button id="saveBtn" class="mui-btn mui-btn-primary" style="width:80%;"
                            onclick="yesReadedt()" >标为已读</button>
                </center>
            </div>
            <div class="mui-input-row">
                <div style="text-align: center">
                    <br>
                    流程轨迹：
                    <c:forEach items="${nodes}" var="node">
                        <c:if test="${node.nodeId == cuurentNodeId}">
                            <span><font color="blue" size="4px">${node.nodeName}</font> </span>
                        </c:if>
                        <c:if test="${node.nodeId != cuurentNodeId}">
                            ${node.nodeName}
                        </c:if>
                        <c:if test="${node.nodeOrder != size}">
                            →
                        </c:if>
                        <span class=" icon-arrow-right"></span>
                    </c:forEach>
                </div>
            </div>
            <div style="text-align: center">
                <br>
                <h4>流程日志</h4>
                <c:forEach items="${workflowLog}" var="log">
                <span style="font-size: 18px">${log.handleName}
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
        </div>
    </div>
    <input id="tableName" hidden value="${tableName}">
    <input id="businessId" hidden value="${businessId}">
    <input id="term" hidden>
</div>
<script>
    var handleName = "";
    var personId = "";
    $(document).ready(function () {
        $("#business").load('<%=request.getContextPath()%>'+'${url}');
        if('${state}' != '2'){
            $("#noticflag").hide();
        }if('${tableName}' == 'T_SYS_MESSAGE' && '${type}'=='1'){
            $("#noticflag").hide();
        }
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${businessId}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="col-md-9" style="vertical-align:middle;">' +
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>' +
                    '</div>' +
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    $("#file").append('<div class="col-md-9" style="vertical-align:middle;">' +
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        '<a href="/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>' +
                        '</li>' +
                        '</ul>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");
    })
    function yesReadedt() {
        showSaveLoading('#saveBtn');
        $.post("<%=request.getContextPath()%>/updateTask", {
            id: '${taskId}'
        }, function (msg) {
            hideSaveLoading('#saveBtn');
            if (msg.status == 1) {
                alert("成功标为已读。");
                window.location.href ="<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0"
            }

        })
    }
</script>