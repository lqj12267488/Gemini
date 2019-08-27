<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/9
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%><%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet" />

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  style="color:#fff;"></a>
        <h1 class="mui-title">通知</h1>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="title" type="text" style="text-align:justify ;"
                   class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${notice.title}</textarea>
        </div>
    </div>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
        &nbsp;&nbsp;&nbsp;&nbsp;内容
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea id="content" type="text" style="text-align:justify;"
                   class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${notice.content}</textarea>
        </div>
    </div>
    <div class="">
        <%--
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;发布时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="publicTime" type="date" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${notice.publicTime}" readonly="readonly"/>
        </div>--%>
        <%--<div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="startTime" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${notice.startTime}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="endTime" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${notice.endTime}" readonly="readonly"/>
        </div>--%>
        <div id="noticeFile" class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;附件
            </div>
        </div>
        <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
        <div style="text-align: center">
            <center>
            <button class="mui-btn mui-btn-primary" id="noticflag" style="width:80%; display: none; "
                    onclick="yesReadedt()" >标为已读</button>
            </center>
        </div>
    </div>
</div>
<input id="appid" hidden value="${notice.id}">
<input id="apptype" hidden value="${notice.type}" >
<input id="flagg" hidden value="${flag}">
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId:  $("#appid").val(),
        }, function (data) {
            if (data.data.length == 0) {
                $("#noticeFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
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
                    $("#noticeFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
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
    })


    var  flagg=$("#flagg").val();
    if (flagg != "1") {
        document.getElementById('noticflag').style.display = "block";
    }
    else {
        function yesReadedt() {
            $.post("<%=request.getContextPath()%>/insertNoticeLog", {
                noticeID: $("#appid").val(),
                type: $("#apptype").val()
            }, function (msg) {
                if (msg.status == 1) {
                    alert("成功标为已读。");
                    window.location.href = "<%=request.getContextPath()%>/loginApp/index";
                }

            })
        }
    }
</script>
<style>
    .headerdiv{
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

