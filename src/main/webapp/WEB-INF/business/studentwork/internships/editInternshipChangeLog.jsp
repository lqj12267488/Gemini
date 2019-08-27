<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/3
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="internshipId" hidden value="${internshipChangeLog.internshipId}">
<input id="studentId" hidden value="${internshipChangeLog.studentId}">
<input id="classId" hidden value="${internshipChangeLog.classId}">
<input id="oldInternshipUnitId" hidden value="${internshipChangeLog.internshipUnitId}">
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
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>新实习单位
                    </div>
                    <div class="col-md-9">
                        <select id="newInternshipUnitId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 变动原因
                    </div>
                    <div class="col-md-9">
                        <input id="f_reason" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipChangeLog.reason}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 变动时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_alertTime" type="date" class="validate[required,maxSize[100]] form-control"
                               value="${internshipChangeLog.alertTime}" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="add()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="newInternshipUnitIdShow" hidden value="${internshipChangeLog.newInternshipUnitId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 and internship_unit_id != '${internshipChangeLog.internshipUnitId}' ",
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
        if ($("#f_alertTime").val() == "" || $("#f_alertTime").val() == "0" || $("#f_alertTime").val() == undefined){
            swal({
                title: "请填写变动时间！",
                type: "info"
            });
            return;
        }
        showSaveLoading();

        $.post("<%=request.getContextPath()%>/internshipChangeLog/saveInternshipChangeLog", {
            logId: $("#internshipChangeLogId").val(),
            internshipId:$("#internshipId").val(),
            studentId: $("#studentId").val(),
            classId: $("#classId").val(),
            oldInternshipUnitId:$("#oldInternshipUnitId").val(),
            newInternshipUnitId:$("#newInternshipUnitId option:selected").val(),
            reason:$("#f_reason").val(),
            alertTime:$("#f_alertTime").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#internshipManageGrid').DataTable().ajax.reload();

            }
        })
    }

</script>


