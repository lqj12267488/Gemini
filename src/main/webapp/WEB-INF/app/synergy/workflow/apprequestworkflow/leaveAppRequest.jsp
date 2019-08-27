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
        <h1 class="mui-title">请假申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="mui-content" style="padding-top: 0%">
        <div id="layout"
             style="display:none;z-index:999;position:absolute;width: 100%;height: 100px;text-align: center"></div>
        <div class="mainBodyClass">
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="dept" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.requestDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.requester}" readonly="readonly"/>
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
                <input type="datetime-local" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.requestDate}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假开始时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_startTime" type="date" style="line-height:40px;height:40px;text-align:center;"
                       align="center"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.startTime}" onchange="changeRequestDays()"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假结束时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_endTime" type="date" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${leave.endTime}" onchange="changeRequestDays()"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假天数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="f_requestDays" type="text" style="line-height:40px;height:40px;text-align:center;" placeholder="非填写项"
                       readonly="readonly" class="validate[required,maxSize[100]] form-control"
                       value="${leave.requestDays}"/>
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假类型
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <div id="select"></div>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>请假原因
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="f_reason" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                          type="text" class="validate[required,maxSize[100]] form-control"
                          value="${leave.reason}">${leave.reason}</textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; display: block;"
                 id="bpeople">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>办理人
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
                <div id="selecter"></div>
            </div>

            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
            <div style="text-align: center" class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                            onclick="saveLeave()">提交
                    </button>
                </center>
            </div>
        </div>
    </div>
</div>
<input id="leaveid" type="hidden" value="${id}">
</body>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'QJLX'
        }, function (data) {
            $("#select").append("<select id='f_leaveTypeId' class='mui-btn mui-btn-block'></select>");
            $("#f_leaveTypeId").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#f_leaveTypeId").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        /*查询办理人*/
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: "T_RS_LEAVE_WF",
            workflowCode: "T_RS_LEAVE_WF01",
            businessId: $("#leaveid").val()
        }, function (data) {
            if (data.emps.length == 0) {
                $("#selecter").append("<label>当前没有办理人</label>");
                return;
            }
            if (data.nodeType == 0) {
                $("#selecter").append("<select id='personId' class='mui-btn mui-btn-block'></select>");
                $("#personId").append("<option value=''>请选择</option>");
                $.each(data.emps, function (index, content) {
                    $("#personId").append("<option value='" + content.id + "'>" + content.text + "</option>");
                })
            } else {
                $.each(data.emps, function (key, map) {
                    if (data.emps.nodeType == 0) {
                        $("#selecter").append("<select id='personId'></select>");
                        $("#personId").append("<option value=''>请选择</option>");
                        $.each(data.emps, function (index, content) {
                            $("#personId").append("<option value='" + content.id + "'>" + content.name + "</option>");
                        })
                    } else {
                        doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                            ' <label>' + map.text + '</label>' +
                            '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                            '<input hidden value="' + map.text + '" class="cbs"/>' +
                            '</div>';
                        $("#selecter").append(doc);
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

    function changeRequestDays() {
        var start = new Date($("#f_startTime").val().substring(0, 10)).getTime();
        var end = new Date($("#f_endTime").val().substring(0, 10)).getTime();
        if (end >= start) {
            var cha = (end - start) / 60 / 60 / 24 / 1000;
            $("#f_requestDays").val(cha + 1);
        }
    }

    function saveLeave() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', ' ');
        var startTime = $("#f_startTime").val();
        startTime = startTime.replace('T', ' ');
        var endTime = $("#f_endTime").val();
        endTime = endTime.replace('T', ' ');
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            alert("请填写申请时间");
            return;
        }
        if ($("#f_startTime").val() == "" || $("#f_startTime").val() == "0") {
            alert("请填写请假开始时间");
            return;
        }
        if ($("#f_endTime").val() == "" || $("#f_endTime").val() == "0") {
            alert("请填写请假结束时间");
            return;
        }
        if ($("#f_startTime").val() > $("#f_endTime").val()) {
            alert("请选择请假开始时间需要在请假结束时间之前！");
            return;
        }
        if ($("#f_leaveTypeId").val() == "" || $("#f_leaveTypeId").val() == "0" || $("#f_leaveTypeId").val() == undefined) {
            alert("请填写请假类型");
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined) {
            alert("请填写请假原因");
            return;
        }
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
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/leave/saveLeaveAPP", {
            id: $("#leaveid").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            requestDays: $("#f_requestDays").val(),
            leaveType: $("#f_leaveTypeId option:selected").val(),
            reason: $("#f_reason").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1) {
                $.post("<%=request.getContextPath()%>/submit", {
                        businessId: $("#leaveid").val(),
                        tableName: "T_RS_LEAVE_WF",
                        workflowCode: "T_RS_LEAVE_WF01",
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

