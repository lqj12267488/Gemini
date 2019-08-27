<%--资产报废管理办理页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="printFunds" hidden value="<%=request.getContextPath()%>/slowExamination/printSlowExamination?id=${slowExamination.id}">
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        系部
    </div>
    <div class="col-md-9">
        <input id="c_requestDept" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${slowExamination.requestDept}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        班级
    </div>
    <div class="col-md-9">
        <input id="c_classId" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${slowExamination.classId}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        姓名
    </div>
    <div class="col-md-9">
        <input id="c_manager" type="text"
               class="validate[required,maxSize[100]] form-control"
               value="${slowExamination.manager}" readonly="readonly"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        缓考科目
    </div>
    <div class="col-md-9">
        <select id="c_course" class="js-example-basic-single" disabled></select>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        缓考原因
    </div>
    <div class="col-md-9">
                        <textarea id="c_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="c_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${slowExamination.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="c_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.remark}</textarea>
    </div>
</div>

<input id="c_courseId" type="hidden" value="${slowExamination.courseId}">
<script>
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: " where 1=1 ",
            },
            function (data) {
                addOption(data, 'c_course',$("#c_courseId").val());
            })
    })
</script>
<input id="id" hidden value="${slowExamination.id}">