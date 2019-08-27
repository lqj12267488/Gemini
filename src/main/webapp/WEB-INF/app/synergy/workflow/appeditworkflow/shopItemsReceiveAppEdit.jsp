<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/8
  Time: 13:52
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
        <h1 class="mui-title">超市物品领取申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requester}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.requestDate}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>标准(元/人)
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="standard" type="text" style="line-height:40px;height:40px;text-align:center;" onchange="change()" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.standard}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>人数
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="peopleNumber" type="text" style="line-height:40px;height:40px;text-align:center;"
                   onchange="change1()" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.peopleNumber}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>总金额
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="totalAmount" type="text" style="line-height:40px;height:40px;text-align:center;"
                   readonly="readonly"
                   class="validate[required,maxSize[20]] form-control"
                   value="${shopItemsReceive.totalAmount}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>用途
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="use" style="text-align:center;" value="${shopItemsReceive.use}"
                          maxlength="165" placeholder="最多输入165个字"
                          class="validate[required,maxSize[100]] form-control"
                >${shopItemsReceive.use}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="remark" style="text-align:center;" value="${shopItemsReceive.remark}"
                          class="validate[required,maxSize[100]] form-control"
                          maxlength="330" placeholder="最多输入330个字"
                >${shopItemsReceive.remark}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#f_requestDate").val('${shopItemsReceive.requestDate}'.replace("T", " "));
    })

    function change() {
        var reg2 = /^[0-9]+.?[0-9]*$/;
        if (!reg2.test($("#standard").val()) || $("#standard").val() == 0) {
            alert("输入信息错误,请输入正确标准（数字）");
            $("#standard").val("");
            return;
        } else {
            product();
        }
    }

    function change1() {
        var reg3 = new RegExp("^[0-9]*$");
        if (!reg3.test($("#peopleNumber").val()) || $("#peopleNumber").val() == null || $("#peopleNumber").val() == 0) {
            alert("输入信息错误,请输入正确人数（数字）");
            $("#peopleNumber").val("");
            return;
        } else {
            product();
        }

        function product() {
            var a = document.getElementById("standard").value;
            var b = document.getElementById("peopleNumber").value;
            document.getElementById("totalAmount").value = a * b;
        }
    }

    function save() {
        var reg = new RegExp("^[0-9]*$");
        var reg1 = /^[0-9]+.?[0-9]*$/;
        if ($("#f_requestDept").val() == "" || $("#f_requestDept").val() == "0" || $("#f_requestDept").val() == undefined) {
            alert("请填写申请部门");
            return;
        }
        if ($("#f_requester").val() == "" || $("#f_requester").val() == "0" || $("#f_requester").val() == undefined) {
            alert("请填写申请人");
            return;
        }
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            alert("请填写申请日期");
            return;
        }
        if (!reg1.test($("#standard").val())) {
            alert("标准(元/人)请输入数字");
            return;
        }
        if (!reg.test($("#peopleNumber").val()) || $("#peopleNumber").val() == null || $("#peopleNumber").val() == 0) {
            if ($("#peopleNumber").val() == 0) {
                alert("请填写人数至少1个人");
                return;
            }

            else {
                alert("人数请填写整数");
            }
            return;
        }


        if ($("#use").val() == "" || $("#use").val() == "0" || $("#use").val() == undefined) {
            alert("请填写用途");
            return;
        }
        var c_requestDate = $("#f_requestDate").val().replace('T', ' ');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/shopItemsReceive/saveShopItemsReceive", {
            id: '${id}',
            requestDept: $("#f_requestDept").val(),
            requester: $("#f_requester").val(),
            requestDate: c_requestDate,
            standard: $("#standard").val(),
            peopleNumber: $("#peopleNumber").val(),
            totalAmount: $("#totalAmount").val(),
            use: $("#use").val(),
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