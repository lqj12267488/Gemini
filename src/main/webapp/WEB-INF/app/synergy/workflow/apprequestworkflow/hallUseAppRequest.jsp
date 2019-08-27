<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/5
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
        <h1 class="mui-title">礼堂使用申请</h1>
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
                       value="${hallUse.requestDept}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requester" type="text" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hallUse.requester}" readonly="readonly"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_requestDate" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hallUse.requestDate}"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用设备
            </div>
            <div class="col-md-9" style="vertical-align:middle;">
                <div id="selecter"></div>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>开始时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_startTime" type="datetime-local" style="text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hallUse.startTime}"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>结束时间
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_endTime" type="datetime-local" style="line-height:40px;height:40px;text-align:center;"
                       class="validate[required,maxSize[100]] form-control"
                       value="${hallUse.endTime}"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>活动内容
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_content" type="text" style="line-height:40px;height:40px;text-align:center;"
                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                       maxlength="165" placeholder="最多输入165个字"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hallUse.content}"/>
            </div>

            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>参与人数
            </div>
            <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
                <input id="h_peopleNumber" type="text" style="text-align:center;" placeholder="请输入数字"
                       onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                       class="validate[required,maxSize[20]] form-control"
                       value="${hallUse.peopleNumber}"/>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>使用规范
            </div>
            <div class="col-md-9">
                        <textarea id="h_standard" style="height: 100px"
                                  class="validate[required,maxSize[100]] form-control"
                                  readonly>${standard.standardContent}</textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
                &nbsp;&nbsp;&nbsp;&nbsp;备注
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="a_remark" style="text-align:center;" value="${funds.remark}"
                          maxlength="165" placeholder="最多输入165个字"
                          class="validate[required,maxSize[100]] form-control"
                ></textarea>
            </div>
            <div class="col-md-3 tar" style="background:#d0d0d0;vertical-align:middle; display: block;"
                 id="bpeople">
                &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>办理人
            </div>
            <div class="col-md-9" style="vertical-align:middle;text-align:center;display: block;">
                <div id="select"></div>
            </div>
            <div class="col-md-9" style="height:10px;vertical-align:middle;text-align:center;"></div>
            <div style="text-align: center" class="saveBtnClass">
                <center>
                    <button class="mui-btn mui-btn-primary" id="save" style="width:80%; display: block; "
                            onclick="save()">提交
                    </button>
                    <%--<button class="mui-btn mui-btn-primary" id="submit" style="width:80%; display: block; "
                            onclick="save()">提交
                    </button>--%>
                </center>
            </div>
        </div>
    </div>
</div>
<input id="h_Id" type="hidden" value="${id}">
<input id="tableName" hidden value="T_BG_HALLUSE_WF">
<input id="workflowCode" hidden value="T_BG_HALLUSE_WF01">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.post("<%=request.getContextPath()%>/common/getUserDictToTree", {
            name: 'ITSB',
        }, function (data) {
            $.each(data, function (key, map) {
                if (data.length == 0) {
                    $("#selecter").append("' <label>' + map.name + '</label>'");
                } else {
                    doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                        ' <label style="background-color: #fff">' + map.name + '</label>' +
                        '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds"/>' +
                        '</div>';
                    $("#selecter").append(doc);
                }
            })
        })
        /*获取办理人*/
        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: "T_BG_HALLUSE_WF",
            workflowCode: "T_BG_HALLUSE_WF01",
            businessId: $("#h_Id").val()
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
                        doc = '<div class="mui-input-row mui-checkbox mui-left"> ' +
                            ' <label>' + map.text + '</label>' +
                            '<input name="checkbox"  type="checkbox" value="' + map.id + '" class="rds1"/>' +
                            '<input hidden value="' + map.text + '" class="cbs"/>' +
                            '</div>';
                        $("#select").append(doc);
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
        var rdsObj = document.getElementsByClassName('rds1');
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

    /*保存方法*/
    function save() {
        var rdsObj = document.getElementsByClassName('rds1');
        var k = 0;
        for (i = 0; i < rdsObj.length; i++) {
            if (rdsObj[i].checked) {
                checkVal[k] = rdsObj[i].value;
                k++;
            }
        }
        var res = checkVal.toString();
        var reg = new RegExp("^[0-9]*$");
        var date = $("#h_requestDate").val();
        date = date.replace('T', ' ');
        var startTime = $("#h_startTime").val();
        var endTime = $("#h_endTime").val();
        startTime = startTime.replace('T', ' ');
        endTime = endTime.replace('T', ' ');
        var resVal = getCheckBoxRes('rds').toString();
        var resText = getCheckBoxText('cbs').toString();
        var value = '';
        var text = '';
        var selectVal = $("#personId option:selected").val();
        if (res.length < 1 && selectVal == '') {
            mui.toast('请选择办理人');
            return;
        } else {
            if (res < 1) {
                value = $("#personId option:selected").val();
                text = $("#personId option:selected").text();
            } else {
                value = res;
                text = resText;
            }
        }
        if (resVal == '' || resVal == null) {
            alert("请选择使用设备");
            return;
        }
        if ($("#h_requestDate").val() == '' || $("#h_requestDate").val() == null) {
            alert("请选择申请时间");
            return;
        }
        if ($("#h_startTime").val() == '' || $("#h_startTime").val() == null) {
            alert("请选择开始时间");
            return;
        }
        if ($("#h_endTime").val() == '' || $("#h_endTime").val() == null) {
            alert("请选择结束时间");
            return;
        }
        if (startTime > endTime) {
            alert("开始时间必须早于结束时间");
            return;
        }
        if ($("#h_content").val() == '' || $("#h_content").val() == null) {
            alert("请填写活动内容");
            return;
        }
        if ($("#h_peopleNumber").val() == '' || $("#h_peopleNumber").val() == null) {
            alert("请填写参与人数");
            return;
        }
        if (!reg.test($("#h_peopleNumber").val())) {
            alert("参与人数请填写整数");
            return;
        }
        /* if ($("#h_standard").val() == '' || $("#h_standard").val() == null) {
             alert("请填写使用规范");
             return;
         }*/
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/hallUse/saveHallUseAPP", {
            id: $("#h_Id").val(),
            requestDept: $("#h_requestDept").val(),
            requester: $("#h_requester").val(),
            requestDate: date,
            startTime: startTime,
            endTime: endTime,
            usedevice: resVal,
            content: $("#h_content").val(),
            peopleNumber: $("#h_peopleNumber").val(),
            remark: $("#a_remark").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            if (msg.status == 1) {
                $.post("<%=request.getContextPath()%>/submit", {
                        businessId: $("#h_Id").val(),
                        tableName: "T_BG_HALLUSE_WF",
                        workflowCode: "T_BG_HALLUSE_WF01",
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
