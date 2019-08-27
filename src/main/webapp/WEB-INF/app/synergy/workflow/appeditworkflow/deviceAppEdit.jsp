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
        <h1 class="mui-title">设备调用申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="d_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${deviceUse.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="d_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${deviceUse.requester}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="d_requestDate" type="text"
                   readonly="readonly" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${deviceUse.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>设备名称
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selecter"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请事由
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="d_reason" style="text-align:center;" value="${deviceUse.reason}"
                      maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${deviceUse.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="d_remark" style="text-align:center;" value="${deviceUse.remark}" maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${deviceUse.remark}</textarea>
        </div>
    </div>
</div>
<script>
    var doc='';
    $(document).ready(function () {
        $("#d_requestDate").val('${deviceUse.requestDate}'.replace("T"," "));
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'ITSB',
        }, function (data) {
                var deviceName='${deviceUse.deviceName}';
                if (data.length == 0) {
                    $("#selecter").append("' <label>' + 无数据 + '</label>'");
                } else {
                    $.each(data, function (key, map) {
                        var checkvalue ="";
                        if((","+deviceName+",").indexOf(","+map.id+",") != -1 ){
                            checkvalue = 'checked="checked"';
                        }
                        doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
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
    function save() {
        var resVal = getCheckBoxRes('rdss').toString();
        if (resVal == "" ||  resVal == undefined) {
            alert("请选择设备!")
            return;
        }
        if ($("#d_reason").val() == "" || $("#d_reason").val() == "0" || $("#d_reason").val() == undefined) {
            alert("请填写申请事由!")
            return;
        }
        var requestDate = $("#d_requestDate").val().replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/deviceUse/saveDeviceUse", {
            id: '${id}',
            reason: $("#d_reason").val(),
            deviceName: resVal,
            requestDate: requestDate,
            remark: $("#d_remark").val()
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