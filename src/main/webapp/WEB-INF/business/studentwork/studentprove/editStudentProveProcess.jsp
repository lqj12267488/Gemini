<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:include page="../../../../include.jsp"/>--%>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<input type="hidden" id="studentProveid" value="${studentProve.id}">
<div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
<div class="form-row">
    <div class="col-md-3 tar">
        申请时间
    </div>
    <div class="col-md-9">
        <input id="f_requestDate" value="${studentProve.requestDate}" readonly="readonly"
               type="datetime-local" class="validate[required,maxSize[100]] form-control"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学生姓名
    </div>
    <div class="col-md-9">
        <select id="studentId" disabled="disabled"
                class="validate[required,maxSize[100]] form-control"></select>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        学号
    </div>
    <div class="col-md-9">
        <input id="studentNumber" type="text" readonly="readonly" value="${studentProve.studentNumber}"/>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        就读专业
    </div>
    <div class="col-md-9">
        <select id="majorCodeId" type="text" disabled="disabled" readonly
                class="validate[required,maxSize[100]] form-control"></select>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        班级
    </div>
    <div class="col-md-9">
        <select id="classIdId" type="text" disabled="disabled"
                class="validate[required,maxSize[100]] form-control"></select>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>请假原因
    </div>
    <div class="col-md-9">
        <textarea id="f_proveReason" maxlength="300" placeholder="最多输入300个字"
                  style="resize:none;">${studentProve.proveReason}</textarea>
    </div>
</div>
<div class="form-row">
    <div class="col-md-3 tar">
        <span class="iconBtx">*</span>证明接收单位
    </div>
    <div class="col-md-9">
        <input id="f_receiveCompany" placeholder="请填写证明的最终接收单位，如：新疆现代职业技术学院学生处"
               value="${studentProve.receiveCompany}"/>
    </div>
</div>
<input id="workflowCode" hidden>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                addOption(data, "majorCodeId", '${studentProve.majorCode}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " name ",
                tableName: "t_xg_student"
            },
            function (data) {
                addOption(data, "studentId", '${studentProve.studentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: "t_xg_class"
            },
            function (data) {
                addOption(data, "classIdId",'${studentProve.classId}');
            });
    })


    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#f_proveReason").val() == "" || $("#f_proveReason").val() == undefined) {
            swal({
                title: "请填写证明原因",
                type: "info"
            });
            return;
        }
        if ($("#f_receiveCompany").val() == "" || $("#f_receiveCompany").val() == undefined) {
            swal({
                title: "请填写证明接收单位",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/studentProve/saveStudentProve", {
            id: $("#studentProveid").val(),
            requestDate: date,
            proveReason: $("#f_proveReason").val(),
            receiveCompany: $("#f_receiveCompany").val(),
            studentId: $("#studentId option:selected").val(),
            classId: $("#classIdId option:selected").val(),
            majorCode: $("#majorCodeId option:selected").val(),
            studentNumber: $("#studentNumber").val()
        }, function (msg) {
            if (msg.status == 1) {
                $("#dialog").modal('hide');
                $('#studentProveGrid').DataTable().ajax.reload();
            }
        })
        return true;
    }

</script>


