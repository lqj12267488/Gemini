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
        <h1 class="mui-title">非工作日礼堂\操场\会议室申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.requestDate}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_startTime" type="datetime-local" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.startTime}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_endTime" type="datetime-local" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.endTime}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>活动内容
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="n_content" maxlength="165" placeholder="最多输入165个字"
                      class="validate[required,maxSize[100]] form-control">${noWorkDayPlace.content}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>人数
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="n_peopleNumber" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${noWorkDayPlace.peopleNumber}" />
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用场所
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selectPlace"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用性质
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selectProperty"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="n_remark"
                      class="validate[required,maxSize[100]] form-control">${noWorkDayPlace.remark}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            使用规范
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                        <textarea id="n_standard" style="height: 200px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly="readonly">${standard.standardContent}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#n_requestDate").val('${noWorkDayPlace.requestDate}'.replace("T"," "));
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'SYCS'
        }, function (data) {
            $("#selectPlace").append("<select id='n_usePlace' class='mui-btn mui-btn-block'></select>");
            $("#n_usePlace").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;${noWorkDayPlace.place}</option>");
            $.each(data, function (index, content) {
                $("#n_usePlace").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'SYXZ'
        }, function (data) {
            $("#selectProperty").append("<select id='n_useProperty' class='mui-btn mui-btn-block'></select>");
            $("#n_useProperty").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;${noWorkDayPlace.property}</option>");
            $.each(data, function (index, content) {
                $("#n_useProperty").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
    })
    function save(){
        var date = $("#n_requestDate").val();
        date = date.replace('T', '');
        var reg = new RegExp("^[0-9]*$");
        if ($("#n_startTime").val() == "" || $("#n_startTime").val() == "0" || $("#n_startTime").val() == undefined) {
            alert("请填写精确的开始时间!")
            return;
        }
        if ($("#n_endTime").val() == "" || $("#n_endTime").val() == "0" || $("#n_endTime").val() == undefined) {
            alert("请填写精确的结束时间!")
            return;
        }
        if ($("#n_content").val() == "" || $("#n_content").val() == "0" || $("#n_content").val() == undefined) {
            alert("请填写活动内容!")
            return;
        }
        if ($("#n_peopleNumber").val() == "" || $("#n_peopleNumber").val() == "0" || $("#n_peopleNumber").val() == undefined) {
            alert("请填写参与人数!");
            return;
        }
        if(!reg.test($("#n_peopleNumber").val())){
            alert("参与人数请填写数字!");
            return;
        }
        if($("#n_usePlace").val()=="" ||  $("#n_usePlace").val() =="0" || $("#n_usePlace").val() == undefined){
            alert("请选择使用场所!")
            return;
        }
        if($("#n_useProperty").val()=="" ||  $("#n_useProperty").val() =="0" || $("#n_useProperty").val() == undefined){
            alert("请选择使用性质!");
            return;
        }
        var startTime = $("#n_startTime").val();
        var endTime =$("#n_endTime").val();
        if(startTime>endTime){
            swal({
                title: "开始时间必须早于结束时间!",
                type: "info"
            });
            return;
        }
        startTime = startTime.replace('T','');
        endTime = endTime.replace('T','');
        $.post("<%=request.getContextPath()%>/noWorkDayPlace/saveNoWorkDayPlace", {
            id:'${id}',
            requestDept: $("#n_requestDept").val(),
            requester: $("#n_requester").val(),
            requestDate:date,
            startTime:startTime,
            endTime:endTime,
            content: $("#n_content").val(),
            peopleNumber: $("#n_peopleNumber").val(),
            usePlace:$("#n_usePlace").val(),
            useProperty:$("#n_useProperty").val(),
            remark:$("#n_remark").val()
        }, function (msg) {
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

