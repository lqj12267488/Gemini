<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 17:28
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
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教学计划
                    </div>
                    <div class="col-md-9">
                        <select id="planId" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">导入</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closeView()">关闭</button>
        </div>
    </div>
    <input id="scoreExamId" value="${scoreExamId}" type="hidden" >
</div>

<script>
    $(document).ready(function () {
        //获取教学计划列表
        $.get("<%=request.getContextPath()%>/scoreClass/getTableDict",{
                distinct:" distinct ",
                id: " s.PLAN_ID",
                text: " s.PLAN_NAME ",
                tableName: "T_JW_COURSEPLAN s,T_JW_COURSEPLAN_SIGN t",
                where:"where t.plan_id=s.plan_id"
            },
            function (data) {
                addOption(data, "planId");
            });
    })
    function save() {
        if ($("#planId").val() == "" || $("#planId").val() == undefined) {
            swal({title: "请选择教学计划！",type: "info"});
            return;
        }
        swal({
            title: "教学计划导入无法导入未签课课程，确认导入？",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "green",
            confirmButtonText: "确认",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/scoreCourse/import", {
                planId:$("#planId").val(),
                scoreExamId:$("#scoreExamId").val(),
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal('hide');
                listTable.ajax.reload();
            });
        })
    }
</script>

