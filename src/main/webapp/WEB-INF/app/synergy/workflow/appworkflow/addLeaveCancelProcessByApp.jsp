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
    <script type="text/javascript" src=".<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
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
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">销假申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="" style="padding-top: 0%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请销假部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="x_cancelRequestDept" style="line-height:40px;height:40px;text-align:center;"
                       type="text" readonly="readonly"
                       class="validate[required,maxSize[100]] form-control"
                       readonly="readonly"   value="${leaveCancel.cancelRequestDept}"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请销假人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="x_cancelRequester" style="line-height:40px;height:40px;text-align:center;"
                       type="text" readonly="readonly"
                       class="validate[required,maxSize[100]] form-control"
                       readonly="readonly"   value="${leaveCancel.cancelRequester}"/>
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请销假日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="x_cancelRequestDate" style="line-height:40px;height:40px;text-align:center;"
                       readonly="readonly"   value="${leaveCancel.cancelRequestDate}" type="text" class="validate[required,maxSize[100]] form-control"/>
            </div>
         <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;销假开始时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="x_cancelStartTime" style="line-height:40px;height:40px;text-align:center;"
                       type="text" class="validate[required,maxSize[100]] form-control"
                       readonly="readonly"   value="${leaveCancel.cancelStartTime}" onblur="chaa()"  />
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;销假结束时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="x_cancelEndTime" style="line-height:40px;height:40px;text-align:center;"
                       type="text" class="validate[required,maxSize[100]] form-control"
                       readonly="readonly"   value="${leaveCancel.cancelEndTime}" onblur="chaa()"  />
            </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;实际请假天数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input  id="x_realDays"  style="line-height:40px;height:40px;text-align:center;"
                         readonly="readonly" class="validate[required,maxSize[100]] form-control"
                        readonly="readonly" type="text"  value="${leaveCancel.realDays}" />
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;销假原因
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                      <input id="x_cancelReason"  style="line-height:40px;height:40px;text-align:center;"
                             type="text" class="validate[required,maxSize[100]] form-control"
                                readonly="readonly"         value="${leaveCancel.cancelReason}"/>
            </div>

    </div>
</div>
<script>
    $(document).ready(function () {
        $("#x_cancelRequestDate").val('${leaveCancel.cancelRequestDate}'.replace("T"," "));
    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
