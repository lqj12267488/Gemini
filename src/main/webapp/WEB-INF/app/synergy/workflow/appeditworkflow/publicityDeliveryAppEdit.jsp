<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 14:08
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
        <h1 class="mui-title">宣传稿件投递申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control" readonly="readonly"
                   value="${publicityDelivery.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${publicityDelivery.requestDept}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>撰稿人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${publicityDelivery.requester}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="caption" type="text" style="line-height:40px;height:40px;text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="10" placeholder="最多输入10个字"
                   class="validate[required,maxSize[100]] form-control"
                   value="${publicityDelivery.caption}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>发布渠道
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selecter"></div>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>

        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="remark" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control"
                          value="${publicityDelivery.remark}">${publicityDelivery.remark}</textarea>
        </div>
    </div>
</div>
<script>
    var doc = '';
    $(document).ready(function () {
        $("#requestDate").val('${publicityDelivery.requestDate}'.replace("T", " "));
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'FBQD',
        }, function (data) {
            var distributionChannels = '${publicityDelivery.distributionChannels}';
            if (data.length == 0) {
                $("#selecter").append("' <label>' + 无数据 + '</label>'");
            } else {
                $.each(data, function (key, map) {
                    var checkvalue = "";
                    if (("," + distributionChannels + ",").indexOf("," + map.id + ",") != -1) {
                        checkvalue = 'checked="checked"';
                    }
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" ' + checkvalue + ' class="rdss"/>' +
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

    function saveDept() {
        var resVal = getCheckBoxRes('rdss').toString();
        if ($("#caption").val() == "" || $("#caption").val() == "0" || $("#caption").val() == undefined) {
            alert("请填写标题");
            return;
        }
        if (resVal == "" || resVal == "0" || resVal == undefined) {
            alert("请选择发布渠道");
            return;
        }
        if ($("#requestDate").val() == "" || $("#requestDate").val() == "0" || $("#requestDate").val() == undefined) {
            alert("请填写申请时间");
            return;
        }
        if ($("#requestDept").val() == "" || $("#requestDept").val() == "0" || $("#requestDept").val() == undefined) {
            alert("请选择申请部门");
            return;
        }
        if ($("#requester").val() == "" || $("#requester").val() == "0" || $("#requester").val() == undefined) {
            alert("请选择撰稿人");
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/publicityDelivery/savePublicityDelivery", {
            id: '${publicityDelivery.id}',
            caption: $("#caption").val(),
            temp: $("#publicityDeliveryTemp").val(),
            distributionChannels: resVal,
            requestDate: requestDate,
            remark: $("#remark").val()
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
