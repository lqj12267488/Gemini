<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/21
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css"> textarea {
        resize: none;
    }</style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">人才培养驳回</span></div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar"><span class="iconBtx">*</span>原因</div>
                    <div class="col-md-9">
                        <textarea id="trainplan" style="height: 80px;"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">确定</button>
        </div>
    </div>
</div>
<input id="id" hidden value="${talentTrainId}"/>
<script> $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
// $(document).ready(function () {
// });

//保存驳回
function save() {
    var trainPlan = $("#trainplan").val();
    if (trainPlan == "" || trainPlan == undefined || trainPlan == null) {
        swal({
            title: "请填写原因",
            type: "info"
        });
        return;
    }
    showSaveLoading();
    $.post("<%=request.getContextPath()%>/major/saveTalentAgainst", {
        id:$("#id").val(),
        requestFlag:"3",//3为审批未通过
        trainPlan: trainPlan
    }, function (msg) {
        hideSaveLoading();
        swal({
            title: "驳回成功",
            type: "success"
        });
        $("#dialog").modal('hide');
        $('#table').DataTable().ajax.reload();
    })
}
</script>