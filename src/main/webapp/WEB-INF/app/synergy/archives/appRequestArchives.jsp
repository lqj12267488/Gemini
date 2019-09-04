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
<div class="mui-inner-wrap">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">电子档案变更原因</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="mui-content">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx"></span>说明：
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="reason" style="text-align:center;" maxlength="665" placeholder="最多输入665个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${archives.reason}">${archives.reason}</textarea>
            </div>
            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
            <div style="text-align: center" class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="request" style="width:80%; display: block; "
                            onclick="saveArchives()">申请
                    </button>
                    <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
                    <button class="mui-btn mui-btn-primary" id="assent" style="width:80%; display: block; "
                            onclick="assentArchives()">通过
                    </button>
                    <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
                    <button class="mui-btn mui-btn-primary" id="edit" style="width:80%; display: block; "
                            onclick="editArchives()">驳回
                    </button>
                    <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
                </center>
            </div>
        </div>
    </div>
</div>
</div>
<input id="archivesId" type="hidden" value="${archives.archivesId}">
<input id="menuType" type="hidden" value="${menuType}">
<input id="archivesCode" hidden value="${archives.archivesCode}">
<input id="archivesName" hidden value="${archives.archivesName}">
<input id="editedId" hidden value="${archives.editedId}">
<input id="role" hidden value="${role}">
<input id="requestFlag" hidden value="${archives.requestFlag}">
</body>
<script>
    $(document).ready(function () {
        if ("${audit}" == "audit") {
            $("#request").hide();
            $("#assent").show();
            $("#edit").show();
        } else {
            $("#request").show();
            $("#assent").hide();
            $("#edit").hide();
            $("textarea").removeAttr('readonly');
        }
    })

    function saveArchives() {
        if ($("#reason").val() == "" || $("#reason").val() == "0" || $("#reason").val() == undefined) {
            alert("请填写说明!");
            return;
        }
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            reason: $("#reason").val(),
            requestFlag: "1",
        }, function (msg) {
            if (msg.status == 1) {
                alert("已申请");
                window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType="
                    + $("#menuType").val()+'&ptyh=${ptyh}&bmzr=${bmzr}&dagl=${dagl}&xld=${xld}&dxz=${dxz}';
            }
        })
    }

    function assentArchives() {
        var aflag=$("#requestFlag").val();
        if(aflag=='1'){
            $("#requestFlag").val("2");
        }else {
            $("#requestFlag").val("5");
        }
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            archivesName: $("#archivesName").val(),
            archivesCode: $("#archivesCode").val(),
            reason: $("#reason").val(),
            requestFlag: $("#requestFlag").val(),
        }, function (msg) {
            if (msg.status == 1) {
                alert("已通过该申请");
                window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=2" + $("#menuType").val();
            }
        })
    }

    function editArchives() {
        var reflag="0";
        if("0"==$("#requestFlag").val()){
            reflag="4";
        }else if("1"==$("#requestFlag").val()){
            reflag="3";
        }
        $.post("<%=request.getContextPath()%>/archives/saveArchivesRequest", {
            archivesId: $("#archivesId").val(),
            requestFlag: reflag,
        }, function (msg) {
            if (msg.status == 1) {
                alert("已驳回该申请");
                window.location.href = "<%=request.getContextPath()%>/archives/appArchivesInfoList?menuType=2" + $("#menuType").val();
            }
        })
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>

