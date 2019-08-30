<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reception.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${reception.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${reception.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        接待时间
    </div>
    <div class="col-md-9">
        <input id="f_receptionTime" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${reception.receptionTime}" readonly="readonly"/>
    </div>

</div>

<div class="form-row">
    <div class="col-md-3 tar">
        接待事由
    </div>
    <div class="col-md-9">
        <input id="f_receptionReason" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.receptionReason}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        联系电话
    </div>
    <div class="col-md-9">
        <input id="f_tel" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.tel}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        来访主要领导及职务
    </div>
    <div class="col-md-9">
        <input id="f_visitLeader" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.visitLeader}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        来访人数
    </div>
    <div class="col-md-9">
        <input id="f_visitNumber" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.visitNumber}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        接待地点
    </div>
    <div class="col-md-9">
        <input id="f_receptionPlace" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.receptionPlace}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        拟陪同人员
    </div>
    <div class="col-md-9">
        <input id="f_entourage" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.entourageShow}"></input>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        是否需要用车
    </div>
    <div class="col-md-9">
        <input id="f_isNeedVehicle" readonly="readonly" class="validate[required,maxSize[100]] form-control"
               value="${reception.isNeedVehicleShow}"/>
    </div>
</div>

<input id="printFunds" hidden value="<%=request.getContextPath()%>/reception/printReception?id=${reception.id}">
<script>


</script>
