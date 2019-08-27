<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/6
  Time: 14:20
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
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">软件安装申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="s_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${softInstall.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="s_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${softInstall.requester}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="s_requestDate" type="text"
                   readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${softInstall.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>软件名称
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="s_softName" type="text" style="text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="30" placeholder="最多输入30个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${softInstall.softName}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>安装原因
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="s_reason" style="text-align:center;" value="${softInstall.reason}"
                      class="validate[required,maxSize[100]] form-control" maxlength="330" placeholder="最多输入330个字"
            >${softInstall.reason}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#s_requestDate").val('${softInstall.requestDate}'.replace("T"," "));
    })
    function save() {
        if ($("#s_softName").val() == "") {
            alert("请填写软件名称");
            return;
        }
        if ($("#s_reason").val() == "") {
            alert("请填写申请理由");
            return;
        }
        var c_requestDate = $("#s_requestDate").val().replace('T',' ');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/softInstall/updateSoftById", {
            id: '${id}',
            softName: $("#s_softName").val(),
            requester: $("#s_requestEr").val(),
            requestDept: $("#s_requestDept").val(),
            requestDate: c_requestDate,
            reason: $("#s_reason").val()

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