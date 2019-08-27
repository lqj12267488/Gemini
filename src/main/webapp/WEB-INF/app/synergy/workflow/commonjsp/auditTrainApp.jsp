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
        <h1 class="mui-title">培训通知</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;培训类别
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingTypeShow" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingTypeShow}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;培训目的
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingPurpose" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingPurpose}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;培训日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requestDate" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.requestDate}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;培训周期（天）
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingDays" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingDays}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;培训地点
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingPlace" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingPlace}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;主办方
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingOrganizers" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingOrganizers}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp; 项目/专业
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingProject" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingProject}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp; 培训项目名称
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingProjectName" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingProjectName}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp; 培训人数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingPeopleNumber" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingPeopleNumber}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp; 费用（元/人）
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="trainingFee" type="text" style="text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${training.trainingFee}" readonly="readonly"/>
            </div>
            <div style="text-align: center" class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="noticflag" style="width:80%; display: none; "
                            onclick="readConfirm()" >已确认</button>
                </center>
            </div>
        </div>
    </div>
</div>
<input id="appid" hidden value="${sysTask.taskId}">
<input id="apptype" hidden value="${training.trainingType}" >
<input id="appflag" hidden value="${sysTask.validFlag}" >
<input id="personId" hidden value="${sysTask.personId}" >
<script>
    $(document).ready(function () {
        var  appflag=$("#appflag").val();
        if (appflag == "0") {
            document.getElementById('noticflag').style.display = "block";
        }

        $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");
    })
        //确认已读
    function readConfirm() {
        var appid = $("#appid").val();
        var personId = $("#personId").val();
        if (confirm("是否确认已读?")) {

            showSaveLoading(".saveBtnClass button");

            $.post("<%=request.getContextPath()%>/updateTaskFlagByConditions", {
                taskId: appid,
                personId: personId
            }, function (msg) {
                hideSaveLoading(".saveBtnClass button");
                if (msg.status == 1) {
                    alert("成功标为已读。");
                    window.location.href = "<%=request.getContextPath()%>/loginApp/index";
                }

            })
        }
    }
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

