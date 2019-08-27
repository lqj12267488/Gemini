<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/3
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button onclick="back()" class="btn btn-default btn-clean">返回</button>
<input id="internship" hidden value="${internshipChangeLog.internshipId}">
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="f_studentId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.studentIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
       班级
    </div>
    <div class="col-md-9">
        <input id="f_classId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.classIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="f_departmentsId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.departmentsIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="f_majorCode" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.majorCodeShow}"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        性别
    </div>
    <div class="col-md-9">
        <input id="sex" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.sex}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        身份证号
    </div>
    <div class="col-md-9">
        <input id="f_idcard" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.idcard}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        原实习单位
    </div>
    <div class="col-md-9">
        <input id="f_oldInternshipUnitId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.oldInternshipUnitIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        新实习单位
    </div>
    <div class="col-md-9">
        <input id="newInternshipUnitId" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.newInternshipUnitIdShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        变动原因
    </div>
    <div class="col-md-9">
        <input id="f_reason" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.reason}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        实习岗位
    </div>
    <div class="col-md-9">
        <input id="f_internshipPositions" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.internshipPositions}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        上岗时间
    </div>
    <div class="col-md-9">
        <input id="f_postsTime"  readonly="readonly"
               type="date" class="validate[required,maxSize[100]] form-control"
               value="${internshipManage.postsTime}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        地区
    </div>
    <div class="col-md-9">
        <input id="f_area" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.area}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        实习形式
    </div>
    <div class="col-md-9">
        <input id="f_internshipType" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.internshipTypeShow}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        专业对口否
    </div>
    <div class="col-md-9">
        <input id="f_majorMatchFlag" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.majorMatchFlagShow}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        工资
    </div>
    <div class="col-md-9">
        <input id="f_salary" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.salaryShow}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        实习评分
    </div>
    <div class="col-md-9">
        <input id="f_internshipScore" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.internshipScore}" />
    </div>
</div>
<div class="form-row">
    <div class="col-md-3  tar">
        实习评价
    </div>
    <div class="col-md-9">
        <input id="f_internshipEvaluation" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.internshipEvaluationShow}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生电话
    </div>
    <div class="col-md-9">
        <input id="f_tel" type="text" readonly="readonly"
               class="validate[required,maxSize[20]] form-control"
               value="${internshipManage.tel}"/>
    </div>
</div>
<script>
    function back() {
        $("#right").load("<%=request.getContextPath()%>/internships/internshipManageList1");
    }
</script>