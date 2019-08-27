<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/9
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="internshipChangeLogId" hidden value="${internshipChangeLog.logId}">
        </div>
        <div class="modal-body clearfix">
            <div class="form-row">
                <div class="col-md-3 tar">
                    学号姓名
                </div>
                <div class="col-md-9">
                    <input id="f_student" type="text" readonly="readonly"
                           class="validate[required,maxSize[20]] form-control"
                           value="${internshipChangeLog.studentId}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    班级
                </div>
                <div class="col-md-9">
                    <input id="f_classId" type="text" readonly="readonly"
                           class="validate[required,maxSize[20]] form-control"
                           value="${internshipChangeLog.classId}"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    原实习单位
                </div>
                <div class="col-md-9">
                    <input id="f_oldInternshipUnitId" type="text" readonly="readonly"
                           class="validate[required,maxSize[20]] form-control"
                           value="${internshipChangeLog.oldInternshipUnitId}"/>
                </div>
            </div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        新实习单位
                    </div>
                    <div class="col-md-9">
                        <select id="newInternshipUnitId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        变动原因
                    </div>
                    <div class="col-md-9">
                        <input id="f_reason" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipChangeLog.reason}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="newInternshipUnitIdShow" hidden value="${internshipChangeLog.newInternshipUnitId}">
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " student_id",
                text: "name",
                tableName: "T_XG_STUDENT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by student_id "
            },
            function (data) {
                addOption(data, "studentId", $("#studentIdShow").val());
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " class_id",
                text: " class_name ",
                tableName: "T_XG_CLASS",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "classId", $("#classIdShow").val());
            })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "oldInternshipUnitId", $("#oldInternshipUnitIdShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "newInternshipUnitId", $("#newInternshipUnitIdShow").val());
            });

    });


    function add() {
        if ($("#newInternshipUnitId option:selected").val() == "") {
            swal({
                title: "请填写新实习单位！",
                type: "info"
            });
            return;
        }
        if ($("#f_reason").val() == "" || $("#f_reason").val() == "0" || $("#f_reason").val() == undefined){
            swal({
                title: "请填写变动原因！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/internshipChangeLog/saveInternshipChangeLog", {
            logId: $("#internshipChangeLogId").val(),
            newInternshipUnitId:$("#newInternshipUnitId option:selected").val(),
            reason:$("#f_reason").val(),

        }, function (msg) {
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#internshipChangeLogGrid').DataTable().ajax.reload();

            }
        })
    }

</script>


