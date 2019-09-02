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
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentProve.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentProve.studentId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" value="${studentProve.studentNumber}" />
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentProve.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${studentProve.classId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        证明原因
    </div>
    <div class="col-md-9">
        <input  id="f_proveReason" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${studentProve.proveReason}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        证明接收单位
    </div>
    <div class="col-md-9">
        <input  id="f_receiveCompany" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                value="${studentProve.receiveCompany}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        请假原因
    </div>
    <div class="col-md-9">
        <textarea id="f_reason" readonly="readonly" class="validate[required,maxSize[100]] form-control"
                  value="${studentProve.proveReason}">${studentProve.proveReason}</textarea>
    </div>
</div>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/studentProve/printStudentProve?id=${studentProve.id}">

<script>


</script>

