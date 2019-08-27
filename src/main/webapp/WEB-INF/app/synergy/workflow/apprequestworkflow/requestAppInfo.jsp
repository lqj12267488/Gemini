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
<header class="mui-bar mui-bar-nav">
    <a id="back" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
    <h1 id="title" class="mui-title">申请列表</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
</header>
<div class="mui-content">
    <div id="business"></div>
</div>
<div class="mui-content">
    <div style="display: inline">
        <input type="file" name="file" id="appFile" width="90%">
        <button class="mui-btn mui-btn-primary" onclick="update()">上传</button>
    </div>
</div>
<div class="mui-content">
    <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
        &nbsp;&nbsp;&nbsp;&nbsp;附件
    </div>
    <div id="fileList" class="col-md-9" style="vertical-align:middle;height: 100px">

    </div>
</div>
<input id="tName" hidden value="${workFlow.tableName}">
<input id="wId" hidden value="${workflowId}">
<input id="rurl" hidden value="${workFlow.url}">
<input id="term" hidden>
<input id="bId" hidden value="${businessId}">
<script>
    var type = '';
    $(document).ready(function () {
        if ('${workflowId}' == '2675f367-79eb-4cd5-8773-34de700b19d0') {
            type = '2';
        }
        else {
            type = '1';
        }
        $("#business").load('<%=request.getContextPath()%>${workFlow.url}?tableName=' + $("#tName").val() + '&type=' + type + '&businessId=' + $("#bId").val());
    })

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function update() {
        var file = document.getElementById("appFile").files[0];
        if (file == "" || file == undefined || file == null) {
            alert("请选择文件！")
            return
        }
        var tableName = $("#tName").val()
        var id = $("#bId").val()
        var form = new FormData();
        form.append("file", file);
        form.append("businessId", id);
        form.append("tableName", tableName);
        $.ajax({
            url: '<%=request.getContextPath()%>/app/files/insertFiles',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {
                alert("上传成功！");
                $("#appFile").val("");
                reloadFileList();
            }
        });
    }

    function del(a) {
        var a = $(a);
        $.get("<%=request.getContextPath()%>/files/delFile?id=" + a.attr("fileId"), function (data) {
            alert("删除成功！");
            reloadFileList();
        })
    }

    function reloadFileList() {
        $.get("<%=request.getContextPath()%>/files/getFilesByBusinessId?businessId=" + $("#bId").val(), function (data) {
            var html = "";
            $.each(data.data, function (index, file) {
                html += "<p style='font-size: 17px'><span style='margin-left: 10px'>" + file.fileName +
                    "</span>" +
                    "<span style='margin-left: 30px' fileId='" + file.fileId + "' onclick='del(this)'>删除</span> </p>";
            })
            $("#fileList").html(html)
        })
    }
</script>