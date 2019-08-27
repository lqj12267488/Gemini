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
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"  style="color:#fff;"></a>
        <h1 class="mui-title">报修管理</h1>
    </header>
    <div class="">
        <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center">
        </div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;报修种类
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_repairTypeShow" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.repairTypeShow}" readonly="readonly"/>
            </div>
            <%--<div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;资产编号
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_assetsID" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.assetsID}" readonly="readonly"/>
            </div>--%>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;所在位置
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_position" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.position}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;所在部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.dept}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;报修物品名称
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_itemName" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.itemName}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;维修地址
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_repairAddress" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.repairAddress}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;故障描述
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_faultDescription" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.faultDescription}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;联系方式
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_contactNumber" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.contactNumber}" readonly="readonly"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;报修状态
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="a_requestFlag" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${repair.requestFlag}" readonly="readonly"/>
            </div>
            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
            <div style="text-align: center"  class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="noticflag" style="width:80%; "
                            onclick="yesReadedt()" >标为已读</button>
                </center>
            </div>
            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>

        </div>
    </div>

</div>
<script>
   /* $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId:  $("#appid").val(),
        }, function (data) {
            if (data.data.length == 0) {
                $("#noticeFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>'+
                    '</div>'+
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    $("#noticeFile").append('<div class="col-md-9" style="vertical-align:middle;">'+
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        '<a href="<%=request.getContextPath()%>/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>' +
                        '</ul>'+
                        '</div>'+
                        '</div>');
                })
            }
        })
    })


    var  flagg=$("#flagg").val();
    if (flagg != "1") {
        document.getElementById('noticflag').style.display = "block";
    }
    else {*/

   $("#layout").load("<%=request.getContextPath()%>/appSaveLoading");

   function yesReadedt() {
       showSaveLoading(".saveBtnClass button");
       $.post("<%=request.getContextPath()%>/repair/insertRepairLog", {
           repairID: '${repairID}'
       }, function (msg) {
           hideSaveLoading(".saveBtnClass button");
           if (msg.status == 1) {
               alert("成功标为已读。");
               window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listUnDo?type='0'";
           }

       })
   }
   /* }*/
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

