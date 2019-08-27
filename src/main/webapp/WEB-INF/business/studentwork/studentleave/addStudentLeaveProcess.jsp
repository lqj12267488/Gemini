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
        学籍号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" value="${leave.studentNumber}" />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="departmentsId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.departmentsId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级名称
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.classId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.studentId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="sex" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.sex}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        代申请部门
    </div>
    <div class="col-md-9">
        <input id="dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${leave.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        代申请人
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
        假条类型
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
<input id="printFunds" hidden value="<%=request.getContextPath()%>/studentLeave/printLeaves?id=${leave.id}">

<script>


</script>

