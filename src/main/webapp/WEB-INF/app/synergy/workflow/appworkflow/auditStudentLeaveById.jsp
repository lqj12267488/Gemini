<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:49
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
    <script type="text/javascript" src="../../../libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="../../../libs/css/app/mui.min.css">
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="../../../libs/css/app/app.css" />
    <link href="../../../libs/css/app/mui.picker.css" rel="stylesheet" />
    <link href="../../../libs/css/app/mui.poppicker.css" rel="stylesheet" />

    <script src="../../../libs/js/app/mui.min.js"></script>
    <script src="../../../libs/js/app/mui.picker.js"></script>
    <script src="../../../libs/js/app/mui.poppicker.js"></script>
<body ><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">学生请假申请</h1>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="mui-content" style="padding-top: 0%">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.requestDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.requester}" readonly="readonly"/>
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
                <input type="text" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;"
                        class="validate[required,maxSize[100]] form-control"
                       value="${leave.requestDate}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;请假开始时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_startTime" type="text" style="line-height:40px;height:40px;text-align:center;" align="center"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.startTime}" readonly="readonly"/>
            </div>



            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;请假结束时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_endTime" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.endTime}" readonly="readonly"/>
            </div>



            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;请假天数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input  id="f_requestDays" type="text" style="line-height:40px;height:40px;text-align:center;"
                        readonly="readonly" class="validate[required,maxSize[100]] form-control"
                        value="${leave.requestDays}" />
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;假条类型
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input  id="f_leaveType" type="text" style="line-height:40px;height:40px;text-align:center;"
                        readonly="readonly" class="validate[required,maxSize[100]] form-control"
                        value="${leave.leaveType}" />
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;请假原因
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_reason" readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                       type="text" class="validate[required,maxSize[100]] form-control"
                          value="${leave.reason}"/>
            </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        $("#f_requestDate").val('${leave.requestDate}'.replace("T"," "));
    })
</script>

