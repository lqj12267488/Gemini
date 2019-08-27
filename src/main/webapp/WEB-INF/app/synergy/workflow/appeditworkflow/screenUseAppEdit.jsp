<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:33
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
        <h1 class="mui-title">大屏幕使用申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       readonly="readonly"
                       class="validate[required,maxSize[20]] form-control"
                       value="${screenUse.requestDept}"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>经办人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requester" type="text" readonly="readonly"
                       style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${screenUse.requester}"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control" readonly="readonly"
                       value="${screenUse.requestDate}"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用日期
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="usingTime" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control" readonly="readonly"
                       value="${screenUse.usingTime}"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请内容
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="content" style="text-align:center;" value="${screenUse.content}"
                          maxlength="165" placeholder="最多输入165个字"
                          class="validate[required,maxSize[100]] form-control"
                >${screenUse.content}</textarea>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>大屏幕
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <div id="select"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                备注
            </div>

            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="remark" style="text-align:center;" value="${screenUse.remark}"
                          maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control"
                >${screenUse.remark}</textarea>
            </div>
        </div>
    </div>
</div>
<script>
    var doc = '';
    $(document).ready(function () {
        $("#requestDate").val('${screenUse.requestDate}'.replace("T", " "));
        $("#usingTime").val('${screenUse.usingTime}'.replace("T", " "));
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'DPM',
        }, function (data) {
            var screen = '${screenUse.screen}';
            if (data.length == 0) {
                $("#select").append("' <label>' + 无数据 + '</label>'");
            } else {
                $.each(data, function (key, map) {
                    var checkvalue = "";
                    if (("," + screen + ",").indexOf("," + map.id + ",") != -1) {
                        checkvalue = 'checked="checked"';
                    }
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" ' + checkvalue + ' class="rds1"/>' +
                        '</div>';
                    $("#select").append(doc);
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
        var resVal = getCheckBoxRes('rds1').toString();
        if ($("#content").val() == "" || $("#content").val() == "0" || $("#content").val() == undefined) {
            alert("请填写申请内容")
            return;
        }
        if (resVal == "") {
            alert("请选择大屏幕")
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        var usingTime = $("#usingTime").val().replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/screenUse/saveScreenUse", {
            id: '${id}',
            content: $("#content").val(),
            screen: resVal,
            requestDate: requestDate,
            usingTime: usingTime,
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