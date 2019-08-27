<%--协同办公-校外人员进校参加活动管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/11
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/schoolActivity/printSchoolActivity?id=${schoolActivity.id}">
<div class="form-row">
    <div class="col-md-2 tar">
        活动名称
    </div>
    <div class="col-md-10">
        <input id="activityName" type="text" readonly
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityName}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        活动内容
    </div>
    <div class="col-md-10">
        <input id="activityContent" type="text" readonly
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityContent}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        活动地点
    </div>
    <div class="col-md-10">
        <input id="activityPlace" type="text" readonly
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.activityPlace}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        开始时间
    </div>
    <div class="col-md-4">
        <input id="startTime" type="datetime-local" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.startTime}"/>
    </div>
    <div class="col-md-2 tar">
        结束时间
    </div>
    <div class="col-md-4">
        <input id="endTime" type="datetime-local" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.endTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        进校人数
    </div>
    <div class="col-md-4">
        <input id="peopleNumber" type="text" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.peopleNumber}"/>
    </div>
    <div class="col-md-2 tar">
        车辆数量
    </div>
    <div class="col-md-4">
        <input id="carNumber" type="text" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.carNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        组织部门
    </div>
    <div class="col-md-10">
        <input id="requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        负责人
    </div>
    <div class="col-md-10">
        <input id="requester" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        申请时间
    </div>
    <div class="col-md-10">
        <input id="requestTime" type="datetime-local" readonly
               class="validate[required,maxSize[100]] form-control"
               value="${schoolActivity.requestTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        联系电话
    </div>
    <div class="col-md-10">
        <input id="contactPhone" type="text" readonly
               class="validate[required,maxSize[10]] form-control"
               value="${schoolActivity.contactPhone}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        安全措施
    </div>
    <div class="col-md-10">
                        <textarea id="safetyStep" style="height: 100px" readonly
                                  class="validate[required,maxSize[100]] form-control">${schoolActivity.safetyStep}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-2 tar">
        备注
    </div>
    <div class="col-md-10">
                        <textarea id="remark" readonly
                                  class="validate[required,maxSize[100]] form-control">${schoolActivity.remark}</textarea>
    </div>
</div>
<input id="id" hidden value="${schoolActivity.id}">