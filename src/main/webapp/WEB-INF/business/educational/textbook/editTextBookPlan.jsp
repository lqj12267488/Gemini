<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${textBookPlan.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>计划名称
                    </div>
                    <div class="col-md-9">
                        <input id="planName" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[8]] form-control" value="${textBookPlan.planName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>计划开始日期
                    </div>
                    <div class="col-md-9">
                        <input id="startTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${textBookPlan.startTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>计划结束日期
                    </div>
                    <div class="col-md-9">
                        <input id="endTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${textBookPlan.endTime}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveTextBookPlan()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term', '${textBookPlan.termShow}');
        });
    })
    function saveTextBookPlan() {
        var planId=$("#id").val();
        var planName = $("#planName").val();
        var term = $("#term").val();
        var startTimeVal = $("#startTime").val();
        var endTimeVal = $("#endTime").val();
        var startTime = new Date($("#startTime").val().replace('T', ' ')).getTime();
        var endTime = new Date($("#endTime").val().replace('T', ' ')).getTime();
        if (planName == "" || planName == undefined || planName == null) {
            swal({
                title: "请填写计划名称！",
                type: "info"
            });
            return;
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if (startTimeVal == "" || startTimeVal == undefined || startTimeVal == null) {
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if (endTimeVal == "" || endTimeVal == undefined || endTimeVal == null) {
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }
        if (startTime > endTime) {
            swal({
                title: "开始日期不能晚于结束日期！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/textbook/saveTextBookPlan", {
            id:planId,
            planName: $("#planName").val(),
            term: $("#term").val(),
            startTime: startTimeVal,
            endTime: endTimeVal
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#textBookGrid').DataTable().ajax.reload();
            }
        })
    }
</script>