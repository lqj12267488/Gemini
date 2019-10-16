<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    select {
        -webkit-appearance: none;
        -webkit-tap-highlight-color: #fff;
        outline: 0;
    }

</style>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="grantmanagementid" hidden value="${grantmanagement.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        申请日期
                    </div>
                    <div class="col-md-9">
                        <input id="f_requestDate" type="datetime-local" readonly="readonly"
                               class="validate[required,maxSize[100]] form-control"
                               value="${grantmanagement.requestDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>奖助学金所属学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"
                                class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>奖助学金名称
                    </div>
                    <div class="col-md-9">
                        <select id="grantManagementNameSel"
                                class="validate[required,maxSize[100]] form-control"></select>
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
                        性别
                    </div>
                    <div class="col-md-9">
                        <select id="sexSel" disabled="disabled"
                                class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsIdSel" type="text" disabled="disabled" readonly
                                class="validate[required,maxSize[100]] form-control"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
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

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
            },
            function (data) {
                addOption(data, "departmentsIdSel", '${grantmanagement.departmentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_code",
                text: " major_name ",
                tableName: "t_xg_major"
            },
            function (data) {
                addOption(data, "majorCodeId", '${grantmanagement.majorCode}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " student_id",
                text: " name ",
                tableName: "t_xg_student",
            },
            function (data) {
                addOption(data, "studentId", '${grantmanagement.studentId}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " class_id",
                text: " class_name ",
                tableName: "t_xg_class"
            },
            function (data) {
                addOption(data, "classIdId", '${grantmanagement.classId}');
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, "sexSel", '${grantmanagement.sex}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term', '${grantmanagement.grantManagementTerm}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZXJMC", function (data) {
            addOption(data, 'grantManagementNameSel', '${grantmanagement.grantManagementName}');
        });
    })

    function save() {
        var date = $("#f_requestDate").val();
        date = date.replace('T', '');
        if ($("#term").val() == "" || $("#term").val() == undefined) {
            swal({
                title: "请选择奖助学金所属学期",
                type: "info"
            });
            return;
        }
        if ($("#grantManagementNameSel").val() == "" || $("#grantManagementNameSel").val() == undefined) {
            swal({
                title: "请选择奖助学金名称",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/grantmanagement/saveGrantManagement", {
            id: $("#grantmanagementid").val(),
            requestDate: date,
            departmentId:$("#departmentsIdSel option:selected").val(),
            studentId: $("#studentId option:selected").val(),
            classId: $("#classIdId option:selected").val(),
            majorCode: $("#majorCodeId option:selected").val(),
            studentNumber: $("#studentNumber").val(),
            grantManagementName:$("#grantManagementNameSel").val(),
            grantManagementTerm:$("#term").val(),
            sex:$("#sexSel option:selected").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#grantManagementGrid').DataTable().ajax.reload();
            }
        })
    }


</script>

