<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:41
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
        <h1 class="mui-title">团委款项申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leagues.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestEr" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leagues.manager}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDate" type="text" style="text-align:center;" readonly
                   class="validate[required,maxSize[100]] form-control"
                   value="${leagues.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请原因
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                    <textarea id="e_reason" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                              class="validate[required,maxSize[100]] form-control"
                              value="${leagues.reason}">${leagues.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>小写金额
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="e_amount" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${leagues.amount}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="a_remark" style="text-align:center;" value="${leagues.remark}"
                          class="validate[required,maxSize[100]] form-control" maxlength="330" placeholder="最多输入330个字"
                >${leagues.remark}</textarea>
        </div>
    </div>
</div>
<input id="e_id" hidden value="${id}">
<input id="tableName" hidden value="T_BG_LEAGUE_WF">
<input id="workflowCode" hidden value="T_BG_LEAGUE_WF01">
<script>
    var doc = '';
    $(document).ready(function () {
        $("#f_requestDate").val().replace("T", " ")
    })

    function save() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if ($("#e_reason").val() == "" || $("#e_reason").val() == null) {
            alert("请填写申请原因");
            return;
        }
        if ($("#e_amount").val() == "") {
            alert("请填写小写金额");
            return;
        }
        if (!reg.test($("#e_amount").val())) {
            alert("小写金额请输入数字");
            return;
        }
        var date = $("#f_requestDate").val().replace("T", " ");
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/leagues/saveLeague", {
            id: $("#e_id").val(),
            amount: $("#e_amount").val(),
            remark: $("#a_remark").val(),
            requestDate: date,
            reason: $("#e_reason").val()
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