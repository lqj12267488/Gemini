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
        <input id="s_dept" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请人
    </div>
    <div class="col-md-9">
        <input id="s_jbr" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.requester}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="s_requestDate" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.requestDate}" readonly="readonly"/>
    </div>

</div>
<div class="form-row">
    <div class="col-md-3 tar">
        系部
    </div>
    <div class="col-md-9">
        <input id="s_departmentsId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.departmentsId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        专业
    </div>
    <div class="col-md-9">
        <input id="s_majorCode" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.majorCode}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <input id="s_classId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.classId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <input id="s_studentId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.studentId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="s_studentNumber" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.studentNumber}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        科目
    </div>
    <div class="col-md-9">
        <input id="s_courseId" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.courseId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学期
    </div>
    <div class="col-md-9">
        <input id="s_term" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.term}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        原成绩
    </div>
    <div class="col-md-9">
        <input id="s_originalScore" type="text" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.originalScore}" readonly="readonly"/>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        考试状态
    </div>
    <div class="col-md-9">
        <input id="s_examinationStatus" type="type" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.examinationStatus}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        更改后成绩
    </div>
    <div class="col-md-9">
            <input id="f_score" type="text" class="validate[required,maxSize[100]] form-control"
                   value="${scoreChange.score}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        变更原因
    </div>
    <div class="col-md-9">
        <input id="s_reason" type="type" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.reason}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        变更时间
    </div>
    <div class="col-md-9">
        <input id="s_time" type="datetime-local" class="validate[required,maxSize[100]] form-control"
               value="${scoreChange.time}" readonly="readonly"/>
    </div>
</div>

<input id="printFunds" hidden value="<%=request.getContextPath()%>/scoreChange/printScoreChange?id=${scoreChange.id}">
<script>
</script>
