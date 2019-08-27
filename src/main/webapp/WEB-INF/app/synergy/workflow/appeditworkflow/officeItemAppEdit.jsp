<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/14
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
        <h1 class="mui-title">办公物资申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>

    </header>
    <div class="">
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${officeItem.requestDept}" readonly="readonly"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${officeItem.requester}" readonly="readonly"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="requestDate" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${officeItem.requestDate}" readonly="readonly"/>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                物品名称
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <div id="selecter"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                申请数量
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <input id="itemNumber" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${officeItem.itemNumber}"/>
            </div>
        </div>

        <div class="form-row">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                备注
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="remark" style="text-align:center;" value="${officeItem.remark}"
                          class="validate[required,maxSize[100]] form-control"
                >${officeItem.remark}</textarea>
            </div>
        </div>
    </div>
</div>
<script>
    var doc='';
    $(document).ready(function () {
        $("#requestDate").val('${officeItem.requestDate}'.replace("T"," "));
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'BGHC',
        }, function (data) {
            var itemName='${officeItem.itemName}';
            // $.each(data, function (key, map) {
                if (data.length == 0) {
                    $("#selecter").append("' <label>'无数据'</label>'");
                } else {
                    $.each(data, function (key, map) {
                        var checkvalue ="";
                        if((","+itemName+",").indexOf(","+map.id+",") != -1 ){
                            checkvalue = 'checked="checked"';
                        }
                        doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                            ' <label style="background-color: #fff">' + map.name + '</label>' +
                            '<input name="checkbox"  type="checkbox" value="' + map.id + '" '+checkvalue+' class="rdss"/>' +
                            '</div>';
                        $("#selecter").append(doc);
                    })
                }
            //
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
        var resVal = getCheckBoxRes('rdss').toString();
        var reg = new RegExp("^[0-9]*$");
        var date = $("#requestDate").val();
        date = date.replace('T', '');
        if (resVal == "" || resVal == undefined ) {
            alert("请选择物品名称")
            return;
        }
        if ($("#itemNumber").val() == "") {
            alert("请填写申请数量")
            return;
        }
        if(!reg.test($("#itemNumber").val())){
            alert("申请数量请填写整数");
            return;
        }

        $.post("<%=request.getContextPath()%>/officeItem/saveOfficeItem", {
            id: '${id}',
            remark: $("#remark").val(),
            itemNumber: $("#itemNumber").val(),
            requestDate:date,
            itemName: resVal,
        }, function (msg) {
            alert("数据修改成功！");
        })
        return true;
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>