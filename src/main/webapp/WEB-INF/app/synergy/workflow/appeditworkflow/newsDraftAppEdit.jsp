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
        <h1 class="mui-title">新闻稿发布申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${newsDraft.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${newsDraft.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>拟稿时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${newsDraft.requestDate}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标题
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="n_newsTitle" type="text" style="text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   maxlength="130" placeholder="最多输入130个字"
                   class="validate[required,maxSize[20]] form-control"
                   value="${newsDraft.newsTitle}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>内容
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="n_newsContent" style="text-align:center;" value="${newsDraft.newsContent}"
                      maxlength="1300" placeholder="最多输入1300个字"
                      class="validate[required,maxSize[100]] form-control"
            >${newsDraft.newsContent}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>核稿人
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selecter"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>新闻稿类型
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="selectType"></div>
        </div>
    </div>

    <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
        &nbsp;&nbsp;&nbsp;&nbsp;备注
    </div>
    <div class="col-md-9" style="vertical-align:middle;text-align:center;">
        <textarea id="n_remark" style="text-align:center;" value="${newsDraft.remark}" maxlength="130" placeholder="最多输入130个字"
                  class="validate[required,maxSize[100]] form-control"
        >${newsDraft.remark}</textarea>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#n_requestDate").val('${newsDraft.requestDate}'.replace("T"," "));
        $.post("<%=request.getContextPath()%>/newsDraft/getDeptPerson", {
        }, function (data) {
            $("#selecter").append("<select id='n_auditor' class='mui-btn mui-btn-block'></select>");
            $("#n_auditor").append("<option value='${newsDraft.auditor}'>&nbsp;&nbsp;&nbsp;&nbsp;${newsDraft.verifyingPerson}</option>");
            $.each(data, function (index, content) {
                $("#n_auditor").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'XWGLX'
        }, function (data) {
            $("#selectType").append("<select id='n_newsType' class='mui-btn mui-btn-block'></select>");
            $("#n_newsType").append("<option value='${newsDraft.newsType}'>&nbsp;&nbsp;&nbsp;&nbsp;${newsDraft.nType}</option>");
            $.each(data, function (index, content) {
                $("#n_newsType").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
    })
    function save(){
        var reg = /^[0-9]+.?[0-9]*$/;
        if($("#n_newsTitle").val()=="" ||  $("#n_newsTitle").val() =="0" || $("#n_newsTitle").val() == undefined){
            alert("请填写标题!");
            return;
        }
        if ($("#n_newsContent").val() == "" || $("#n_newsContent").val() == "0" || $("#n_newsContent").val() == undefined) {
            alert("请填写内容!");
            return;
        }
        if ($("#n_auditor").val() == "" || $("#n_auditor").val() == "0" || $("#n_auditor").val() == undefined) {
            alert("请选择核稿人!")
            return;
        }
        if ($("#n_newsType").val() == "" || $("#n_newsType").val() == "0" || $("#n_newsType").val() == undefined) {
            alert("请选择新闻类型!");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/newsDraft/saveNewsDraft", {
            id:'${id}',
            requestDept: $("#n_requestDept").val(),
            requester: $("#n_requester").val(),
            requestDate:$("#n_requestDate").val(),
            newsTitle: $("#n_newsTitle").val(),
            newsContent: $("#n_newsContent").val(),
            auditor: $("#n_auditor").val(),
            newsType: $("#n_newsType").val(),
            remark:$("#n_remark").val()
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

