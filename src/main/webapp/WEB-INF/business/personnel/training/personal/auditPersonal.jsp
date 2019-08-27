<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea{
            resize:none;
        }
    </style>
</head>
<input id="id" name="id" type="hidden" value="${personalTraining.id}">
<div class="form-row">
    <div class="col-md-2 tar">
        申请部门
    </div>
    <div class="col-md-4">
        <input id="requestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${personalTraining.requestDept}"/>
    </div>
    <div class="col-md-2 tar">
        经办人
    </div>
    <div class="col-md-4">
        <input id="requester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${personalTraining.requester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        申请日期
    </div>
    <div class="col-md-4">
        <input id="requestDate" value="${personalTraining.requestDate}" readonly type="date" class="validate[required,maxSize[100]] form-control"/>
    </div>
    <div class="col-md-2 tar">
        培训类别
    </div>
    <div class="col-md-4">
        <select  id="trainingType" disabled/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        培训日期
    </div>
    <div class="col-md-4">
        <input id="trainingStartDate" type="date" readonly
               value="${personalTraining.trainingDate}"/>
    </div>
    <div class="col-md-2 tar">
        培训周期(天)
    </div>
    <div class="col-md-4">
        <input id="trainingDays" value="${personalTraining.trainingDays}" readonly/>
    </div>
</div>

<div class="form-row">

    <div class="col-md-2 tar">
        培训地点
    </div>
    <div class="col-md-4">
        <input id="trainingPlace" value="${personalTraining.trainingPlace}" readonly/>
    </div>
    <div class="col-md-2 tar">
        主办方
    </div>
    <div class="col-md-4">
        <input id="trainingOrganizers" readonly value="${personalTraining.trainingOrganizers}" />
    </div>
</div>


<div class="form-row">
    <div class="col-md-2 tar">
        项目
    </div>
    <div class="col-md-4">
        <input id="trainingProject" readonly value="${personalTraining.trainingProject}" />
    </div>
    <div class="col-md-2 tar">
        培训项目名称
    </div>
    <div class="col-md-4">
        <input id="trainingProjectName" readonly value="${personalTraining.trainingProjectName}" />
    </div>
</div>

<div class="form-row">
    <div class="col-md-2 tar">
        培训人数
    </div>
    <div class="col-md-4">
        <input id="trainingPeopleNumber" readonly value="${personalTraining.trainingPeopleNumber}" />
    </div>
    <div class="col-md-2 tar">
        费用(天/人)
    </div>
    <div class="col-md-4">
        <input id="trainingFee" readonly value="${personalTraining.trainingFee}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        培训目的
    </div>
    <div class="col-md-10">
        <input id="trainingPurpose" readonly value="${personalTraining.trainingPurpose}" />
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/training/printPersonalTraining?id=${personalTraining.id}">


<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'trainingType','${personalTraining.trainingType}');
        });
    })




</script>

