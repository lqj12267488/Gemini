<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/10/30
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 600px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="form-row block" style="overflow-y:auto;">
                <div class="form-row">
                    <select id="repairManEdit"></select>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveRepairMan()">分配</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
            </button>
        </div>
    </div>
</div>

<script>
    $(function () {
        debugger;
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"PERSON_ID",
            text: "FUNC_GET_USERNAME(PERSON_ID) || '---' || FUNC_GET_DEPTNAME(DEPT_ID)",
            tableName: "T_ZW_REPAIRMAN",
            where: " WHERE 1 = 1",
            orderby: " ORDER BY CREATE_TIME ASC"
        },function (data) {
            addOption(data, "repairManEdit",'${repair.repairmanID}');
        })
    })

    function saveRepairMan() {
        if ($("#repairManEdit").val() != "" && $("#repairManEdit").val() != undefined) {
            swal({
                title: "您确定要分配此任务吗?",
                text: "分配后将无法重新分配，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                cancelButtonText: "取消",
                confirmButtonColor: "green",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function () {
                $.get("<%=request.getContextPath()%>/repair/disMan?repairID=${repair.repairID}&repairmanID="+$("#repairManEdit").val(),
                    function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $("#dialog").modal("hide");
                            $('#repairTable').DataTable().ajax.reload();
                        }
                    })
            });
        }else {
            swal({
                title: "请选择维修员!",
                type: "info"
            });
        }
    }
</script>
