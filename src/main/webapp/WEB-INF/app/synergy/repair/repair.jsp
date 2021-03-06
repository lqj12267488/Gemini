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
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.previewimage.js"></script>
    <style>
        .col-md-9 {
            line-height: 40px;
            height: 40px;
            text-align: center;
            width: 100%;
        }

        input {
            line-height: 40px;
            height: 40px;
            text-align: center;
            width: 100%;
        }

        .col-md-3 {
            background: #d0d0d0;
            height: 25px;
            vertical-align: middle;
        }
    </style>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap" id="main">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">后勤维修</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="mui-content">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>维修状态
            </div>
            <select id="reFlag">
                <option value="">请选择</option>
                <c:forEach var="re" items="${reflag}">
                    <option value="${re.id}">${re.text}</option>
                </c:forEach>
            </select>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修类型
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                ${repair.repairTypeShow}
            </div>
<%--            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>所在位置
            </div>
            <div class="col-md-9">
                ${repair.position}
            </div>--%>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修物品名称
            </div>
            <div class="col-md-9">
                ${repair.itemNameShow}
            </div>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>联系人电话
            </div>
            <div class="col-md-9">
                ${repair.contactNumber}
            </div>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>故障描述
            </div>
            <div class="col-md-9">
                ${repair.faultDescription}
            </div>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>维修地址
            </div>
            <div class="col-md-9">
                ${repair.repairAddress}
            </div>
<%--            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>资产编号
            </div>
            <div class="col-md-9">
                ${repair.assetsID}
            </div>--%>
            <%--<div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>附件
            </div>
            <div class="col-md-9">
                <form id="form" enctype="multipart/form-data" method="post">
                    <input id="file" name="file" type="file" multiple/>
                </form>
            </div>--%>

            <%--<div class="col-md-9">
                <form id="form" enctype="multipart/form-data" method="post">
                    <input id="file" name="file" type="file" multiple/>
                </form>
            </div>--%>
            <c:if test="${flag == '1'}">

                    <div class="col-md-3 tar">
                        &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>维修说明
                    </div>
                    <div>
                        <input type="text" id="contentaa"/>
                    </div>
                    <div id="file" class="form-row">
                        <div class="col-md-3 tar"style="background:#d0d0d0;height:25px;vertical-align:middle;">
                            附件
                        </div>
                    </div>

                <div class="col-md-3 tar">
                    &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>附件上传
                </div>
                <div class="col-md-9">
                    <form id="form" enctype="multipart/form-data" method="post">
                        <input id="file1" name="file" type="file" multiple/>
                    </form>
                </div>
                    <div style="text-align: center" >
                    <center>
                        <button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                                onclick="saveContent()">提交
                        </button>
                    </center>
                    </div>
            </c:if>


        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#reFlag").val('${repair.requestFlag}');

        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${repair.repairID}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="col-md-9" style="vertical-align:middle; height: auto; margin-bottom: 10px">' +
                    '<div class="mui-indexed-list-inner">' +
                    '<ul class="mui-table-view">' +
                    '<li data-value="AKU" class="mui-table-view-cell">' +
                    '无' +
                    '</li>' +
                    '</ul>' +
                    '</div>' +
                    '</div>');
            } else {
                $.each(data.data, function (i, val) {
                    var str = "";
                    if(".bmp、.jpg、.jpeg、.png、.gif".indexOf(getFileExtendingName(data.fileName)) == -1){
                        str = '<a href="/files/downloadFiles?id=' + val.fileId + '" class="mui-navigate-right" target="_blank">' + val.fileName + '</a>';
                    }else{
                        str = '<img src="<%=request.getContextPath()%>'+val.fileUrl+'"style="width:320px;height:320px;"  data-preview-src="" data-preview-group="1" />';
                    }
                    $("#file").append('<div class="col-md-9" style="vertical-align:middle; height: auto; margin-bottom: 10px">' +
                        '<div class="mui-indexed-list-inner">' +
                        '<ul class="mui-table-view">' +
                        '<li data-value="AKU" class="mui-table-view-cell">' +
                        str +
                        '</li>' +
                        '</ul>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        mui.previewImage();
    })
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function saveContent() {
        if ($("#contentaa").val() == '' || $("#contentaa").val() == null || $("#contentaa").val() == undefined) {
            alert("请填写维修说明！")
            return;
        }
        $.post("<%=request.getContextPath()%>/repair/saveContent", {
            repairID: "${repair.repairID}",
            content: $("#contentaa").val(),
            requestFlag: $("#reFlag").val()
        }, function (msg) {
            alert(msg.msg)
            if (msg.status == 1) {
                var form = new FormData(document.getElementById("form"));
                $.ajax({
                    url: '<%=request.getContextPath()%>/app/files/insertFiles1?businessType=TEST&businessId=' + "${repair.repairID}" + '&tableName=T_ZW_REPAIR',
                    type: "post",
                    data: form,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        $.post("<%=request.getContextPath()%>/repair/submitRepair", {
                            repairID: msg.result
                        }, function (msg) {
                            alert(msg.msg)
                        })
                    }
                });
            }
            window.location.href = "<%=request.getContextPath()%>/repair/repairApp2?flag=1"
        })
    }
    function getFileExtendingName (filename) {
        // 文件扩展名匹配正则
        var reg = /\.[^\.]+$/;
        var matches = reg.exec(filename);
        if (matches) {
            return matches[0];
        }
        return '';
    }
</script>