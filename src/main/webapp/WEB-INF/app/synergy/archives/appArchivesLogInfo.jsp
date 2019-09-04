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
        <h1 class="mui-title">电子档案</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案名称
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                       class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${archives.archivesName}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;档案编码
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.archivesCode}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;操作类型
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                       class="validate[required,maxSize[20]] form-control"
                       readonly="readonly">${archives.operateType}</textarea>
        </div>
    </div>
    <div class="mui-content" style="padding-top: auto;">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;操作部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify ;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.deptId}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;操作人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.personId}</textarea>
        </div>
    </div>

    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;操作说明
        </div>
        <div class="col-md-9" style="height:60px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.remark}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;操作时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea  type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.operateTime}</textarea>
        </div>
    </div>
    <div class="mui-content">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;文件形成时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <textarea type="text" style="text-align:justify;"
                      class="validate[required,maxSize[20]] form-control"
                      readonly="readonly">${archives.formatTime}</textarea>
        </div>
    </div>
</div>
<input id="appid" hidden value="${archives.archivesId}">
<input id="menuType" hidden value="${menuType}">
<input id="requestFlag" hidden value="${archives.requestFlag}">
<script>
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

