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
        <input id="f_requestDate" type="text" class="validate[required,maxSize[100]] form-control"
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
        <input  id="f_requestDays" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${leave.requestDays}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假类型
    </div>
    <div class="col-md-9">
        <input  id="f_leaveType" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                 value="${leave.leaveType}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假原因
    </div>
    <div class="col-md-9">
        <textarea id="f_reason" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${leave.reason}">${leave.reason}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/leave/printLeaves?id=${leave.id}">

<script>


</script>

