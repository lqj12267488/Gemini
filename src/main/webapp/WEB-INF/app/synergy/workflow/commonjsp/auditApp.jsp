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
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/Commons.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body>
<div class="mui-inner-wrap">
    <header class="mui-bar mui-bar-nav">
        <a id="back" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
           style="color:#fff;"  onclick="backMain()" ></a>
        <h1 id="title" class="mui-title">审批待办</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="mui-content">
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div id="business"></div>
            <div id="file" >
                <div  class="col-md-3 tar" style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;">
                    附件
                </div>
            </div>
            <div  class="mui-input-group">
                <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                    &nbsp;&nbsp;&nbsp;&nbsp;快速意见
                </div>
                <div class="col-md-9">
                    <select id="opinionRemark" onchange="changeOpinionRemark()"></select>
                </div>
            </div>
            <div  class="mui-input-group">
                <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                    &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>您的意见
                </div>
                <div>
                    <textarea id="workflowRemark"></textarea>
                </div>
            </div>
            <div style="text-align: center" class="saveBtnClass">
                <c:forEach items="${definitions}" var="definitions">
                    <button class="mui-btn mui-btn-primary"
                            onclick="getAuditer('${definitions.term}')">${definitions.operationName}</button>
                </c:forEach>
            </div>
            <div class="mui-input-row">
                <div style="text-align: center">
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
                                    <span><font color="blue" size="4px">${node.nodeName}</font> </span>
                                </c:if>
                                <c:if test="${node.nodeId != cuurentNodeId}">
                                    ${node.nodeName}
                                </c:if>
                                <c:if test="${node.nodeOrder != size}">
                                    →
                                </c:if>
                                <span class=" icon-arrow-right"></span>
                            </c:otherwise>
                        </c:choose>
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
    var tableName= $("#tableName").val();
    var businessId= $("#businessId").val();
    $(document).ready(function () {
        $("#business").load('<%=request.getContextPath()%>'+'${url}');
        $.get("<%=request.getContextPath()%>/getOpinion", function (data) {
            addOption(data, 'opinionRemark');
        })
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${businessId}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="col-md-9" style="vertical-align:middle;">'+
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>'+
                    '</div>'+
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    $("#file").append('<div class="col-md-9" style="vertical-align:middle;">'+
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        '<a href="<%=request.getContextPath()%>/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>' +
                        '</li>' +
                        '</ul>'+
                        '</div>'+
                    '</div>');
                })
            }
        })
        $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");
    })
    function downFiles(id,name,type) {
        $.ajax({
            type:"GET",
            url:"<%=request.getContextPath()%>/files/downloadFiles",
            data:{
                f_id: id,
                f_name: name,
                f_type: type
            },
            error: function(request) {
                alert("下载连接失败");
            },
            success:function (data) {
                return data;
            }
        });
    }

    function getAuditer(term) {
        var remark = $("#workflowRemark").val();
        if (remark == '' || remark == undefined || remark == null) {
            alert("请填写意见！")
            return
        }
        $("#term").val(term);
        if (term == '-1') {
            audit()
        } else {
            showSaveLoading(".saveBtnClass button");
            $.post("<%=request.getContextPath()%>/getAuditer", {
                tableName: $("#tableName").val(),
                businessId: $("#businessId").val(),
                term: term
            }, function (data) {
                hideSaveLoading(".saveBtnClass button");
                if (data.length == 1) {
                    handleName = data[0].text;
                    personId = data[0].id;
                    audit()
                }else if(Object.keys(data.emps).length == 0){
                    alert("当前没有办理人")
                } else {
                    window.location.href = "<%=request.getContextPath()%>/toSelectAuditerApp?tableName=${tableName}&businessId=${businessId}&term="+term+"&remark="+remark;
                }
            })

        }

    }

    function audit() {
        if (handleName == "") {
            handleName = $("#personId option:selected").text();
        }
        if (personId == "") {
            personId = $("#personId option:selected").val();
        }
        var term = $("#term").val();
        var msg = "确认移交到" + handleName + "？";
        if (term == '-1') {
            msg = "确认办结？";
        }
        if (confirm(msg)) {
            showSaveLoading(".saveBtnClass button");
            var remark = $("#workflowRemark").val();
            $.post("<%=request.getContextPath()%>/audit", {
                term: term,
                handleUser: personId,
                handleName: handleName,
                remark: remark,
                businessId: '${businessId}',
                tableName: '${tableName}'
            }, function (data) {
                hideSaveLoading(".saveBtnClass button");
                if (data.status = 1) {
                    alert(data.msg)
                    window.location.href ="<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0"
                }
            })
        }
    }
    function back() {
        window.location.href ="<%=request.getContextPath()%>/loginApp/index"
    }

    function changeOpinionRemark() {
        var val = $("#opinionRemark option:selected").val();
        if (val != "") {
            $("#workflowRemark").val($("#opinionRemark option:selected").text());
        } else {
            $("#workflowRemark").val("");
        }
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0";
    }

</script>