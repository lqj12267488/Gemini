<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:21
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
        <h1 class="mui-title">学校商友酒店住宿申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>

    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hotelStay.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>经办人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hotelStay.requester}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hotelStay.requestDate}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>事由
        </div>
        <div class="col-md-9" style="text-align:center;">
                <textarea id="h_reason" style="text-align:center;" value="${hotelStay.reason}"
                          maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control"
                >${hotelStay.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>住宿人数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_peopleNumber" type="text" style="line-height:40px;height:40px;text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hotelStay.peopleNumber}" onchange="changeNum()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>入住时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_checkInTime" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hotelStay.checkInTime}" onchange="changeNum()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>离店时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_checkOutTime" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hotelStay.checkOutTime}" onchange="changeNum()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>住宿标准
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_price" type="text" style="line-height:40px;height:40px;text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hotelStay.price}" onchange="changeNum()"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>住宿天数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_stayDays" type="text" style="line-height:40px;height:40px;text-align:center;" readonly
                   class="validate[required,maxSize[20]] form-control"
                   value="${hotelStay.stayDays}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>合计
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_totalAmount" style="line-height:40px;height:40px;text-align:center;" type="text"
                   value="${hotelStay.totalAmount}"
                   class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="h_remark" style="text-align:center;" value="${hotelStay.remark}"
                      maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${hotelStay.remark}</textarea>
        </div>
    </div>
</div>
</div>
<script>
    $(document).ready(function () {
        $("#h_requestDate").val('${hotelStay.requestDate}'.replace("T", " "));
    })
    var days;

    function changeNum() {
        var reg = /^[0-9]+.?[0-9]*$/;
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime = $("#h_checkOutTime").val();
        var checkInHour = new Date(checkInTime.replace('T', ' ')).getHours();
        var checkOutHour = new Date(checkOutTime.replace('T', ' ')).getHours();
        checkInTime = new Date(checkInTime.replace('T', ' ')).getTime();
        checkOutTime = new Date(checkOutTime.replace('T', ' ')).getTime();
        days = checkOutTime - checkInTime;
        days = parseInt(days / (1000 * 60 * 60 * 24));
        if (checkInHour < 12 && checkOutHour < 12) {
            days += 1;
        } else if (checkInHour > 12 && checkOutHour > 12) {
            days += 1;
        } else if (checkInHour < 12 && checkOutHour > 12) {
            days += 2;
        }
        document.getElementById("h_stayDays").value = days;
        var peopleNumber = $("#h_peopleNumber").val();
        var price = $("#h_price").val();
        var stayDays = $("#h_stayDays").val();
        var totalAmount = document.getElementById("h_totalAmount");
        totalAmount.value = price * stayDays * peopleNumber;
    }

    function save() {
        var date = $("#h_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$");
        var daysFlag = 1;
        if ($("#h_reason").val() == "" || $("#h_reason").val() == "0" || $("#h_reason").val() == undefined) {
            alert("请填写事由");
            return;
        }
        if ($("#h_peopleNumber").val() == "" || $("#h_peopleNumber").val() == "0" || $("#h_peopleNumber").val() == undefined) {
            alert("请填写入住人数");
            return;
        }
        if (!reg.test($("#h_peopleNumber").val())) {
            alert("入住人数请填写整数");
            return;
        }
        if ($("#h_checkInTime").val() == "" || $("#h_checkInTime").val() == "0" || $("#h_checkInTime").val() == undefined) {
            alert("请填写精确的入住时间");
            daysFlag = 0;
            return;
        }
        if ($("#h_checkOutTime").val() == "" || $("#h_checkOutTime").val() == "0" || $("#h_checkOutTime").val() == undefined) {
            alert("请填写精确的离店时间");
            daysFlag = 0;
            return;
        }
        if ($("#h_price").val() == "" || $("#h_price").val() == undefined) {
            alert("请填写住宿标准");
            return;
        }
        if (!reg.test($("#h_price").val())) {
            alert("住宿标准请填写数字");
            return;
        }
        if ($("#h_stayDays").val() == "" || $("#h_stayDays").val() == "0" || $("#h_stayDays").val() == undefined) {
            alert("住宿天数不能为空");
            return;
        }
        var checkInTime = $("#h_checkInTime").val();
        var checkOutTime = $("#h_checkOutTime").val();
        if (checkInTime > checkOutTime) {
            alert("开始时间必须早于结束时间");
            return;
        }
        checkInTime = checkInTime.replace('T', '');
        checkOutTime = checkOutTime.replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/hotelStay/saveHotelStay", {
            id: '${id}',
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate: date,
            reason: $("#h_reason").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            price: $("#h_price").val(),
            stayDays: $("#h_stayDays").val(),
            totalAmount: $("#h_totalAmount").val(),
            remark: $("#h_remark").val()
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