<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 13:52
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
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">超市物品领取申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
        <div class="" style="padding-top: 0%">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.requestDept}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.requester}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;申请日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                       readonly="readonly"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.requestDate}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;标准(元/人)
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="standard" type="text" style="line-height:40px;height:40px;text-align:center;" readonly="readonly"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.standard}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;人数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="peopleNumber"  type="text" style="line-height:40px;height:40px;text-align:center;" readonly="readonly"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.peopleNumber}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;总金额
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="totalAmount"   type="text" style="line-height:40px;height:40px;text-align:center;"
                       readonly="readonly"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.totalAmount}" />
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp; 用途
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="use" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${shopItemsReceive.use}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;备注
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="remark" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${shopItemsReceive.remark}" readonly="readonly"/>
            </div>
        </div>
</div>
<script>
    $(document).ready(function () {
        $("#f_requestDate").val('${shopItemsReceive.requestDate}'.replace("T"," "));
    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>