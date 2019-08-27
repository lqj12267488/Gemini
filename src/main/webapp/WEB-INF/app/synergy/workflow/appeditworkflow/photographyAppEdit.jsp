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
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">摄影申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.requestDate}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拍摄时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="shootDate" type="datetime-local" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.shootDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拍摄地点
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="shootingLocation" type="text" style="text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="30" placeholder="最多输入30个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.shootingLocation}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拍摄方法
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="shootingMethod" style="text-align:center;" value="${photography.shootingMethod}"
                      maxlength="15" placeholder="最多输入15个字"
                      class="validate[required,maxSize[100]] form-control"
            >${photography.shootingMethod}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>摄影机机位数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="machineNumber" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${photography.machineNumber}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>活动内容
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="content" style="text-align:center;" value="${photography.content}"
                      class="validate[required,maxSize[100]] form-control" maxlength="165" placeholder="最多输入165个字"
            >${photography.content}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#requestDate").val('${photography.requestDate}'.replace("T"," "));
    })
    function save() {
        var a = $("#photographyid").val();
        var t_requestDate = $("#requestDate").val();
        var t_shootDate =$("#shootDate").val();
        t_requestDate = t_requestDate.replace('T','');
        t_shootDate = t_shootDate.replace('T','');
        var reg=/^[0-9]+.?[0-9]*$/;
        if($("#shootDate").val()=="" ||  $("#shootDate").val() =="0" || $("#shootDate").val() == undefined){
            alert("请填写出拍摄时间");
            return;
        }
        if($("#shootingLocation").val()=="" ||  $("#shootingLocation").val() =="0" || $("#shootingLocation").val() == undefined) {
            alert("请填写拍摄地点");
            return;
        }
        if($("#shootingMethod").val()=="" ||  $("#shootingMethod").val() =="0" || $("#shootingMethod").val() == undefined) {
            alert("请填写出拍摄方法");
            return;
        }
        if($("#machineNumber").val()=="" ||  $("#machineNumber").val() =="0" || $("#machineNumber").val() == undefined){
            alert("请填写出摄影机机位数");
            return;
        }
        if(!reg.test($("#machineNumber").val())){
            alert("摄像机机位数请填写数字");
            return;
        }
        if($("#content").val()=="" ||  $("#content").val() =="0" || $("#content").val() == undefined){
            alert("请填写出活动内容");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/photography/savePhotography", {//post传参
            id: '${id}',//获取页面数据得值
            requestDept: $("#requestDept").val(),
            requester: $("#requester").val(),
            requestDate: t_requestDate,
            shootDate:t_shootDate,
            shootingMethod: $("#shootingMethod").val(),
            machineNumber: $("#machineNumber").val(),
            shootingLocation: $("#shootingLocation").val(),
            content: $("#content").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1 ) {
                alert("数据修改成功！");
            }
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

