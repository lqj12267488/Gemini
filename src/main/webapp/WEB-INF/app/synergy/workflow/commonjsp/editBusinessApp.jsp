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
           style="color:#fff;" onclick="backMain()"></a>
        <h1 id="title" class="mui-title">审批待办</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="mui-content">
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div id="business"></div>
            <div class="mui-content" id="close" style="padding-top: 0%">

                <div id="file">
                    <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
                        附件
                    </div>
                </div>
                <div style="text-align: center"  class="saveBtnClass">
                    <button class="mui-btn mui-btn-primary" id="endWorkflow" style="width:40%; "
                            onclick="endWorkflow()">流程关闭
                    </button>
                    <c:forEach items="${definitions}" var="definition">
                        <button class="mui-btn mui-btn-primary" id="submit" style="width:40%;"
                                onclick="getAuditer('${definition.term}')">${definition.operationName}
                        </button>
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
            <div class="mui-content saveBtnClass" id="selectPeople" style="display: none">
                <div id="selector" class="mui-input-group">
                </div>
                <div align="center">
                    <button type="button" class="mui-btn mui-btn-primary"
                            onclick="audit()">保存
                    </button>
                    <button type="button" class="btn btn-default btn-clean"
                            onclick="mui.back()">关闭
                    </button>
                </div>
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
    var tableName = $("#tableName").val();
    var businessId = $("#businessId").val();
    $(document).ready(function () {
        $("#business").load('<%=request.getContextPath()%>' + '${url}');
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
                        '<a href="' + '<%=request.getContextPath()%>' + val.fileUrl + '" target="_blank">' + val.fileName + '</a>' + '</li>' +
                        '</ul>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: '${tableName}',
            workflowCode: $("#workflowCode").val(),
            businessId: '${businessId}',
            term: '1'
        }, function (data) {
            if (data.nodeType == 0) {
                $("#selector").append("<select id='personId' class='mui-btn mui-btn-block'></select>");
                $("#personId").append("<option value=''>请选择</option>");
                $.each(data.emps, function (index, content) {
                    $("#personId").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            } else {
                $.each(data.emps, function (key, map) {
                    if (data.emps.nodeType == 0) {
                        $("#selector").append("<select id='personId'></select>");
                        $("#personId").append("<option value=''>请选择</option>");
                        $.each(data.emps, function (index, content) {
                            $("#personId").append("<option value='" + content.id + "'>" + content.name + "</option>");
                        })
                    } else {
                        doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                            ' <label>' + map.name + '</label>' +
                            '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                            '<input hidden value="' + map.name + '" class="cbs"/>' +
                            '</div>';
                        $("#selector").append(doc);
                    }
                })
            }
        })
        $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");

    })

    function getAuditer(term) {
        if(save()){
            $("#term").val(term);
            if (term == '-1') {
                audit()
            } else {
                showSaveLoading('.saveBtnClass button');
                $.post("<%=request.getContextPath()%>/getAuditer", {
                    tableName: $("#tableName").val(),
                    businessId: $("#businessId").val(),
                    term: term
                }, function (data) {
                    hideSaveLoading('.saveBtnClass button');
                    if (data.length == 1) {
                        handleName = data[0].text;
                        personId = data[0].id;
                        audit()
                    } else if (Object.keys(data.emps).length == 0) {
                        alert("当前没有办理人")
                    } else {
                        hideSaveLoading('.saveBtnClass button');

                        //window.location.href = "<%=request.getContextPath()%>/toSelectAuditerApp?tableName=${tableName}&businessId=${businessId}&term=" + term + "&remark=驳回后重新申请";
                        $("#title").html("请选择办理人")
                        $("#close").hide();
                        $("#mainPage").hide();
                        $("#selectPeople").show();
                    }
                })

            }
    }

    }

    var checkVals = new Array();
    var checkTexts = new Array();

    function getCheckBoxText(className) {
        var rdsObj = document.getElementsByClassName('rds');
        var rdsObjs = document.getElementsByClassName(className);
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkTexts[k] = rdsObjs[i].value;
                k++;
            }
        }
        return checkTexts;
    }

    function audit() {
        save();
        var rdsObj = document.getElementsByClassName('rds');
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVals[k] = rdsObj[i].value;
                k++;
            }
        }
        var rVal = checkVals.toString();
        var resText = getCheckBoxText('cbs').toString();
        var value = '';
        var text = '';
        var selectVal = $("#personId option:selected").val();
        if (rVal.length < 1 && selectVal == '') {
            mui.toast('请选择办理人');
            return;
        } else {
            if (rVal < 1) {
                value = $("#personId option:selected").val();
                text = $("#personId option:selected").text();
            } else {
                value = rVal;
                text = resText;
            }
        }
        var term = $("#term").val();
        var msg = "确认移交到" + text + "？";
        if (term == '-1') {
            msg = "确认办结？";
        }
        if (confirm(msg)) {
            showSaveLoading('.saveBtnClass button');
            var remark = "驳回后重新申请";
            $.post("<%=request.getContextPath()%>/audit", {
                term: term,
                handleUser: value,
                handleName: text,
                remark: remark,
                businessId: '${businessId}',
                tableName: '${tableName}'
            }, function (data) {
                hideSaveLoading('.saveBtnClass button');
                if (data.status = 1) {
                    alert(data.msg)
                    window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0"
                }
            })
        }
    }

    function endWorkflow() {
        showSaveLoading('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/stop", {
            startId : '${startId}',
            handleId :'${handleId}',
            remark :"申请人流程关闭",
            businessId: '${businessId}',
            tableName: '${tableName}'
        }, function (data) {
            hideSaveLoading('.saveBtnClass button');
            alert("流程已关闭！")
            window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0"
        })
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type=0";
    }

</script>