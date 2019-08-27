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
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content" id="mainPage">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">请款三申请</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()"
              style="color:#fff;"></span>
    </header>
    <div class="">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请部门
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDept" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${funds.requestDept}" readonly="readonly"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请人
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestEr" type="text" style="line-height:40px;height:40px;text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${funds.manager}" readonly="readonly"/>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请时间
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">
            <input id="f_requestDate" type="text" style="text-align:center;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${funds.requestDate}" readonly/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>申请原因
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                    <textarea id="e_reason" style="text-align:center;" maxlength="330" placeholder="最多输入330个字"
                              class="validate[required,maxSize[100]] form-control"
                              value="${funds.reason}">${funds.reason}</textarea>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;<span class="iconBtx">*</span>小写金额
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
            <input id="e_amount" type="text" style="text-align:center;" placeholder="请输入数字"
                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                   class="validate[required,maxSize[100]] form-control"
                   value="${funds.amount}"/>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            &nbsp;&nbsp;&nbsp;&nbsp;备注
        </div>
        <div class="col-md-9" style="vertical-align:middle;text-align:center;">
                <textarea id="a_remark" style="text-align:center;" value="${funds.remark}" maxlength="330" placeholder="最多输入330个字"
                          class="validate[required,maxSize[100]] form-control"
                >${funds.remark}</textarea>
        </div>
    </div>
    <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
        &nbsp;&nbsp;&nbsp;&nbsp;已关联业务
    </div>
    <div class="col-md-9" style="vertical-align:middle;">
        <div class="mui-indexed-list-inner">
            <ul class="mui-table-view">
                <c:forEach items="${requestScope.list}" var="work">
                    <c:if test="${empty requestScope.list}">
                        <li data-value="AKU" class="mui-table-view-cell">
                            <div style="font-size: 13px;padding-top: 1%;">
                                &nbsp;&nbsp;无
                            </div>
                        </li>
                    </c:if>
                    <c:if test="${not empty requestScope.list}">
                        <li data-value="AKU" class="mui-table-view-cell">
                            <a class="mui-navigate-right"
                               onclick="fundsList('${work.businessId}')">&nbsp;${work.name}: ${work.workflowName}
                                <div style="font-size: 13px;padding-top: 1%;">
                                    &nbsp;&nbsp;${work.createTime}
                                </div>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<input id="e_id" hidden value="${id}">
<input id="tableName" hidden value="T_BG_FUNDS3_WF">
<input id="workflowCode" hidden value="T_BG_FUNDS3_WF01">
<script>

    function save() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if ($("#e_reason").val() == "" || $("#e_reason").val() == null) {
            alert("请填写申请原因");
            return;
        }
        if ($("#e_amount").val() == "") {
            alert("请填写小写金额");
            return;
        }
        if (!reg.test($("#e_amount").val())) {
            alert("小写金额请输入数字");
            return;
        }
        showSaveLoadingByClass('.saveBtnClass button');
        $.post("<%=request.getContextPath()%>/funds3/saveFundsAPP", {
            id: $("#e_id").val(),
            amount: $("#e_amount").val(),
            remark: $("#a_remark").val(),
            requestDate: '${funds.requestDate}',
            reason: $("#e_reason").val()
        }, function (msg) {
            hideSaveLoadingByClass('.saveBtnClass button');
            alert("数据修改成功！");
        })
        return true;
    }
</script>