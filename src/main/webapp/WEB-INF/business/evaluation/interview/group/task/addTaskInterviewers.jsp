<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        评教任务名称
                    </div>
                    <div class="col-md-9">
                        <input id="taskName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="30" placeholder="最多输入30个字"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        评教方案
                    </div>
                    <div class="col-md-9">
                        <select id="planId"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        评委组
                    </div>
                    <div class="col-md-9">
                        <select id="groupId"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        被评人组
                    </div>
                    <div class="col-md-9">
                        <select id="empGroupId"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        开始时间
                    </div>
                    <div class="col-md-9">
                        <input id="start" type="date">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        结束时间
                    </div>
                    <div class="col-md-9">
                        <input id="end" type="date">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="remark"
                                  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                                  maxlength="160" placeholder="最多输入160个字"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()" id="saveBtn">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    var eType = '2';
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        var data = ${data};
        addOption(data.xq, 'term');
        addOption(data.type, 'taskType','${taskType}');
        addOption(data.plan, 'planId');
        addOption(data.group, 'groupId');

        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " group_id  ",
                text: " group_name ",
                tableName: " T_KH_EVALUATION_EMP_GROUP ",
                where: " where valid_flag = '1' and create_dept =${createDept} and EVALUATION_TYPE ='"+eType+"'",
                orderby: "  "
            },
            function (data) {
                addOption(data, 'empGroupId');
            });
    })

    function save() {
        var taskName = $("#taskName").val();
        var planId = $("#planId option:selected").val();
        var groupId = $("#groupId option:selected").val();
        var term = $("#term option:selected").val();
        var taskType = $("#taskType option:selected").val();
        var empGroupId = $("#empGroupId option:selected").val();
        var startTime = $("#start").val();
        var endTime = $("#end").val();
        var remark = $("#remark").val();
        if (taskName == "" || taskName == null) {
            swal({
                title: "名称不能为空！",
                type: "info"
            });
            return;
        }
        if (planId == "" || planId == null) {
            swal({
                title: "请选择评教方案！",
                type: "info"
            });
            return;
        }
        if (groupId == "" || groupId == null) {
            swal({
                title: "请选择评委组！",
                type: "info"
            });
            return;
        }
        if (term == "" || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if (empGroupId == "" || empGroupId == null) {
            swal({
                title: "请选择被评人组！",
                type: "info"
            });
            return;
        }
        if (startTime == "" || startTime == null) {
            swal({
                title: "开始时间不能为空！",
                type: "info"
            });
            return;
        }
        if (endTime == "" || endTime == null) {
            swal({
                title: "结束时间不能为空！",
                type: "info"
            });
            return;
        }
        if (startTime > endTime) {
            swal({
                title: "开始时间不能大于结束时间！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/evaluation/saveTask", {
            taskName: taskName,
            planId: planId,
            groupId: groupId,
            term: term,
            taskType: '6',
            startTime: startTime,
            endTime: endTime,
            remark: remark,
            empGroupId: empGroupId,
            evaluationType:eType,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal("hide");
            taskTable.ajax.reload();
        })
    }
</script>