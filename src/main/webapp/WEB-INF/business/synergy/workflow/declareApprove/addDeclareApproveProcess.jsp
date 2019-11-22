<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="form-row">
    <div class="col-md-2 tar">
        申请人
    </div>
    <div class="col-md-4">
        <input id="f_requestEr" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${declareApprove.requester}" readonly="readonly"/>
    </div>
    <div class="col-md-2 tar">
        申请部门
    </div>
    <div class="col-md-4">
        <input id="f_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${declareApprove.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        申请时间
    </div>
    <div class="col-md-4">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${declareApprove.requestDate}" readonly="readonly"/>
    </div>
    <div class="col-md-2 tar">
        姓名
    </div>
    <div class="col-md-4">
        <input id="name" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.name}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        性别
    </div>
    <div class="col-md-4">
        <input id="sex" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.sex}"/>
    </div>
    <div class="col-md-2 tar">
        出生日期
    </div>
    <div class="col-md-4">
        <input id="birthday" type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.birthday}"/>
    </div>
</div>

<div class="form-row">

    <div class="col-md-2 tar">
        入职时间
    </div>
    <div class="col-md-4">
        <input id="entryTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.entryTime}"/>
    </div>
    <div class="col-md-2 tar">
        工作部门
    </div>
    <div class="col-md-4">
        <input id="workDept" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.workDept}"/>
    </div>
</div>

<div class="form-row">

    <div class="col-md-2 tar">
        任职时间
    </div>
    <div class="col-md-4">
        <input id="appointmentTime" type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.appointmentTime}"/>
    </div>
    <div class="col-md-2 tar">
        拟申报职称层次
    </div>
    <div class="col-md-4">
        <input id="appliedLevel" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.appliedLevel}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-2 tar">
        学位
    </div>
    <div class="col-md-4">
        <input id="academicDegree" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.academicDegree}"/>
    </div>
    <div class="col-md-2 tar">
        学历
    </div>
    <div class="col-md-4">
        <input id="educationalLevel" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.educationalLevel}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        毕业学校
    </div>
    <div class="col-md-4">
        <input id="school"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.school}"/>
    </div>
    <div class="col-md-2 tar">
        工作年限
    </div>
    <div class="col-md-4">
        <input id="workingSeniority"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.workingSeniority}"/>
    </div>

</div>


<div class="form-row">
    <div class="col-md-2 tar">
        职称
    </div>
    <div class="col-md-4">
        <input id="positionalTitles"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.positionalTitles}"/>
    </div>
    <div class="col-md-2 tar">
        现任职务
    </div>
    <div class="col-md-4">
        <input id="presentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.presentPost}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        聘任时间
    </div>
    <div class="col-md-4">
        <input id="engageTime"  type="date" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.engageTime}"/>
    </div>
    <div class="col-md-2 tar">
        现任岗位
    </div>
    <div class="col-md-4">
        <input id="incumbentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.incumbentPost}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        聘任岗位
    </div>
    <div class="col-md-4">
        <input id="appointmentPost"  type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${declareApprove.appointmentPost}"/>
    </div>
    <div class="col-md-2 tar">
        申请专业技术（职称）评审的基本条件概述
    </div>
    <div class="col-md-4">
        <textarea id="representativeAchievements"  type="text"
                  class="validate[required,maxSize[20]] form-control" readonly="readonly">${declareApprove.representativeAchievements}</textarea>
    </div>

</div>
<input id="h_id" hidden value="${declareApprove.id}">
<script>

</script>
