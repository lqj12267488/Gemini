<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:21
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
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">学校商友酒店住宿申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="mui-content" style="padding-top: 0%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hotelStay.requestDept}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                经办人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hotelStay.requester}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hotelStay.requestDate}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                事由
            </div>
            <div class="col-md-9" style="line-height:40px;height:40px;text-align:center;">
                                <input id="h_reason" type="text" style="line-height:40px;height:40px;text-align:center;"
                                          class="validate[required,maxSize[100]] form-control"
                                          value="${hotelStay.reason}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                住宿人数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_peopleNumber" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hotelStay.peopleNumber}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                入住时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_checkInTime" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hotelStay.checkInTime}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                离店时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_checkOutTime" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hotelStay.checkOutTime}" readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                住宿标准
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_price" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hotelStay.price}" readonly="readonly"
                       onmouseout="totalAmount()"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                住宿天数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_stayDays" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hotelStay.stayDays}"  readonly="readonly"
                       onclick="computeDays()" onmouseout="totalAmount()"/>
            </div>
         <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                合计
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                                <input id="h_totalAmount" style="line-height:40px;height:40px;text-align:center;" type="text" value="${hotelStay.totalAmount}"
                                          class="validate[required,maxSize[100]] form-control"  readonly="readonly"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                备注
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                       <imput id="h_remark" style="line-height:40px;height:40px;text-align:center;" value="${hotelStay.remark}"
                                 class="validate[required,maxSize[100]] form-control" readonly="readonly"/>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#h_requestDate").val('${hotelStay.requestDate}'.replace("T"," "));
        $("#h_checkInTime").val('${hotelStay.checkInTime}'.replace("T"," "));
        $("#h_checkOutTime").val('${hotelStay.checkOutTime}'.replace("T"," "))
    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>