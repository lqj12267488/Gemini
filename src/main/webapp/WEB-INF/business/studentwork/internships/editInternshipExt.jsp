<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/1
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="internshipUnitId" hidden value="${internshipExt.internshipUnitId}">
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
            <input id="internshipExtId" hidden value="${internshipExt.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接收实习生人数
                    </div>
                    <div class="col-md-9">
                        <input id="f_receiveNumber" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${internshipExt.receiveNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 补贴工资
                    </div>
                    <div class="col-md-9">
                        <select id="salary"/>
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
<input id="departmentsIdShow" hidden value="${internshipExt.departmentsId}">
<input id="internshipUnitIdShow" hidden value="${internshipExt.internshipUnitId}">
<input id="salaryShow" hidden value="${internshipExt.salary}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsId", $("#departmentsIdShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " internship_unit_id",
                text: " internship_unit_name ",
                tableName: "T_XG_INTERNSHIP_UNIT",
                where: " WHERE VALID_FLAG = 1 ",
                orderby: " order by create_time "
            },
            function (data) {
                addOption(data, "internshipUnitId", $("#internshipUnitIdShow").val());
            });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GZSRSP", function (data) {
            addOption(data, 'salary', $("#salaryShow").val());
        });
    });


    function add() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#departmentsId option:selected").val() == "") {
             swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ( $("#f_receiveNumber").val() == "" || $("#f_receiveNumber").val() == "0" || $("#f_receiveNumber").val() == undefined){
             swal({
                title: "请填写接收实习人数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#f_receiveNumber").val())){
            swal({
                title: "接收实习人数填写错误，请填写正整数！",
                type: "info"
            });
            return;
        }
        if ($("#salary option:selected").val() == "") {
             swal({
                title: "请填写实习工资！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/internshipExt/saveInternshipExt", {
            id: $("#internshipExtId").val(),
            internshipUnitId:$("#internshipUnitId").val(),
            departmentsId: $("#departmentsId option:selected").val(),
            receiveNumber:$("#f_receiveNumber").val(),
            salary: $("#salary option:selected").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                $('#internshipExtIdGrid').DataTable().ajax.reload();

            }
        })
    }

</script>

