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
    <style>
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
        <h1 class="mui-title">报修申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="mui-content">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修类型
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <select id="repairType" name="repairType">
                    <option value="">请选择</option>
                    <c:forEach var="dic" items="${dics}">
                        <option value="${dic.id}">${dic.text}</option>
                    </c:forEach>
                </select>
            </div>
<%--            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>所在位置
            </div>
            <div class="col-md-9">
                <input id="position" name="position"/>
            </div>--%>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>报修物品名称
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center; ">
                <div id="itemNameSelect"></div>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>联系人电话
            </div>
            <div class="col-md-9">
                <input id="contactNumber" name="contactNumber"/>
            </div>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>故障描述
            </div>
            <div class="col-md-9">
                <input id="faultDescription" name="faultDescription"/>
            </div>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>维修地址
            </div>
            <div class="col-md-9">
                <input id="repairAddress" name="repairAddress"/>
            </div>
<%--            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>资产编号
            </div>
            <div class="col-md-9">
                <input id="assetsID" name="assetsID"/>
            </div>--%>
            <div class="col-md-3 tar">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>附件
            </div>
            <div class="col-md-9">
                <form id="form" enctype="multipart/form-data" method="post">
                    <input id="file" name="file" type="file" multiple/>
                </form>
            </div>
            <div style="line-height:40px;height:40px;margin-top: 10px;text-align:center;">
                <button class="mui-btn mui-btn-primary" style="width:80%;" onclick="save()">提交</button>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " id ",
            text: " dic_name ",
            tableName: " T_SYS_USERDIC ",
            where: " WHERE 1 = 1 and dic_type='BXWPXX' and VALID_FLAG=1 " ,
            orderby: " order by create_time desc "
        }, function (data) {
            $.each(data, function (key, map) {
                if (data.length == 0) {
                    $("#itemNameSelect").append("' <label>' + map.TEXT + '</label>'");
                } else {
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.text + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                        '</div>';
                    $("#itemNameSelect").append(doc);
                }
            })
        })
    })
    function save() {
        var reg = /^[0-9]+.?[0-9]*$/;
        var regTel = /^1[0-9]{10}$/;
        if ($("#repairType").val() == "" || $("#repairType").val() == "0" || $("#repairType").val() == undefined) {
            alert("请填写报修类型！");
            return;
        }
        /*if ($("#assetsID").val() == "" || $("#assetsID").val() == "0" || $("#assetsID").val() == undefined) {
            swal({
                title: "请填写资产编号！",
                type: "info"
            });
            return;
        }*/

        /*if ($("#assetsID").val() != "" && !reg.test($("#assetsID").val())) {
            swal({
                title: "资产编号请填写数字！",
                type: "info"
            });
            return;
        }*/
        var resVal = getCheckBoxRes('rds').toString();
        if (resVal == "") {
            alert("请填写报修物品名称！");
            return;
        }
        if ($("#contactNumber").val() == "" || $("#contactNumber").val() == "0" || $("#contactNumber").val() == undefined) {
            alert("请填写联系方式！");
            return;
        }
        if (!reg.test($("#contactNumber").val())) {
            alert("联系方式填写数字！");
            return;
        } else if (!regTel.test($("#contactNumber").val())) {
            alert("联系方式请填写11位手机号！");
            return;
        }

        $.post("<%=request.getContextPath()%>/repair/saveRepair", {
            repairType: $("#repairType").val(),
            //assetsID: $("#assetsID").val(),
            //position: $("#position").val(),
            dept: "${pdept}",
            category: "${category}",
            itemName: resVal,
            repairAddress: $("#repairAddress").val(),
            faultDescription: $("#faultDescription").val(),
            contactNumber: $("#contactNumber").val(),
        }, function (msg) {
            if (msg.status == 1) {
                var form = new FormData(document.getElementById("form"));
                $.ajax({
                    url: '<%=request.getContextPath()%>/app/files/insertFiles?businessType=TEST&businessId=' + msg.result + '&tableName=T_ZW_REPAIR',
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
        });
    }
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

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

</script>