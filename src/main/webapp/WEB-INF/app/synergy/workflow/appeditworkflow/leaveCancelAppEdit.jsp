<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<body >
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">销假申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请销假部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="x_cancelRequestDept" style="line-height:40px;height:40px;text-align:center;"
                   type="text" readonly="readonly" value="${leaveCancel.cancelRequestDept}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请销假人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="x_cancelRequester" style="line-height:40px;height:40px;text-align:center;"
                   type="text" readonly="readonly"
                   class="validate[required,maxSize[100]] form-control" value="${leaveCancel.cancelRequester}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请销假日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="x_cancelRequestDate" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly" value="${leaveCancel.cancelRequestDate}" type="text"
                   class="validate[required,maxSize[100]] form-control"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>销假开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="x_cancelStartTime" style="text-align:center;"
                   type="date" class="validate[required,maxSize[100]] form-control"
                   value="${leaveCancel.cancelStartTime}" onchange="chaa()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>销假结束时间
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="x_cancelEndTime" style="text-align:center;"
                   type="date" class="validate[required,maxSize[100]] form-control" value="${leaveCancel.cancelEndTime}"
                   onchange="shijian();chaa()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>实际请假天数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="x_realDays" style="text-align:center;"
                   readonly="readonly" type="text"
                   value="${leaveCancel.realDays}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>销假原因
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="x_cancelReason" style="text-align:center;" value="${leaveCancel.cancelReason}"
                          maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control">${leaveCancel.cancelReason}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#x_cancelRequestDate").val('${leaveCancel.cancelRequestDate}'.replace("T", " "));
    })

    function shijian() {
        if ($("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()) {
            alert("请选择销假开始时间需要在销假结束时间之前！");
            $("#x_cancelEndTime").val("");
            return;
        }
    }

    function chaa() {
        var start = new Date(document.getElementById("x_cancelStartTime").value.substring(0, 10)).getTime();
        var end = new Date(document.getElementById("x_cancelEndTime").value.substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#x_realDays").val(cha + 1);
        }
        var yuan = '${leaveCancel.requestDays}';
        document.getElementById("x_realDays").value = yuan - cha;

    }

    function save() {
        var date = $("#x_cancelRequestDate").val();
        date = date.replace('T', '');
        var startTime = $("#x_cancelStartTime").val();
        startTime = startTime.replace('T', '');
        var endTime = $("#x_cancelEndTime").val();
        endTime = endTime.replace('T', '');
        if ($("#x_cancelRequestDate").val() == "" || $("#x_cancelRequestDate").val() == "0") {
            alert("请填写销假申请时间");
            return;
        }
        if ($("#x_cancelStartTime").val() == "" || $("#x_cancelStartTime").val() == "0") {
            alert("请填写销假开始时间");
            return;
        }
        if ($("#x_cancelEndTime").val() == "" || $("#x_cancelEndTime").val() == "0") {
            alert("请填写销假结束时间");
            return;
        }
        if ($("#f_requestDate").val() > $("#x_cancelRequestDate").val()) {
            alert("请选择请假时间要在销假时间之前");
            return;
        }
        if ($("#x_cancelStartTime").val() > $("#x_cancelEndTime").val()) {
            alert("请选择销假开始时间需要在销假结束时间之前！");
            return;
        }
        if ($("#x_cancelEndTime").val() > $("#f_endTime").val()) {
            alert("请选择销假结束时间需要在请假结束时间之前！");
            return;
        }
        if ($("#x_cancelReason").val() == "" || $("#x_cancelReason").val() == "0" || $("#x_cancelReason").val() == undefined) {
            alert("请填写请假原因");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/leaveCancel/editCancel", {
            id: '${id}',
            cancelRequestDate: date,
            cancelStartTime: startTime,
            cancelEndTime: endTime,
            realDays: $("#x_realDays").val(),
            cancelReason: $("#x_cancelReason").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！")
        })
        return true;
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
