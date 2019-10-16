<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-3 tar">
        申请日期
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.requestDate}" readonly="readonly"/>
    </div>

</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>奖助学金所属学期
    </div>
    <div class="col-md-9">
        <input id="term" readonly="readonly"
                class="validate[required,maxSize[100]] form-control" value="${grantmanagement.grantManagementTerm}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>奖助学金名称
    </div>
    <div class="col-md-9">
        <input id="grantManagementNameSel" readonly="readonly"
                class="validate[required,maxSize[100]] form-control" value="${grantmanagement.grantManagementName}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.studentId}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        性別
    </div>
    <div class="col-md-9">
        <input id="sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.sex}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.departmentId}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${grantmanagement.classId}" readonly="readonly"/>
    </div>
</div>

<input id="printFunds" hidden value="<%=request.getContextPath()%>/grantmanagement/printGrantManagement?id=${grantmanagement.id}">

<script>


</script>

