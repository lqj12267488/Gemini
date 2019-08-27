<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/5
  Time: 11:14
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
        <h1 class="mui-title">礼堂使用申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="" style="padding-top: 0%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
            class="validate[required,maxSize[20]] form-control"
            value="${hallUse.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.requestDate}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;使用设备
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_leader" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.usedeviceShow}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_startTime" type="text" style="text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hallUse.startTime}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_endTime" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hallUse.endTime}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;活动内容
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_content" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.content}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;参与人数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_peopleNumber" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.peopleNumber}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_remark" type="text" style="text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hallUse.remark}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            使用规范
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                        <textarea id="n_standard" style="height: 100px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${standard.standardContent}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/hallUse/getDeptPerson", function (data) {
            addOption(data, 'h_leader','${hallUse.leader}');
        });
        $("#h_requestDate").val('${hallUse.requestDate}'.replace("T"," "));
        $("#h_startTime").val('${hallUse.startTime}'.replace("T"," "));
        $("#h_endTime").val('${hallUse.endTime}'.replace("T"," "))

    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
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