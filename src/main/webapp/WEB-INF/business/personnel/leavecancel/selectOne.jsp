<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/27
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<div class="form-row">
    <div class="col-md-3 tar">
        申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假开始时间
    </div>
    <div class="col-md-9">
        <input id="f_startTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leave.startTime}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假结束时间
    </div>
    <div class="col-md-9">
        <input id="f_endTime" type="date" class="validate[required,maxSize[100]] form-control"
               value="${leave.endTime}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假天数
    </div>
    <div class="col-md-9">
        <input id="f_requestDays" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.requestDays}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假类型
    </div>
    <div class="col-md-9">
        <input id="f_leaveType" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.leaveType}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假原因
    </div>
    <div class="col-md-9">
        <textarea id="f_reason" readonly="readonly"
                  class="validate[required,maxSize[100]] form-control"
                  value="${leave.reason}">${leave.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假部门
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDept" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.cancelRequestDept}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假人
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequester" type="text" readonly="readonly"
               class="validate[required,maxSize[100]] form-control"
               value="${leave.cancelRequester}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请销假日期
    </div>
    <div class="col-md-9">
        <input id="x_cancelRequestDate" value="${leave.cancelRequestDate}" type="datetime-local" disabled/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假开始时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelStartTime" type="date" disabled value="${leave.cancelStartTime}"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假结束时间
    </div>
    <div class="col-md-9">
        <input id="x_cancelEndTime" readonly value="${leave.cancelEndTime}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        实际请假天数
    </div>
    <div class="col-md-9">
        <input id="x_realDays" readonly value="${leave.realDays}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        销假原因
    </div>
    <div class="col-md-9">
        <textarea id="x_cancelReason" readonly >${leave.cancelReason}</textarea>
    </div>
</div>

<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/leaveCancel/selectAll");
    }
</script>
