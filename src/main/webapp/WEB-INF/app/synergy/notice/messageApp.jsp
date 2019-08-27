<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/14
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet"/>

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;" onclick="backMessage()"></a>
        <h1 class="mui-title">通知</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="" style="padding-top: 12%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${message.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${message.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${message.publicTime}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="n_title" style="text-align:center;"
                      class="validate[required,maxSize[100]] form-control"  readonly="readonly">${message.title}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;" class="ui-select">
            &nbsp;&nbsp;&nbsp;&nbsp;类型
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="select" readonly type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${message.typeShow}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;接收部门
        </div>
        <div class="col-md-9" style="height: 150px;vertical-align:middle;text-align:center;">
            <textarea id="f_dept" style="text-align:center;height: 100%"
                      class="validate[required,maxSize[100]] form-control" readonly>${message.deptIdShow}</textarea>
            <input hidden id="r_dept"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;接收人员
        </div>
        <div class="col-md-9" style="height: 150px;vertical-align:middle;text-align:center;">
                    <textarea id="f_people" style="text-align:center; height: 100%;"
                              class="validate[required,maxSize[100]] form-control"
                              readonly>${message.empIdShow}</textarea>
            <input hidden id="r_people"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;内容
        </div>
        <div class="col-md-9" style="height:100px;vertical-align:middle;text-align:center;">
            <textarea id="n_content" style="text-align:center;height: 100%"
                      class="validate[required,maxSize[100]] form-control"  readonly="readonly">${message.content}</textarea>
        </div>
        <div id="messageAppFile" class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:50px;vertical-align:middle; padding-top: 7%;">
                &nbsp;&nbsp;&nbsp;&nbsp;附件
            </div>
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;"></div>
        <%--<div style="text-align: center">
            <center>
                <button class="mui-btn mui-btn-primary" id="messageflag" style="width:80%; display: none; "
                        onclick="yesReadedt()">标为已读
                </button>
            </center>
        </div>--%>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId:  '${message.id}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#messageAppFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
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
                    $("#messageAppFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        '<a href="<%=request.getContextPath()%>/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>' +
                        '</ul>'+
                        '</div>'+
                        '</div>');
                })
            }
        })
        var flagg = '${flag}';
        if (flagg != "1") {
            document.getElementById('messageflag').style.display = "block";
        }
    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
    function backMessage() {
        window.location.href = "<%=request.getContextPath()%>/notice/messageApp";
    }
    function yesReadedt() {
        $.post("<%=request.getContextPath()%>/updateMessageLog", {
            id: '${message.id}',
            type: '${message.type}'
        }, function (msg) {
            if (msg.status == 1) {
                alert("成功标为已读。");
                window.location.href = "<%=request.getContextPath()%>/loginApp/index";
            }

        })

    }
</script>
<style>
    .headerdiv {
        font-family: 'Microsoft YaHei', 'Helvetica Neue', Helvetica, sans-serif;
        line-height: 1.1;
        float: left;
        width: 100%;
        height: 60px;
        padding: 11px 15px;
        vertical-align: middle;
        /*display:table;*/
        /* line-height: 100px;*/
    }
</style>
