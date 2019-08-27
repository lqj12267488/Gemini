<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/14
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<div class="form-row">
    <div class="col-md-3 tar">
        单位名称
    </div>
    <div class="col-md-9">
        <input id="internshipUnitIdShow" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.internshipUnitIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="f_departmentsIdShow" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.departmentsIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        接收实习生人数
    </div>
    <div class="col-md-9">
        <input id="f_receiveNumber" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.receiveNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        补贴工资
    </div>
    <div class="col-md-9">
        <input id="f_salaryShow" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.salaryShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        所在地区
    </div>
    <div class="col-md-9">
        <input id="f_area" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.area}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        地址
    </div>
    <div class="col-md-9">
        <input id="f_address" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.address}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        联系人
    </div>
    <div class="col-md-9">
        <input id="f_contactPerson" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.contactPerson}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        联系电话
    </div>
    <div class="col-md-9">
        <input id="f_contactNumber" readonly="readonly" type="text"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.contactNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        法人代表
    </div>
    <div class="col-md-9">
        <input id="f_legalPerson" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.legalPerson}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        企业性质
    </div>
    <div class="col-md-9">
        <input id="f_enterpriseNature" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.enterpriseNatureShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        注册资金
    </div>
    <div class="col-md-9">
        <input id="f_registeredCapital" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.registeredCapital}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        企业员工数
    </div>
    <div class="col-md-9">
        <input id="f_enterprisePersonNumber" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.enterprisePersonNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        合作时间
    </div>
    <div class="col-md-9">
        <input id="f_cooperationTime" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.cooperationTimeShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        实习生是否留用
    </div>
    <div class="col-md-9">
        <input id="f_internshipWhetherRetention" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.internshipWhetherRetentionShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        企业规模
    </div>
    <div class="col-md-9">
        <input id="f_enterpriseScale" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internships.enterpriseScaleShow}"/>
    </div>
</div>
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/internships/request");
    }
</script>
