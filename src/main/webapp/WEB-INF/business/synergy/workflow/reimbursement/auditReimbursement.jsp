<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/19
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%--待办里的办理页面--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${reimbursement.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="requester"
               class="validate[required,maxSize[100]] form-control"
               readonly=“readonly”
               value="${reimbursement.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="requestDate" type="date"
               readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.requestDate}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        报销事由
    </div>
    <div class="col-md-9">
        <input id="rcause"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.rcause}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        报销内容
    </div>
    <div class="col-md-9">
        <input id="content"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.content}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        报销金额
    </div>
    <div class="col-md-9">
        <input id="money"
               readonly=“readonly”
               class="validate[required,maxSize[100]] form-control"
               value="${reimbursement.money}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        已关联业务
    </div>
    <div class="col-md-9">
        <div class="side pull-right">
            <a href="#" onclick="fundAudit()"></a>
        </div>
        <div class="head bg-dot30" id="fuAudit" style="width: 100%;">
        </div>
    </div>
</div>
<input id="id" hidden value="${reimbursement.id}">
<input id="printFunds" hidden value="<%=request.getContextPath()%>/reimbursement/printFunds?id=${reimbursement.id}">
<script>
    $(document).ready(function () {
        fundAudit();
    })

    function fundAudit() {
        $("#fuAudit").load("<%=request.getContextPath()%>/association/processLoadIndexUnAudit?id=${reimbursement.id}"+"&workflowCode="+"T_BG_REIMBURSEMENT_WF01");
    }
    function fAudit(url, tableName, businessId,flag) {
        $("#dialogFile").load("<%=request.getContextPath()%>/association/getFundsLog", {
        id: businessId,
        url:url,
        tableName:tableName,
        businessId:businessId
    })
    $("#dialogFile").modal("show");

}
</script>