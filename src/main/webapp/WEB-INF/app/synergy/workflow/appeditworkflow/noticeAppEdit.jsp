<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 15:49
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
        <h1 class="mui-title">公告申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${notice.createDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${notice.creator}" readonly="readonly"/>
        </div>


        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
            <input type="text" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${notice.publicTime}" readonly/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>公告类型
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <div id="select"></div>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标题
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_title" style="text-align:center;" maxlength="30" placeholder="最多输入30个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${notice.title}">${notice.title}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>内容
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_content" style="text-align:center;" maxlength="665" placeholder="最多输入665个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${notice.content}">${notice.content}</textarea>
        </div>
    </div>
</div>
<input id="noticeid" type="hidden" value="${id}">
</body>
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'GGLX'
        }, function (data) {
            $("#select").append("<select id='f_noticeTypeId' class='mui-btn mui-btn-block'></select>");
            $("#f_noticeTypeId").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;${notice.typeShow}</option>");
            $.each(data, function (index, content) {
                $("#f_noticeTypeId").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
    })



    function changeRequestDays() {
        var start = new Date($("#f_startTime").val().substring(0, 10)).getTime();
        var end = new Date($("#f_endTime").val().substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#f_requestDays").val(cha + 1);
        }
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function save() {
        var date = $("#f_requestDate").val().replace("T", " ");
        date=date.substring(0,date.length-7);
        var type = '';
        if ($("#f_title").val() == "" || $("#f_title").val() == "0" || $("#f_title").val() == undefined) {
            alert("请填写公告标题");
            return;
        }
        if ($("#f_noticeTypeId").val() == "" || $("#f_noticeTypeId").val() == "0" || $("#f_noticeTypeId").val() == undefined) {
            type = '${notice.type}';
        }else{
            type = $("#f_noticeTypeId option:selected").val();
        }
        if ($("#f_content").val() == "" || $("#f_content").val() == "0" || $("#f_content").val() == undefined) {
            alert("请填写公告内容");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/saveNotice", {
            id: $("#noticeid").val(),
            title:$("#f_title").val(),
            publicTime: date,
            type: type,
            content: $("#f_content").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！");
        })
        return true;
    }
</script>

