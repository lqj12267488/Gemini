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
        <h1 class="mui-title">学校车辆外出申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.requester}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDate" type="text"
                   readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${businessCar.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>起始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_startTime" style="line-height:40px;height:40px;text-align:center;"
                   type="datetime-local"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.startTime}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_endTime" type="datetime-local"
                   style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.endTime}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>始发地
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_startPlace" type="text" style="line-height:40px;height:40px;text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="30" placeholder="最多输入30个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.startPlace}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>目的地
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_endPlace" type="text" style="line-height:40px;height:40px;text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="30" placeholder="最多输入30个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.endPlace}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>用车类型
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <div id="select"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>人数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_peopleNum" style="line-height:40px;height:40px;text-align:center;" type="text" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${schoolCar.peopleNum}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请事由
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="f_reason" style="text-align:center;" value="${schoolCar.reason}"
                      maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${schoolCar.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="f_remark" style="text-align:center;" value="${schoolCar.remark}"
                      maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${schoolCar.remark}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#f_requestDate").val('${schoolCar.requestDate}'.replace("T"," "));
        $.post("<%=request.getContextPath()%>/common/getUserDict", {
            name: 'XXCLLX'
        }, function (data) {
            $("#select").append("<select id='f_carType' class='mui-btn mui-btn-block'></select>");
            $("#f_carType").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;${schoolCar.carTypeShow}</option>");
            $.each(data, function (index, content) {
                $("#f_carType").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
    })
    var checkVal = new Array();
    function getCheckBoxRes(className) {
        var rdsObj = document.getElementsByClassName(className);
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                k++;
            }
        }
        return checkVal;
    }
    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        var carType="";
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0" || $("#f_startTime").val() == undefined) {
            alert("请填写精确的开始时间！");
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0" || $("#f_endTime").val() == undefined) {
            alert("请填写精确的结束时间！")
            return;
        }
        if ($("#f_startPlace").val() == "" || $("#f_startPlace").val() == "0" || $("#f_startPlace").val() == undefined) {
            alert("请填写始发地！")
            return;
        }
        if ($("#f_endPlace").val() == "" || $("#f_endPlace").val() == "0" || $("#f_endPlace").val() == undefined) {
            alert("请填写目的地！")
            return;
        }
        if ($("#f_carType").val() == "" || $("#f_carType").val() == "0" || $("#f_carType").val() == undefined) {
            carType = ${schoolCar.carType};
        }else{
            carType = $("#f_carType option:selected").val();
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            alert("请填写事由！")
            return;
        }
        if ($("#f_peopleNum").val() == "" || $("#f_peopleNum").val() == "0" || $("#f_peopleNum").val() == undefined) {
            alert("请填写人数！")
            return;
        }
        if(!reg.test($("#f_peopleNum").val())){
            alert("人数请填写整数！");
            return;
        }
        var startTime = $("#f_startTime").val();
        var endTime =$("#f_endTime").val();
        if(startTime>endTime){
            alert("开始时间必须早于结束时间！");
            return;
        }
        var days=(new Date(startTime).getTime())-(new Date(date).getTime());
        days=days/(1000*60*60*24);
        if(days<1){
            alert("请提前一天申请，以便安排用车");
            return;
        }
        startTime = startTime.replace('T', '');
        endTime = endTime.replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/schoolCar/saveSchoolCar", {
            id:'${id}',
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate:date,
            startTime:startTime,
            endTime:endTime,
            startPlace: $("#f_startPlace").val(),
            endPlace: $("#f_endPlace").val(),
            carType: carType,
            reason: $("#f_reason").val(),
            peopleNum: $("#f_peopleNum").val(),
            remark:$("#f_remark").val(),
            checkFlag:0,
            requesterConfirmFlag:0
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！")
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