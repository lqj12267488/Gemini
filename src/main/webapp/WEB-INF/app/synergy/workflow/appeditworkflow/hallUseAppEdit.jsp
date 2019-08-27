<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/5
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet"/>

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">礼堂使用申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDate" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.requestDate}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用设备
        </div>
        <div class="col-md-9" style="vertical-align:middle;">
            <div id="selecter"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>开始时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_startTime" type="datetime-local" style="text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hallUse.startTime}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>结束时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_endTime" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${hallUse.endTime}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>活动内容
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_content" type="text" style="line-height:40px;height:40px;text-align:center;" maxlength="165" placeholder="最多165个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${hallUse.content}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>参与人数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_peopleNumber" type="text" style="text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control" placeholder="请输入数字"
                   value="${hallUse.peopleNumber}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用规范
        </div>
        <div class="col-md-9">
                        <textarea id="h_standard" style="height: 100px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly>${standard.standardContent}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="a_remark" style="text-align:center;" value="${hallUse.remark}"
                          maxlength="165" placeholder="最多输入165个字"
                          class="validate[required,maxSize[100]] form-control"
                >${hallUse.remark}</textarea>
        </div>
    </div>
</div>
<input id="h_Id" type="hidden" value="${id}">
<input id="tableName" hidden value="T_BG_HALLUSE_WF">
<input id="workflowCode" hidden value="T_BG_HALLUSE_WF01">
<script>
    $(document).ready(function () {
        var use_device = '${hallUse.usedevice}';
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'ITSB',
        }, function (data) {
            if (data.length == 0) {
                $("#selecter").append("' <label>无数据</label>'");
            } else {
                $.each(data, function (key, map) {
                    var checkvalue ="";
                    if((","+use_device+",").indexOf(","+map.id+",") != -1 ){
                        checkvalue = 'checked="checked"';
                    }
                    var doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" '+checkvalue+' class="rdss"/>' +
                        '</div>';
                    $("#selecter").append(doc);
                })
            }
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

    /*保存方法*/
    function save() {
        var resVal = getCheckBoxRes('rdss').toString();
        var reg = new RegExp("^[0-9]*$");
        var date = $("#h_requestDate").val();
        date = date.replace('T', ' ');
        var startTime = $("#h_startTime").val();
        var endTime = $("#h_endTime").val();
        startTime = startTime.replace('T', ' ');
        endTime = endTime.replace('T', ' ');
        if (resVal == '' || resVal == null) {
            alert("请选择使用设备");
            return;
        }
        if ($("#h_startTime").val() == '' || $("#h_startTime").val() == null) {
            alert("请选择开始时间");
            return;
        }
        if ($("#h_endTime").val() == '' || $("#h_endTime").val() == null) {
            alert("请选择结束时间");
            return;
        }
        if (startTime > endTime) {
            alert("开始时间必须早于结束时间");
            return;
        }
        if ($("#h_content").val() == '' || $("#h_content").val() == null) {
            alert("请填写活动内容");
            return;
        }
        if ($("#h_peopleNumber").val() == '' || $("#h_peopleNumber").val() == null) {
            alert("请填写参与人数");
            return;
        }
        if (!reg.test($("#h_peopleNumber").val())) {
            alert("参与人数请填写整数");
            return;
        }
        showSaveLoading('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/hallUse/saveHallUse", {
            id: $("#h_Id").val(),
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            usedevice: resVal,
            content: $("#h_content").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            remark: $("#a_remark").val()
        }, function (msg) {
            hideSaveLoading('.saveBtnClass button');
            alert("数据修改成功！");
        })
        return true;
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
