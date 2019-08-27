<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/9
  Time: 14:08
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
        <h1 class="mui-title">物品采购申请</h1>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${goodsPurchasing.requestDept}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="requester" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${goodsPurchasing.requester}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请日期
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="requestDate" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${goodsPurchasing.requestDate}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>采购物品
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="goodsName" type="text" style="text-align:center;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${goodsPurchasing.goodsName}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>采购数量
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="goodsNum01" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>单位
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="goodsNum02" type="text" style="text-align:center;"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请事由
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="reason" style="text-align:center;" value="${goodsPurchasing.reason}"
                      maxlength="15" placeholder="最多输入50个字"
                      class="validate[required,maxSize[100]] form-control"
            >${goodsPurchasing.reason}</textarea>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>预算(万元)
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="budget" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[20]] form-control"
                   value="${goodsPurchasing.budget}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle;">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="remark" style="text-align:center;" value="${goodsPurchasing.remark}"
                      maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
            >${goodsPurchasing.remark}</textarea>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#requestDate").val('${goodsPurchasing.requestDate}'.replace("T", " "));
        goodsNumber = "${goodsPurchasing.goodsNum}";
        if (goodsNumber != 0 && goodsNumber != null && goodsNumber != undefined && goodsNumber != "") {
            var num = goodsNumber.match(/\d*\.?\d*/).toString().length;
            $("#goodsNum01").val(goodsNumber.substring(0, num));
            $("#goodsNum02").val(goodsNumber.substring($('#goodsNum01').val().length, goodsNumber.length));
        }
    })

    function save() {
        var reg = new RegExp("^[0-9]*$");
        var reg2 = new RegExp("^\\d+(\\.\\d+)?$");
        var reg3 = new RegExp("^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,4})?$");

        if ($("#goodsName").val() == "" || $("#goodsName").val() == "0" || $("#goodsName").val() == undefined) {
            alert("请填写采购物品名称！");
            return;
        }
        if ($("#goodsNum01").val() == "" || $("#goodsNum01").val() == "0" || $("#goodsNum01").val() == undefined) {
            alert("请填写采购物品数量！")
            return;
        }
        if (!reg2.test($("#goodsNum01").val())) {
            alert("采购物品数量请填写数字！")
            return;
        }
        if ($("#goodsNum02").val() == "" || $("#goodsNum02").val() == "0" || $("#goodsNum02").val() == undefined) {
            alert("请填写采购物品数量单位！");
            return;
        }
        if ($("#reason").val() == "" || $("#reason").val() == "0" || $("#reason").val() == undefined) {
            alert("请填写申请事由！")
            return;
        }
        if ($("#budget").val() == "" || $("#budget").val() == "0" || $("#budget").val() == undefined) {
            alert("请填写预算(万元)！")
            return;
        }
        if (!reg2.test($("#budget").val())) {
            alert("预算请填写数字！");
            return;
        } else if (!reg3.test($("#budget").val())) {
            alert("预算小数位数不能超过4位,请重新填写！")
            return;
        }
        var requestDate = $("#requestDate").val().replace('T', '');
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/goodsPurchasing/saveGoodsPurchasing", {
            id: '${goodsPurchasing.id}',
            goodsNum: $("#goodsNum01").val() + $("#goodsNum02").val(),
            goodsName: $("#goodsName").val(),
            reason: $("#reason").val(),
            budget: $("#budget").val(),
            requestDate: requestDate,
            remark: $("#remark").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！")
        })
        return true;
    }
</script>
<style>
    .headerdiv {
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

