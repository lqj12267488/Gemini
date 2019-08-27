<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:49
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
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">请假申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leave.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leave.requester}" readonly="readonly"/>
        </div>


        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
            <input type="text" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;" readonly
                   class="validate[required,maxSize[100]] form-control"
                   value="${leave.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_startTime" type="date" style="line-height:40px;height:40px;text-align:center;" align="center"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leave.startTime}" onchange="changeRequestDays()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_endTime" type="date" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leave.endTime}" onchange="changeRequestDays()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假天数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDays" type="text" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly" class="validate[required,maxSize[100]] form-control"
                   value="${leave.requestDays}"/>
        </div>


        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假类型
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selecter"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假原因
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_reason" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${leave.reason}">${leave.reason}</textarea>
        </div>
    </div>
</div>
<input id="leaveid" type="hidden" value="${id}">
</body>
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'QJLX'
        }, function (data) {
            $("#selecter").append("<select id='f_leaveTypeId' class='mui-btn mui-btn-block'></select>");
            $("#f_leaveTypeId").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;${leave.leaveTypeShow}</option>");
            $.each(data, function (index, content) {
                $("#f_leaveTypeId").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
    })

    function changeRequestDays() {
        var start = new Date($("#f_startTime").val().substring(0, 10)).getTime();
        var end = new Date($("#f_endTime").val().substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#f_requestDays").val(cha + 1);
        }
    }

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', ' ');
        var startTime = $("#f_startTime").val();
        var endTime = $("#f_endTime").val();
        var selectVal = '';
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0") {
            alert("请填写请假开始时间");
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0") {
            alert("请填写请假结束时间");
            return;
        }
        if ($("#f_startTime").val() > $("#f_endTime").val()) {
            alert("请选择请假开始时间需要在请假结束时间之前！");
            return;
        }
        if ($("#f_leaveTypeId").val() == "" || $("#f_leaveTypeId").val() == "0" || $("#f_leaveTypeId").val() == undefined) {
            selectVal = '${leave.leaveType}';
        }else{
            selectVal = $("#f_leaveTypeId option:selected").val();
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            alert("请填写请假原因");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/leave/saveLeave", {
            id: $("#leaveid").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            requestDays: $("#f_requestDays").val(),
            leaveType: selectVal,
            reason: $("#f_reason").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！");
        })
        return true;
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>

