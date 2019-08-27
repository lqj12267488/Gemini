<%--学校车辆外出使用管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/6/28 0028
  Time: 下午 4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/schoolCar/printSchoolCar?id=${schoolCar.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="s_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requestDept}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="s_requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requester}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="s_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.requestDate}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        开始时间
    </div>
    <div class="col-md-9">
        <input id="s_startTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.startTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        结束时间
    </div>
    <div class="col-md-9">
        <input id="s_endTime" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.endTime}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        始发地
    </div>
    <div class="col-md-9">
        <input id="s_startPlace" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.startPlace}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        目的地
    </div>
    <div class="col-md-9">
        <input id="s_endPlace" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.endPlace}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        使用车型
    </div>
    <div class="col-md-9">
        <input id="s_carType" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolCar.carTypeShow}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        申请事由
    </div>
    <div class="col-md-9">
                        <textarea id="s_reason"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${schoolCar.reason}</textarea>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        人数
    </div>
    <div class="col-md-9">
        <input id="s_peopleNum" type="text"
               class="validate[required,maxSize[10]] form-control"
               value="${schoolCar.peopleNum}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="s_remark"
                                  class="validate[required,maxSize[100]] form-control" readonly="readonly">${schoolCar.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${hotelStay.id}">
