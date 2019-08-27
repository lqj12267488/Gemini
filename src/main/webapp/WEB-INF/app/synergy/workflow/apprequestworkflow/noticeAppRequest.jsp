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
        <h1 class="mui-title">公告申请</h1>
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
                       value="${notice.requestDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="jbr" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${notice.requester}" readonly="readonly"/>
            </div>


            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;align-self:center;">
                <input type="datetime-local" id="f_requestDate" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${notice.publicTime}"/>
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
                            onclick="saveNotice()">提交
                    </button>
                </center>
            </div>
        </div>
    </div>
</div>
</div>
<input id="noticeid" type="hidden" value="${id}">
</body>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getSysDict", {
            name: 'GGLX'
        }, function (data) {
            $("#select").append("<select id='f_noticeTypeId' class='mui-btn mui-btn-block'></select>");
            $("#f_noticeTypeId").append("<option value=''>&nbsp;&nbsp;&nbsp;&nbsp;请选择</option>");
            $.each(data, function (index, content) {
                $("#f_noticeTypeId").append("<option value='" + content.id + "'>" + content.text + "</option>");
            })
        })
        /*查询办理人*/
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: "T_SYS_NOTICE",
            workflowCode: "T_SYS_NOTICE_WF",
            businessId: $("#noticeid").val()
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

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }

    function saveNotice() {
        var date = $("#f_requestDate").val().replace("T", " ");
        /*date = date.substring(0, date.length - 7);*/
        if ($("#f_requestDate").val() == "" || $("#f_requestDate").val() == "0") {
            alert("请填写申请时间");
            return;
        }
        if ($("#f_title").val() == "" || $("#f_title").val() == "0" || $("#f_title").val() == undefined) {
            alert("请填写公告标题");
            return;
        }
        if ($("#f_noticeTypeId").val() == "" || $("#f_noticeTypeId").val() == "0" || $("#f_noticeTypeId").val() == undefined) {
            alert("请选择公告类型");
            return;
        }
        if ($("#f_content").val() == "" || $("#f_content").val() == "0" || $("#f_content").val() == undefined) {
            alert("请填写公告内容");
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
        $.post("<%=request.getContextPath()%>/notice/saveNoticeAPP", {
            id: $("#noticeid").val(),
            title: $("#f_title").val(),
            publicTime: date,
            type: $("#f_noticeTypeId option:selected").val(),
            content: $("#f_content").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1) {
                $.post("<%=request.getContextPath()%>/submit", {
                        businessId: $("#noticeid").val(),
                        tableName: "T_SYS_NOTICE",
                        workflowCode: "T_SYS_NOTICE_WF",
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
</script>

