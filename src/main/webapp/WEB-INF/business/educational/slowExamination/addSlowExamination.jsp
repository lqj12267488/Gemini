<%--资产报废管理待办修改页面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        系部
    </div>
    <div class="col-md-9">
        <input id="d_requestDept" type="text"
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
        <input id="d_classId" type="text"
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
        <input id="d_manager" type="text"
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
        <select id="d_course" class="js-example-basic-single" readonly></select>
    </div>
</div>

<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        缓考原因
    </div>
    <div class="col-md-9">
                        <textarea id="d_reason" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.reason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>
        申请时间
    </div>
    <div class="col-md-9">
        <input id="d_requestDate" type="datetime-local"
               class="validate[required,maxSize[100]] form-control"
               value="${slowExamination.requestDate}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        备注
    </div>
    <div class="col-md-9">
                        <textarea id="d_remark" maxlength="330" placeholder="最多输入330个字"
                                  class="validate[required,maxSize[100]] form-control">${slowExamination.remark}</textarea>
    </div>
</div>
<input type="hidden" id="d_Id" value="${slowExamination.id}">
<input id="workflowCode" hidden value="T_JW_SLOW_EXAMINATION01">
<input id="majorCode" type="hidden" value="${slowExamination.majorId}">
<input id="courseId" type="hidden" value="${slowExamination.courseId}">
<script>
    $(document).ready(function () {
        var majorCode=$("#majorCode").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: " where 1=1 and MAJOR_CODE ='" + majorCode + "' ",
            },
            function (data) {
                addOption(data, 'd_course',$("#courseId").val());
            })
    })
    function save(){
        var date = $("#d_requestDate").val();
        date = date.replace('T', '');
        if ($("#d_reason").val() == "" || $("#d_reason").val() == "0" || $("#d_reason").val() == undefined) {
            swal({
                title: "请填写缓考原因!",
                type: "info"
            });
            return;
        }
        if ($("#d_requestDate").val() == "" || $("#d_requestDate").val() == "0" || $("#d_reason").val() == undefined) {
            swal({
                title: "请填写申请时间!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/slowExamination/saveSlowExamination", {
            id: $("#d_Id").val(),
            courseId: $("#d_course option:selected").val(),
            reason: $("#d_reason").val(),
            remark: $("#d_remark").val(),
            requestDate: date
        }, function (msg) {
            if (msg.status == 1) {
                $("#dialog").modal('hide');
                $('#softInstallGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }
</script>