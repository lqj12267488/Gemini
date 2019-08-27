<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/2
  Time: 11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="internshipUnitId" hidden value="${internshipExt.internshipUnitId}">
<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<div class="form-row">
    <div class="col-md-3 tar">
        单位名称
    </div>
    <div class="col-md-9">
        <input id="internshipUnitIdShow" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.internshipUnitIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="f_departmentsId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.departmentsId}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        接收实习生人数
    </div>
    <div class="col-md-9">
        <input id="f_receiveNumber" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.receiveNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        补贴工资
    </div>
    <div class="col-md-9">
        <input id="f_salary" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.salary}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        所在地区
    </div>
    <div class="col-md-9">
        <input id="f_area" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.area}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        地址
    </div>
    <div class="col-md-9">
        <input id="f_address" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.address}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        联系人
    </div>
    <div class="col-md-9">
        <input id="f_contactPerson" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.contactPerson}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        联系电话
    </div>
    <div class="col-md-9">
        <input id="f_contactNumber" readonly="readonly" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipExt.contactNumber}"/>
    </div>
</div>
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/internships/internshipExtList?internshipUnitId=" +$("#internshipUnitId").val());
    }
</script>
