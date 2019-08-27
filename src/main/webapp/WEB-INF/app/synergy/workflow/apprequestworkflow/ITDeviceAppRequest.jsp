<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/14
  Time: 11:14
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
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">IT设备维修申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="" style="padding-top: 0%">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${itDeviceRepai.requestDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${itDeviceRepai.requester}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requestDate" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${itDeviceRepai.requestDate}"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请原因
            </div>
            <div class="col-md-9" style="text-align:center;">
            <textarea id="h_content" style="text-align:center;"
                      class="validate[required,maxSize[20]] form-control"
                      maxlength="330" placeholder="最多输入330个字"
                      value="${itDeviceRepai.reason}">${itDeviceRepai.reason}</textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;备注
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <textarea id="h_remark" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                      class="validate[required,maxSize[100]] form-control"
                      value="${itDeviceRepai.remark}">${itDeviceRepai.remark}</textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;"
                 id="bpeople">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>办理人
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
                <div id="select"></div>
            </div>

            <div style="text-align: center" class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="save" style="width:80%; display: block; "
                            onclick="save()">提交
                    </button>
                </center>
            </div>
        </div>
    </div>
</div>
<input id="s_id" hidden value="${id}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    var doc = '';
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: "T_BG_ITDEVICEREPAIR_WF",
            workflowCode: "T_BG_ITDEVICEREPAIR_WF01",
            businessId: $("#s_id").val()
        }, function (data) {
            if (data.emps.length == 0) {
                $("#select").append("<label>当前没有办理人</label>");
                return;
            }
            if (data.nodeType == 0) {
                $("#select").append("<select id='personId' class='mui-btn mui-btn-block'></select>");
                $("#personId").append("<option value=''>请选择</option>");
                $.each(data.emps, function (index, content) {
                    $("#personId").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            } else {
                $.each(data.emps, function (key, map) {
                    if (data.emps.nodeType == 0) {
                        $("#select").append("<select id='personId'></select>");
                        $("#personId").append("<option value=''>请选择</option>");
                        $.each(data.emps, function (index, content) {
                            $("#personId").append("<option value='" + content.id + "'>" + content.name + "</option>");
                        })
                    } else {
                        if (map.id != "9999") {
                            doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                                ' <label>' + map.name + '</label>' +
                                '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                                '<input hidden value="' + map.name + '" class="cbs"/>' +
                                '</div>';
                            $("#select").append(doc);
                        }
                    }
                })
            }
        })
    })

    var checkVal = new Array();
    var checkText = new Array();

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

    function getCheckBoxText(className) {
        var rdsObj = document.getElementsByClassName('rds');
        var rdsObjs = document.getElementsByClassName(className);
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkText[k] = rdsObjs[i].value;
                k++;
            }
        }
        return checkText;
    }

    function save() {
        var resVal = getCheckBoxRes('rds').toString();
        var resText = getCheckBoxText('cbs').toString();
        var value = '';
        var text = '';
        var selectVal = $("#personId option:selected").val();
        if (resVal.length < 1 && selectVal == '') {
            mui.toast('请选择办理人');
            return;
        } else {
            if (resVal < 1) {
                value = $("#personId option:selected").val();
                text = $("#personId option:selected").text();
            } else {
                value = resVal;
                text = resText;
            }
        }
        if ($("#h_requestDate").val() == "" || $("#h_requestDate").val() == "0") {
            alert("请填写申请时间");
            return;
        }
        if ($("#h_content").val() == "" || $("#h_content").val() == "0" || $("#h_content").val() == undefined) {
            alert("请填写申请理由");
            return;
        }
        var date = $("#h_requestDate").val().replace("T", " ");
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/itdevicerepai/updateITDeviceRepaiAPP", {
            id: $("#s_id").val(),
            requestDate: date,
            reason: $("#h_content").val(),
            remark: $("#h_remark").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1) {
                $.post("<%=request.getContextPath()%>/submit", {
                        businessId: $("#s_id").val(),
                        tableName: "T_BG_ITDEVICEREPAIR_WF",
                        workflowCode: "T_BG_ITDEVICEREPAIR_WF01",
                        handleUser: value,
                        handleName: text
                    },
                    function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            window.location.href = "<%=request.getContextPath()%>/workflowApp/result/listStart?type=1"
                        }
                    })
            }
        })
    }

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
