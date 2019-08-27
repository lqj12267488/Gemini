<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/14
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
        <h1 class="mui-title">IT耗材/设备维修申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${itSuppliesRepair.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${itSuppliesRepair.manager}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="h_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;" readonly
                   class="validate[required,maxSize[20]] form-control"
                   value="${itSuppliesRepair.requestDate}"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>设备名称
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center; ">
            <div id="select"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请事由
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="h_reason" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${itSuppliesRepair.reason}">${itSuppliesRepair.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="a_remark" style="text-align:center;" value="${funds.remark}" maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control"
                >${funds.remark}</textarea>
        </div>
    </div>
</div>
<input id="it_id" hidden value="${id}">
<input id="tableName" hidden value="T_BG_ITSUPPLIESREPAIR_WF">
<input id="workflowCode" hidden value="T_BG_ITSUPPLIESREPAIR_WF01">
<script>
    var doc = '';
    var term = $("#term").val()
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'YZCHC',
        }, function (data) {
            var deviceName = '${itSuppliesRepair.deviceName}';
            if (data.length == 0) {
                $("#select").append("' <label>无数据</label>'");
            } else {
                $.each(data, function (key, map) {
                    var checkvalue ="";
                    if((","+deviceName+",").indexOf(","+map.id+",") != -1 ){
                        checkvalue = 'checked="checked"';
                    }
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '"  '+checkvalue+'  class="rds1"/>' +
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
        var date = $("#h_requestDate").val();
        date = date.replace('T', ' ');
        if (resVal == "" ) {
            alert("请选择设备");
            return;
        }
        if ($("#h_reason").val() == "" || $("#h_reason").val() == "0" || $("#h_reason").val() == undefined) {
            alert("请填写申请理由");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/ITSuppliesRepair/updateITSuppliesRepairById", {
            id: $("#it_id").val(),
            deviceName: resVal,
            requestDate: date,
            reason: $("#h_reason").val(),
            remark: $("#a_remark").val()
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


