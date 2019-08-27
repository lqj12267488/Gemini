<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/15
  Time: 9:15
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
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">考勤记录详情</h1>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="" style="padding-top: 12%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            姓名
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.name}
            <%--<input id="name" type="number" value="${attendance.name}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            身份证号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.idcard}
            <%--<input id="idcard" type="number" value="${attendance.idcard}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            年份
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.year}
            <%-- <input id="year" type="number" value="${attendance.year}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            月份
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.month}
            <%--<input id="month" type="number"  value="${attendance.month}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            应签到次数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.basicFrequency}
            <%--<input id="postattendance" type="number"  value="${attendance.postattendance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            未签到次数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.noSignInFrequency}
            <%--<input id="wagePay" type="number" value="${attendance.wagePay}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            最新未签到
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.latestOutOfSignIn}
            <%-- <input id="bfzs" type="number"  value="${attendance.bfzs}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            调休未签到
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.leaveNoSign}
            <%--<input id="basicPerformance" type="number" value="${attendance.basicPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            公假
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.publicHolidays}
            <%--<input id="rewardPerformance" type="number"  value="${attendance.rewardPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            事假
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.compassionateLeave}
            <%--<input id="childAllowance" type="number" value="${attendance.childAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            病假
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.sickLeave}
            <%-- <input id="seniorityAllowance" type="number"  value="${attendance.seniorityAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            因公(因故)误签
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${attendance.wrongSignOnBusiness}
            <%--<input id="rentSubsidies" type="number" value="${attendance.rentSubsidies}"/>--%>
        </div>
    </div>
</div>

