<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/18
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/salaryApproval/printSalaryApproval?id=${salaryApproval.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="f_requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${salaryApproval.requestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="f_requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${salaryApproval.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" readonly="readonly" value="${salaryApproval.requestDate}" type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        年份
    </div>
    <div class="col-md-9">
        <input id="f_year" type="" readonly="readonly"  class="validate[required,maxSize[100]] form-control" value="${salaryApproval.year}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        月份
    </div>
    <div class="col-md-9">
        <input id="f_month" type="" readonly="readonly"  class="validate[required,maxSize[100]] form-control" value="${salaryApproval.month}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        工资单名称
    </div>
    <div class="col-md-9">
        <textarea id="f_fileName" readonly="readonly" class="validate[required,maxSize[100]] form-control">${salaryApproval.fileName}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
        <textarea id="f_remark" readonly="readonly" class="validate[required,maxSize[100]] form-control">${salaryApproval.remark}</textarea>
    </div>
</div>